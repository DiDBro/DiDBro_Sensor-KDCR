clearvars, clc

% =========================================================================
% initialize_simulink.m
% 初始化 Homework 7 的所有参数
% 参数来源：
%   - 几何/质量/惯量/摩擦/初始条件 → May 27, 2026 tutorial (Moodle)
%   - 旋量方法 → MLS 例 4.4, p.177
%   - 圆角阶跃 → June 3, 2026 tutorial (Moodle)
%   - 控制系统 → 题目 (a)(b)(c)(d)
% =========================================================================

%% ===== 1. 几何参数（May 27 tutorial）=====
l0 = 0.3;       % 末端偏移 [m]
l1 = 0.9;       % 连杆1长度 [m]
l2 = 0.7;       % 连杆2长度 [m]

%% ===== 2. 关节旋量 xi（空间坐标系，MLS 例 4.4）=====
omega1 = [0; 0; 1];
omega2 = omega1;
omega3 = omega1;
v4     = [0; 0; 1];            % 移动关节方向
q1 = [0; 0; 0];                % 关节1轴上一点
q2 = [0; l1; 0];               % 关节2轴上一点
q3 = [0; l1 + l2; 0];          % 关节3轴上一点

xi1 = [-hatm_num(omega1)*q1; omega1];
xi2 = [-hatm_num(omega2)*q2; omega2];
xi3 = [-hatm_num(omega3)*q3; omega3];
xi4 = [v4; zeros(3,1)];

xi = [xi1, xi2, xi3, xi4];     % 6×4 旋量矩阵

%% ===== 3. 连杆质量与惯量（May 27 tutorial）=====
m1 = 35;
m2 = 25;
m3 = 18;
m4 = 7;

% 连杆 1 惯量: I_x = I_z = m*l^2/12, I_y = 0.05*I_x
Ix1 = m1 * l1^2 / 12;
Iz1 = Ix1;
Iy1 = 0.05 * Ix1;

% 连杆 2 惯量: I_x = I_z = m*l^2/12, I_y = 0.05*I_x
Ix2 = m2 * l2^2 / 12;
Iz2 = Ix2;
Iy2 = 0.05 * Ix2;

% 连杆 3 惯量: I_z3 = 0.1*I_z2, I_x3 = I_y3 = 0.2*I_z3
Iz3 = 0.1 * Iz2;
Ix3 = 0.2 * Iz3;
Iy3 = 0.2 * Iz3;

% 连杆 4（末端）惯量: I_z4 = 0.6*I_z3, I_x4 = I_y4 = 0.2*I_z4
Iz4 = 0.6 * Iz3;
Ix4 = 0.2 * Iz4;
Iy4 = 0.2 * Iz4;

%% ===== 4. 连体坐标系下的广义惯性矩阵 M_i（公式 4.9, p.162）=====
calM1 = [m1*eye(3) zeros(3); zeros(3) diag([Ix1 Iy1 Iz1])];
calM2 = [m2*eye(3) zeros(3); zeros(3) diag([Ix2 Iy2 Iz2])];
calM3 = [m3*eye(3) zeros(3); zeros(3) diag([Ix3 Iy3 Iz3])];
calM4 = [m4*eye(3) zeros(3); zeros(3) diag([Ix4 Iy4 Iz4])];

%% ===== 5. 参考位形 g_{sl_i}(0)（MLS 例 4.4）=====
% 质心位置（May 27 tutorial）
r1 = 0.4 * l1;      % 连杆1质心
r2 = 0.45 * l2;     % 连杆2质心

gsl10 = [eye(3) [0; r1; 0.3];       zeros(1,3), 1];
gsl20 = [eye(3) [0; l1+r2; 0.4];    zeros(1,3), 1];
gsl30 = [eye(3) [0; l1+l2; 0.5];    zeros(1,3), 1];
gsl40 = [eye(3) [0; l1+l2; l0];     zeros(1,3), 1];

%% ===== 6. 空间惯性矩阵 calMp（公式 4.28, p.176）=====
Adgsl10   = adjmg(gsl10);
Adgsl10m1 = inv(Adgsl10);
Adgsl20   = adjmg(gsl20);
Adgsl20m1 = inv(Adgsl20);
Adgsl30   = adjmg(gsl30);
Adgsl30m1 = inv(Adgsl30);
Adgsl40   = adjmg(gsl40);
Adgsl40m1 = inv(Adgsl40);

calMp            = Adgsl10m1' * calM1 * Adgsl10m1;
calMp(1:6,1:6,2) = Adgsl20m1' * calM2 * Adgsl20m1;
calMp(1:6,1:6,3) = Adgsl30m1' * calM3 * Adgsl30m1;
calMp(1:6,1:6,4) = Adgsl40m1' * calM4 * Adgsl40m1;

%% ===== 7. 粘性摩擦系数（May 27 tutorial）=====
beta1 = 0.9;    % Nms/rad
beta2 = 0.45;   % Nms/rad
beta3 = 0.4;    % Nms/rad
beta4 = 0.9;    % Ns/m

beta = [beta1, beta2, beta3, beta4];    % 行向量
m4g = m4 * 9.81;                        % 末端重力 [N]

%% ===== 8. 耦合矩阵 lM =====
lM = zeros(4);
for ii = 1:4
    for jj = 1:4
        lM(ii, jj) = max([ii, jj]);
    end
end

%% ===== 9. 初始关节角度和角速度（May 27 tutorial）=====
theta1 = 0.3 * pi;      % = 0.9425 rad ≈ 54°
theta2 = 0.2 * pi;      % = 0.6283 rad ≈ 36°
theta3 = 0.35 * pi;     % = 1.0996 rad ≈ 63°
theta4 = -0.03;         % = -0.03 m

theta  = [theta1, theta2, theta3, theta4];      % 行向量（供 MCN 测试用）

% 初始角速度（May 27 tutorial）
dtheta1_val = 0.08;     % rad/s
dtheta2_val = 0.15;     % rad/s
dtheta3_val = 0.25;     % rad/s
dtheta4_val = 0.07;     % m/s

dtheta = [dtheta1_val, dtheta2_val, dtheta3_val, dtheta4_val];  % 行向量（供 MCN 测试用）

% 积分器初始条件（列向量，供 Simulink 使用）
theta0  = [theta1; theta2; theta3; theta4];
dtheta0 = [dtheta1_val; dtheta2_val; dtheta3_val; dtheta4_val];

%% ===== 10. 动力学测试（离线验证）=====
[M, C, N] = MCN(xi, calMp, lM, beta, m4g, theta, dtheta);
disp('MCN 离线测试通过');
disp(['  M = ' mat2str(M, 4)]);
disp(['  C = ' mat2str(C, 4)]);
disp(['  N = ' mat2str(N, 4)]);

%% ===== 11. 加载圆角阶跃数据 =====
load y-yd-ydd.mat
load ts2.mat

%% ===== 12. 圆角阶跃时间参数（June 3 tutorial）=====
% 时间分区：    t ≤ st0 | st0<t≤st1 | st1<t≤st2 | st2<t≤st3 | t > st3
% 对应阶段：    保持0  | 五次加速   | 匀速       | 五次减速   | 保持1
st0 = 1.0;                      % 阶跃开始 [s]
st1 = st0 + 0.1;                % 加速结束 = 1.1s
st2 = st0 + 0.3;                % 匀速结束 = 1.3s
st3 = st0 + 0.4;                % 阶跃完成 = 1.4s

%% ===== 13. 期望轨迹终值（题目 (a)）=====
% 关节1,2,3 → 2, 1, 0.5 rad
% 关节4     → 0.08 m
amp = [2; 1; 0.5; 0.08];

%% ===== 14. 控制器增益 =====
% 闭环误差动力学：ë + K_v·ė + K_p·e = 0
% ω_n = 50 rad/s, ζ = 1（临界阻尼）
omega_n = 50;
zeta    = 1;
K_p_val = omega_n^2;                % = 2500
K_v_val = 2 * zeta * omega_n;       % = 100

%% ===== 15. 力矩饱和限值（题目 (d)）=====
% |τ| ≤ [6000, 2000, 1000, 100]^T  [Nm] / [N]
tau_max = [6000; 2000; 1000; 100];

%% ===== 16. 鲁棒性扰动（题目 (b)）=====
% 做 (b) 时修改此值：±0.05 或 ±0.10
delta_perturbation = 0;

%% ===== 17. 仿真时间 =====
T_sim = 5;  % [s]

%% ===== 完成 ====
fprintf('========================================\n');
fprintf(' initialize_simulink.m 运行完成\n');
fprintf('========================================\n');
fprintf(' 几何:   l0=%.1f, l1=%.1f, l2=%.1f, r1=%.3f, r2=%.3f\n', l0, l1, l2, r1, r2);
fprintf(' 质量:   m=[%d, %d, %d, %d] kg\n', m1, m2, m3, m4);
fprintf(' 摩擦:   beta=[%.2f, %.2f, %.2f, %.2f]\n', beta);
fprintf(' 期望幅值: amp=[%g; %g; %g; %g]\n', amp);
fprintf(' 控制器: K_p=%d, K_v=%d (ω_n=%d, ζ=%.1f)\n', K_p_val, K_v_val, omega_n, zeta);
fprintf(' 饱和限值: tau_max=[%d; %d; %d; %d]\n', tau_max);
fprintf(' 初始θ:  [%.4f; %.4f; %.4f; %.4f]\n', theta0);
fprintf(' 初始θ̇: [%.2f; %.2f; %.2f; %.2f]\n', dtheta0);
fprintf('========================================\n');
