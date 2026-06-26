%% Tutorial April 29 — 3R SCARA-like Inverse Kinematics
%  Manipulator "almost like MLS Example 3.2 p. 89"
%  All 3 revolute joints with ω || z-axis (planar arm at fixed height l0)
%
%  gst(θ) = exp(ξ̂₁θ₁) · exp(ξ̂₂θ₂) · exp(ξ̂₃θ₃) · gst(0)
%
%  Link lengths: l0 = 1.3, l1 = 1.1, l2 = 0.9

clearvars; clc; close all;
addpath(fileparts(fileparts(mfilename('fullpath'))));  % add Codes/ to path
import robo.*

%% ===== Step 0: 读取数据 =====
l0 = 1.3;   % z 高度 (所有关节在同一水平面)
l1 = 1.1;   % 连杆 1 长度
l2 = 0.9;   % 连杆 2 长度

gst0 = readmatrix('April_29_gst0.xlsx');   % gst(0), 参考构型下的工具位姿
gd   = readmatrix('April_29_gst.xlsx');     % 目标构型 gd

disp('=== 参考构型 gst(0) ==='); disp(gst0);
disp('=== 目标构型 gd ===');     disp(gd);

%% ===== Step 1: 定义 twists (基于参考构型几何) =====
%  参考构型：机械臂完全沿 y 轴伸展, 关节均在 z = l0 平面
%  所有 ω = [0;0;1] (绕 z 轴旋转)
%
%  关节轴上点 (参考构型中)：
%    q1 = [0; 0; 0]    — 关节 1 位于基座
%    q2 = [0; l1; 0]   — 关节 2 位于连杆 1 末端
%    q3 = [0; l1+l2; 0] — 关节 3 位于连杆 2 末端 (腕部)
%
%  Revolute twist: ξ = [v; ω],  v = -ω × q

% Joint 1: z-axis at origin
omega1 = [0; 0; 1];
q1     = [0; 0; 0];
v1     = -cross(omega1, q1);
xi1    = [v1; omega1];

% Joint 2: z-axis at end of link 1
omega2 = [0; 0; 1];
q2     = [0; l1; 0];
v2     = -cross(omega2, q2);
xi2    = [v2; omega2];

% Joint 3: z-axis at end of link 2
omega3 = [0; 0; 1];
q3     = [0; l1 + l2; 0];
v3     = -cross(omega3, q3);
xi3    = [v3; omega3];

disp('=== Twist 参数 ===');
fprintf('ξ₁ = [%.1f; %.1f; %.1f; %.1f; %.1f; %.1f]\n', xi1);
fprintf('ξ₂ = [%.1f; %.1f; %.1f; %.1f; %.1f; %.1f]\n', xi2);
fprintf('ξ₃ = [%.1f; %.1f; %.1f; %.1f; %.1f; %.1f]\n', xi3);

%% ===== Step 2: 计算相对变换 G = gd · gst(0)⁻¹ =====
%  gst(θ) = e^(ξ̂₁θ₁) e^(ξ̂₂θ₂) e^(ξ̂₃θ₃) gst(0) = gd
%  → e^(ξ̂₁θ₁) e^(ξ̂₂θ₂) e^(ξ̂₃θ₃) = gd · gst(0)⁻¹ =: G

G_rel = gd / gst0;   % 等价于 gd * inv(gst0)
R_rel = G_rel(1:3, 1:3);
p_rel = G_rel(1:3, 4);

disp('=== 相对变换 G ==='); disp(G_rel);

%% ===== Step 3: 提取总旋转角和腕部位置 =====
%  所有 ω || z → 总旋转 = θ₁ + θ₂ + θ₃
%  R = R_z(θ_total)

theta_total = atan2(R_rel(2,1), R_rel(1,1));
fprintf('\n总旋转角 θ_total = θ₁+θ₂+θ₃ = %.4f rad = %.2f°\n', ...
        theta_total, rad2deg(theta_total));

% ===== Step 4: 平面 3R 逆运动学 =====
%  目标工具位置 (xy 平面, z 固定 = gst0_z)
x_d = gd(1,4);
y_d = gd(2,4);
z_d = gd(3,4);   % 应 = gst0_z = l0, 见下方注释

fprintf('\n=== 目标位置 ===');
fprintf('\n  x = %.4f, y = %.4f, z = %.4f\n', x_d, y_d, z_d);
fprintf('  (注: z 坐标因所有关节均绕 z 轴旋转而不变, 始终为 l0 = %.1f)\n', l0);

%  腕部中心 = 工具位置 (因工具直接位于关节 3 上, 无 xy 工具偏移)
w_x = x_d;
w_y = y_d;

%  余弦定理求 θ₂
d_sq = w_x^2 + w_y^2;
d    = sqrt(d_sq);
fprintf('\n腕部距基座距离 d = %.4f\n', d);

%  可达性检查
if d > l1 + l2 + 1e-6 || d < abs(l1 - l2) - 1e-6
    error('目标位置不可达: d = %.4f, 范围 = [%.4f, %.4f]', d, abs(l1-l2), l1+l2);
end

cos_theta2 = (d_sq - l1^2 - l2^2) / (2 * l1 * l2);
cos_theta2 = max(-1, min(1, cos_theta2));   % 数值稳定性

%  肘部向上 (elbow-up): θ₂ < 0, 肘部向下 (elbow-down): θ₂ > 0
theta2_up   = -acos(cos_theta2);
theta2_down =  acos(cos_theta2);

fprintf('cos(θ₂) = %.4f\n', cos_theta2);
fprintf('θ₂ (elbow up)   = %.4f rad = %.2f°\n', theta2_up,   rad2deg(theta2_up));
fprintf('θ₂ (elbow down) = %.4f rad = %.2f°\n', theta2_down, rad2deg(theta2_down));

%  选肘部向下 (elbow-down) 作为解
theta2 = theta2_down;

%  求 θ₁
psi = atan2(w_y, w_x);
alpha = atan2(l2 * sin(theta2), l1 + l2 * cos(theta2));
theta1 = psi - alpha;

%  求 θ₃
theta3 = theta_total - theta1 - theta2;

%  归一化到 [-pi, pi]
theta1 = wrapToPi(theta1);
theta2 = wrapToPi(theta2);
theta3 = wrapToPi(theta3);

fprintf('\n============= IK 结果 =============\n');
fprintf('θ₁ = %10.4f rad = %8.2f°\n', theta1, rad2deg(theta1));
fprintf('θ₂ = %10.4f rad = %8.2f°\n', theta2, rad2deg(theta2));
fprintf('θ₃ = %10.4f rad = %8.2f°\n', theta3, rad2deg(theta3));
fprintf('Σθ  = %10.4f rad = %8.2f° (应 = %.2f°)\n', ...
        theta1+theta2+theta3, rad2deg(theta1+theta2+theta3), rad2deg(theta_total));

%% ===== Step 5: 正运动学验证 (POE) =====
disp(' ');
disp('============= 正运动学验证 =============');

%  用 gtwist 逐关节计算
g_01 = gtwist(xi1, theta1);
g_12 = gtwist(xi2, theta2);
g_23 = gtwist(xi3, theta3);

gst_computed = g_01 * g_12 * g_23 * gst0;

disp('计算得到的 gst(θ):');  disp(gst_computed);
disp('目标 gd:');            disp(gd);
disp('误差 gst - gd:');       disp(gst_computed - gd);
fprintf('位置误差 ||p|| = %.4e\n', norm(gst_computed(1:3,4) - gd(1:3,4)));
fprintf('旋转误差 ||R|| = %.4e\n', norm(gst_computed(1:3,1:3) - gd(1:3,1:3)));

%% ===== Step 6: 验证单步 (直接用 G2twist) =====
disp(' ');
disp('============= 用 G2twist 直接提取总 twist ==========');
[xi_total, theta_check] = G2twist(G_rel);
fprintf('总 twist: ω = [%.4f; %.4f; %.4f], v = [%.4f; %.4f; %.4f]\n', ...
        xi_total(4:6), xi_total(1:3));
fprintf('总旋转角 = %.4f rad\n', theta_check);

%  验证一个关节的 exp 是否可复现 G
G_from_total = gtwist(xi_total, theta_check);
fprintf('用总 twist 重构 G 的误差: ||G - exp(ξ̂θ)|| = %.4e\n', ...
        norm(G_from_total - G_rel));
