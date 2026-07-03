%% ===========================================================================
% Homework 6: Newton-Euler Analysis of a Spinning Propeller on a Turning Aircraft
% Kinematics, Dynamics and Control of Robots — 2026
% ===========================================================================
% 问题描述 / Problem Description:
%   一架飞机在水平圆弧轨迹上飞行。机体坐标系 (airframe frame) 定义为:
%     x — 飞机右侧 (right)
%     y — 飞机前方 (forward)
%     z — 飞机上方 (upward)
%
%   飞机以恒定角速度 ωp 绕机体 z 轴进动 (precession)。
%   螺旋桨以恒定转速 ωs 绕机体 y 轴自转 (spin)。
%
%   分析中还需要一个固连在螺旋桨上的体坐标系 (body frame):
%     y 轴 — 始终与机体 y 轴平行（即螺旋桨轴方向）
%     z 轴 — （a）两叶桨时沿其中一个叶片方向；
%            （b）八叶桨时在桨盘平面内任意方向
%
%   目标: 用 Newton-Euler 方程计算螺旋桨轴对螺旋桨施加的力矩 (torque)，
%         在三种不同转角 θ 下，分别在 body frame 和 airframe frame 中表示。
%
% 给定数值 / Given Values:
%   ωs = 420 rad/s  (螺旋桨自转角速度)
%   ωp = 0.1 rad/s   (飞机进动角速度)
%   Part (a): I = 2.26 kg·m²  (细杆绕 diametral 轴的转动惯量)
%   Part (b): I = 4.52 kg·m²  (薄圆盘绕直径轴的转动惯量)
% ============================================================================

clc; clear;
import robo.*

%% ===========================================================================
% 1. 符号变量与运动学 / Symbolic Variables & Kinematics
% ===========================================================================
% 符号变量: omega_p = ωp (进动角速率), omega_s = ωs (自转角速率),
%           I = 转动惯量参数, theta = θ (桨盘相对初始位置的转角)
syms omega_p omega_s I theta real

% ---------------------------------------------------------------------------
% 1.1 旋转矩阵 / Rotation Matrix
% Body frame 相对 Airframe frame 绕 y 轴旋转 θ 角。
% Rafb = R_y(θ): 将 body-frame 坐标变换到 airframe-frame 坐标。
% R_y(θ) = [ cosθ,  0,  sinθ;
%              0,   1,    0;
%           -sinθ,  0,  cosθ ]
% ---------------------------------------------------------------------------
Rafb = [cos(theta), 0, sin(theta);
        0,          1, 0;
       -sin(theta), 0, cos(theta)];   % body → airframe 的旋转矩阵

% ---------------------------------------------------------------------------
% 1.2 角速度在 Body Frame 中的表达式 / Angular Velocity in Body Frame
% 螺旋桨的绝对角速度 = 相对自转 + 牵连进动
%   ω_b = ω_{body/airframe} + R_afb^T · ω_af
% 其中:
%   ω_{body/airframe} = [0; ωs; 0]     (螺旋桨相对机体的自转，沿 y 轴)
%   ω_af             = [0; 0; ωp]      (机体在惯性空间中的进动，沿 z 轴)
%   R_afb^T = Ry(-θ)                   (airframe → body 的旋转变换)
% ---------------------------------------------------------------------------
omega_body_rel = [0; omega_s; 0];                  % 相对自转角速度
omega_af       = [0; 0; omega_p];                   % 机体进动角速度
omega_b        = omega_body_rel + Rafb.' * omega_af; % 绝对角速度 (body frame)

% ---------------------------------------------------------------------------
% 1.3 角加速度在 Body Frame 中的表达式 / Angular Acceleration in Body Frame
% α_b = d(ω_b)/dt  在 body frame 中求导。
%
% ω_b = [0; ωs; 0] + R(-θ)·[0; 0; ωp]
%
% 第一项 [0; ωs; 0] = 常数 → 导数为 0。
% 第二项的导数: d/dt[R(-θ)·ω_af]
%   由于 ω_af 是常矢量，只需对旋转矩阵求导:
%   d/dt[R(-θ)·ω_af] = dR(-θ)/dt · ω_af
%   其中 dθ/dt = ωs, dR(-θ)/dt = ωs · dR(-θ)/dθ
%
% 等价地用叉积形式: α_b = -hatm([0;ωs;0]) · R_afb^T · [0;0;ωp]
%   (负号来源于 transport theorem: d/dt|_body = d/dt|_airframe - ω_rel ×)
% ---------------------------------------------------------------------------
dot_omega_b = -hatm([0; omega_s; 0]) * Rafb.' * [0; 0; omega_p];

% 显示推导结果
fprintf('=== 运动学推导 / Kinematics Derivation ===\n');
fprintf('ω_b (angular velocity in body frame) =\n');
disp(omega_b);
fprintf('α_b = dω_b/dt (angular acceleration in body frame) =\n');
disp(dot_omega_b);
fprintf('\n');

%% ===========================================================================
% 2. 牛顿-欧拉方程 / Newton-Euler Equations
% ===========================================================================
% 对于刚体，在 body frame 中:
%   τ = I·α + ω × (I·ω)
%
% 其中:
%   τ — 外界对刚体施加的合力矩 (此处为桨轴对螺旋桨的力矩)
%   I — 在 body frame 中表示的转动惯量矩阵 (常数矩阵)
%   α — 角加速度在 body frame 中的表达式
%   ω — 角速度在 body frame 中的表达式
%
% 公式拆分为两项:
%   τ₁ = I·α          (欧拉项 / Euler term — 角加速引起的力矩)
%   τ₂ = ω × (I·ω)    (回转项 / Gyroscopic term — 角速度方向变化引起的力矩)
%   τ  = τ₁ + τ₂
% ============================================================================

%% ===========================================================================
% 3. Part (a): 两叶螺旋桨 (细杆模型) / Two-Bladed Propeller (Slender Bar)
% ===========================================================================
% 物理模型:
%   - 两片桨叶沿 body frame z 轴方向，等效为一根细杆
%   - 细杆绕 x 轴和 y 轴的转动惯量均为 I = 2.26 kg·m²
%   - 细杆绕自身轴线 (z 轴) 的转动惯量为 0
%
% 转动惯量矩阵 (在 body frame 中):
%   I_a = diag([I, I, 0])
%
%  说明: I_xx = I (质量分布在 z 轴, 距离 x 轴为 |z|)
%        I_yy = I (质量分布在 z 轴, 距离 y 轴为 |z|)
%        I_zz = 0 (质量集中在 z 轴上, 绕 z 轴无转动惯量)
% ============================================================================

fprintf('========== PART (a): TWO-BLADED PROPELLER ==========\n\n');

II_a  = diag([I, I, 0]);    % 符号形式的转动惯量矩阵
I_val = 2.26;               % 数值: I = 2.26 kg·m²

fprintf('转动惯量矩阵 / Inertia matrix in body frame:\n');
fprintf('  I_a = diag([I, I, 0])  with I = %.2f kg·m²\n\n', I_val);

% --- 符号推导 / Symbolic Derivation ---
% 欧拉项: τ₁ = I·α
tau_b1_a = II_a * dot_omega_b;

% 回转项: τ₂ = ω × (I·ω)
tau_b2_a = hatm(omega_b) * II_a * omega_b;

% 总力矩 (body frame 中)
tau_b_a = tau_b1_a + tau_b2_a;

% 转换到 airframe frame: τ_af = Rafb · τ_b
tau_af_a = Rafb * tau_b_a;

fprintf('符号推导完成 / Symbolic derivation completed.\n');
fprintf('τ_b (body frame) = \n');
pretty(tau_b_a);
fprintf('\n');

% --- 数值计算: 三种 θ 角度 / Numerical Evaluation for 3 Cases ---
theta_cases = [0, pi/4, pi/2];
theta_names = {'0', 'π/4', 'π/2'};

fprintf('--- Part (a) 数值结果 / Numerical Results ---\n\n');

for i = 1:3
    th = theta_cases(i);
    fprintf('Case %d: θ = %s rad\n', i, theta_names{i});

    % 代入数值: I=2.26, ωp=0.1, ωs=420, θ=当前值
    tau_b_num  = double(subs(tau_b_a,  [I, omega_p, omega_s, theta], ...
                                      [I_val, 0.1, 420, th]));
    tau_af_num = double(subs(tau_af_a, [I, omega_p, omega_s, theta], ...
                                      [I_val, 0.1, 420, th]));

    fprintf('  τ 在 body frame 中 / Torque in body frame:\n');
    fprintf('    τ_b = [%10.6f; %10.6f; %10.6f] N·m\n', tau_b_num);
    fprintf('  τ 在 airframe frame 中 / Torque in airframe frame:\n');
    fprintf('    τ_af = [%10.6f; %10.6f; %10.6f] N·m\n', tau_af_num);
    fprintf('\n');

    % 存储结果供后续比较
    results_a_b{i}  = tau_b_num;
    results_a_af{i} = tau_af_num;
end

%% ===========================================================================
% 4. Part (b): 八叶螺旋桨 (薄圆盘模型) / Eight-Bladed Propeller (Thin Disk)
% ===========================================================================
% 物理模型:
%   - 八片桨叶近似为一个薄圆盘，圆盘平面为 x-z 平面 (body frame)
%   - y 轴垂直于圆盘平面 (即螺旋桨轴方向)
%   - 绕直径轴的转动惯量 I = 4.52 kg·m²
%   - 绕垂直于盘面轴 (y 轴) 的转动惯量为 2I = 9.04 kg·m²
%     (薄圆盘: I_axial = 2 * I_diametral)
%
% 转动惯量矩阵 (在 body frame 中):
%   I_b = diag([I, 2I, I])
%
%  说明: I_xx = I_zz = I (直径轴 / diametral axes)
%        I_yy = 2I        (垂直于盘面的轴 / axis normal to disk)
% ============================================================================

fprintf('========== PART (b): EIGHT-BLADED PROPELLER ==========\n\n');

II_b  = diag([I, 2*I, I]);  % 符号形式
I_val_b = 4.52;             % 数值: I = 4.52 kg·m²

fprintf('转动惯量矩阵 / Inertia matrix in body frame:\n');
fprintf('  I_b = diag([I, 2I, I])  with I = %.2f kg·m²\n', I_val_b);
fprintf('  (I_yy = 2I = %.2f kg·m², axial moment)\n\n', 2*I_val_b);

% --- 符号推导 / Symbolic Derivation ---
% 运动学关系与 part (a) 完全相同 (ω_b, α_b 不变)
% 仅转动惯量矩阵不同

% 欧拉项: τ₁ = I·α
tau_b1_b = II_b * dot_omega_b;

% 回转项: τ₂ = ω × (I·ω)
tau_b2_b = hatm(omega_b) * II_b * omega_b;

% 总力矩 (body frame)
tau_b_b = tau_b1_b + tau_b2_b;

% 转换到 airframe frame
tau_af_b = Rafb * tau_b_b;

fprintf('符号推导完成 / Symbolic derivation completed.\n');
fprintf('τ_b (body frame) = \n');
pretty(tau_b_b);
fprintf('\n');

% --- 数值计算: 三种 θ 角度 ---
fprintf('--- Part (b) 数值结果 / Numerical Results ---\n\n');

for i = 1:3
    th = theta_cases(i);
    fprintf('Case %d: θ = %s rad\n', i, theta_names{i});

    tau_b_num  = double(subs(tau_b_b,  [I, omega_p, omega_s, theta], ...
                                      [I_val_b, 0.1, 420, th]));
    tau_af_num = double(subs(tau_af_b, [I, omega_p, omega_s, theta], ...
                                      [I_val_b, 0.1, 420, th]));

    fprintf('  τ 在 body frame 中 / Torque in body frame:\n');
    fprintf('    τ_b = [%10.6f; %10.6f; %10.6f] N·m\n', tau_b_num);
    fprintf('  τ 在 airframe frame 中 / Torque in airframe frame:\n');
    fprintf('    τ_af = [%10.6f; %10.6f; %10.6f] N·m\n', tau_af_num);
    fprintf('\n');

    results_b_b{i}  = tau_b_num;
    results_b_af{i} = tau_af_num;
end

%% ===========================================================================
% 5. 汇总与比较 / Summary and Comparison
% ===========================================================================
fprintf('========== 汇总表格 / SUMMARY TABLE ==========\n\n');
fprintf('%-12s %-35s %-35s\n', '', 'Body Frame τ_b [N·m]', 'Airframe Frame τ_af [N·m]');
fprintf('%-12s %-35s %-35s\n', 'Case', ...
       '[τ_x, τ_y, τ_z]', '[τ_x, τ_y, τ_z]');
fprintf('%s\n', repmat('-', 1, 94));

% Part (a) results
fprintf('--- Part (a): Two-Bladed Propeller (I=2.26) ---\n');
for i = 1:3
    tb = results_a_b{i};
    ta = results_a_af{i};
    fprintf('θ=%-9s [%8.4f, %8.4f, %8.4f]   [%8.4f, %8.4f, %8.4f]\n', ...
            theta_names{i}, tb(1), tb(2), tb(3), ta(1), ta(2), ta(3));
end

fprintf('\n--- Part (b): Eight-Bladed Propeller (I=4.52, I_axial=9.04) ---\n');
for i = 1:3
    tb = results_b_b{i};
    ta = results_b_af{i};
    fprintf('θ=%-9s [%8.4f, %8.4f, %8.4f]   [%8.4f, %8.4f, %8.4f]\n', ...
            theta_names{i}, tb(1), tb(2), tb(3), ta(1), ta(2), ta(3));
end

%% ===========================================================================
% 6. 分析与结论 / Analysis and Conclusions
% ===========================================================================
fprintf('\n========== 分析与结论 / ANALYSIS AND CONCLUSIONS ==========\n\n');

fprintf(['1. 力矩的物理来源 / Physical Origin of Torque:\n' ...
         '   螺旋桨轴对螺旋桨施加的力矩主要来自陀螺效应 (gyroscopic effect)。\n' ...
         '   当高速旋转的螺旋桨被迫绕另一轴进动时，会产生陀螺力矩。\n' ...
         '   此力矩方向垂直于自转轴和进动轴。\n\n']);

fprintf(['2. Part (a) vs Part (b) 的比较:\n' ...
         '   - 两叶桨 (细杆) 的转动惯量矩阵 I_a = diag([I, I, 0])，\n' ...
         '     I_zz = 0 导致力矩的 y 分量和 z 分量均很小或为零。\n' ...
         '   - 八叶桨 (圆盘) 的转动惯量矩阵 I_b = diag([I, 2I, I])，\n' ...
         '     I_yy = 2I 意味着绕自转轴的转动惯量远大于两叶桨，\n' ...
         '     因此陀螺力矩的幅值更大 (约 2 倍)。\n' ...
         '   - 对于圆盘模型，τ_af 在 airframe frame 中为常矢量:\n' ...
         '     τ_af = [-2I·ωs·ωp; 0; 0]，与 θ 无关。\n' ...
         '     这符合物理直觉——轴对称转子的陀螺力矩在空间中是恒定的。\n\n']);

fprintf(['3. θ 角度对力矩的影响:\n' ...
         '   - θ = 0 (桨叶在初始位置): 力矩最大，主要是 x 分量。\n' ...
         '   - θ = π/4: Part (a) 的力矩 x 分量减小约 30%%，Part (b) 的力矩\n' ...
         '     在 body frame 中出现 z 分量，但在 airframe frame 中仍只有 x 分量。\n' ...
         '   - θ = π/2: Part (a) 的力矩完全消失 (细杆沿 x 轴时无陀螺效应)。\n' ...
         '     Part (b) 的力矩在 body frame 中表现为纯 z 分量，\n' ...
         '     转换到 airframe frame 后仍为纯 x 分量。\n\n']);

fprintf(['4. Body Frame vs Airframe Frame:\n' ...
         '   - 在 body frame 中，力矩随 θ 变化 (对于两个模型均是如此)。\n' ...
         '   - 在 airframe frame 中:\n' ...
         '     · Part (a): τ_af 也随 θ 有显著变化 (因为结构非轴对称)。\n' ...
         '     · Part (b): τ_af = [-2I·ωs·ωp; 0; 0] = 常数!\n' ...
         '       这验证了旋转对称结构的陀螺力矩在惯性空间中方向恒定。\n\n']);

fprintf(['5. 实际意义 / Practical Implications:\n' ...
         '   - 对于轴对称的八叶桨，飞机转弯时桨轴承受一个恒定的\n' ...
         '     横向力矩 (约 -380 N·m)，方向沿 airframe -x 轴 (即飞机左侧)。\n' ...
         '   - 对于两叶桨，力矩随转角周期性变化 (从 -190 N·m 到 0)，\n' ...
         '     这会引起振动和疲劳问题。\n' ...
         '   - ωp² 项 (即 I·ωp² 级别的项) 数值极小 (~0.01 N·m)，\n' ...
         '     在实际工程中可忽略。主导项正比于 ωs·ωp = 42 rad²/s²。\n\n']);

fprintf('========== END OF ANALYSIS ==========\n');
