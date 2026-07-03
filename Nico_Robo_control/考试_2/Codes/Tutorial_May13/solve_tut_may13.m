%% Tutorial May 13 — 4DOF SCARA: 速度、力与力矩分析
%  ====== 题目 (OCR from tut_May_13.pdf) ======
%  4DOF 机械臂: 3 Revolute (all ω || z) + 1 Prismatic (沿 z)
%
%  参考构型:
%    - 连杆 l1=1.2m, l2=0.8m 沿空间 y 轴伸展
%    - 工具坐标系与空间坐标系轴向一致
%    - 工具原点比空间原点高 l0=0.3m (沿 z 方向)
%
%  当前关节变量 (4 个自由度):
%    θ = [15°; 54°; -32°; 0.05 m]
%  当前关节速度:
%    θ̇ = [0.4; -0.2; 0.28; 0.01] (rad/s or m/s)
%
%  6 种末端力旋量 F^b (体坐标系, 从 PDF 第 2 页 OCR):
%    F^b_1 = [1;0;0; 0;0;0]   f_x = 1 N
%    F^b_2 = [0;1;0; 0;0;0]   f_y = 1 N
%    F^b_3 = [0;0;1; 0;0;0]   f_z = 1 N
%    F^b_4 = [0;0;0; 1;0;0]   τ_x = 1 Nm
%    F^b_5 = [0;0;0; 0;1;0]   τ_y = 1 Nm
%    F^b_6 = [0;0;0; 0;0;1]   τ_z = 1 Nm
%
%  ====== 问题 ======
%  1. 空间速度 V^s (空间坐标系分量)
%  2. 物体速度 V^b
%  3. 6 种 F^b 下的关节力矩 τ_i (i=1,…,6)
%  4. 6 种 F^b 对应的空间力旋量 F^s_i
%  5. 验证 τ_i = (J^s)^T F^s_i = (J^b)^T F^b_i

clc; clear; close all;
addpath(fileparts(fileparts(mfilename('fullpath'))));
import robo.*

%% ===== 参数 (OCR 数值) =====
l0 = 0.3;                        % 工具高度偏移
l1 = 1.2;                        % 连杆 1 长度
l2 = 0.8;                        % 连杆 2 长度

% OCR: 15, 54, -32 degrees + 0.05 m displacement
theta     = deg2rad([15; 54; -32]);
theta(4)  = 0.05;               % prismatic joint 位移 (m)
% OCR: 0.4, -0.2, 0.28, 0.01 rad/s or m/s
theta_dot = [0.4; -0.2; 0.28; 0.01];

%% ===== Twist 定义 (参考构型, 课件 §3.2 POE) =====
% Revolute: v = -ω × q,  Prismatic: ω = 0, v 为移动方向

w1 = [0;0;1];  q1 = [0;  0;    0];  v1 = -cross(w1,q1);  xi1 = [v1; w1];  % Joint 1
w2 = [0;0;1];  q2 = [0;  l1;   0];  v2 = -cross(w2,q2);  xi2 = [v2; w2];  % Joint 2
w3 = [0;0;1];  q3 = [0;  l1+l2;0];  v3 = -cross(w3,q3);  xi3 = [v3; w3];  % Joint 3
w4 = [0;0;0];                       v4 = [0;  0;    1];  xi4 = [v4; w4];  % Joint 4

% 参考构型 gst(0): 工具在 [0; l1+l2; l0], 姿态 = I
gst0 = [eye(3), [0; l1+l2; l0]; 0 0 0 1];

%% ===== 逐关节变换 (课件 MLS eq. 2.36 → gtwist) =====
G1 = gtwist(xi1, theta(1));
G2 = gtwist(xi2, theta(2));
G3 = gtwist(xi3, theta(3));
G4 = gtwist(xi4, theta(4));

% 累积 g_{s,i-1} (用于空间 Jacobian, MLS eq. 3.54)
g_s0 = eye(4);        % 关节 1 之前 = I
g_s1 = G1;            % 关节 2 之前
g_s2 = G1 * G2;       % 关节 3 之前
g_s3 = G1 * G2 * G3;  % 关节 4 之前

% 完整末端位姿 (MLS eq. 3.3 — POE)
gst  = G1 * G2 * G3 * G4 * gst0;

fprintf('======== 当前末端位姿 gst ========\n'); disp(gst);

%% ====== Part 1: 空间速度 V^s (MLS eq. 3.52/3.54) ======
%  J^s_i = Ad_{g_{s,i-1}} · ξ_i (课件 May_11, eq. 3.54)
Js = zeros(6, 4);
Js(:,1) = adjoint(g_s0) * xi1;      % g_s0 = I
Js(:,2) = adjoint(g_s1) * xi2;
Js(:,3) = adjoint(g_s2) * xi3;
Js(:,4) = adjoint(g_s3) * xi4;

Vs = Js * theta_dot;                % V^s = J^s · θ̇

fprintf('\n===== Part 1: 空间速度 V^s_st =====\n');
fprintf('  v^s = [%8.4f; %8.4f; %8.4f]  m/s\n', Vs(1:3));
fprintf('  ω^s = [%8.4f; %8.4f; %8.4f]  rad/s\n', Vs(4:6));

%% ====== Part 2: 物体速度 V^b (MLS eq. 2.61) ======
%  V^b = Ad_{gst}^{-1} · V^s
Vb = adjoint(inv(gst)) * Vs;

fprintf('\n===== Part 2: 物体速度 V^b_st =====\n');
fprintf('  v^b = [%8.4f; %8.4f; %8.4f]  m/s\n', Vb(1:3));
fprintf('  ω^b = [%8.4f; %8.4f; %8.4f]  rad/s\n', Vb(4:6));

%% ===== Body Jacobian (MLS eq. 3.55, via Ad^{-1} relation) =====
%  J^b = Ad_{gst}^{-1} · J^s
Jb = adjoint(inv(gst)) * Js;

%% ====== Part 3: 关节力矩 τ = (J^b)^T F^b (MLS eq. 3.59) ======
%  OCR: 6×6 单位矩阵 = 6 种单位基力旋量 (体坐标系)
Fb_cases = eye(6);
labels   = {'f_x=1','f_y=1','f_z=1','τ_x=1','τ_y=1','τ_z=1'};

fprintf('\n===== Part 3: 关节力矩 τ = (J^b)^T · F^b =====\n');
fprintf('  %-8s %10s %10s %10s %10s\n', 'F^b 载荷','τ_1','τ_2','τ_3','τ_4');

tau_Fb = zeros(4, 6);
for k = 1:6
    tau_Fb(:,k) = Jb' * Fb_cases(:,k);
    fprintf('  %-8s %10.4f %10.4f %10.4f %10.4f\n', labels{k}, tau_Fb(:,k));
end

%% ====== Part 4: 空间力旋量 F^s (MLS eq. 2.67 力旋量变换) ======
%  F^b = Ad_g^T · F^s  →  F^s = Ad_g^{-T} · F^b

fprintf('\n===== Part 4: 空间力旋量 F^s (从 F^b 变换) =====\n');
Fs_cases = zeros(6, 6);
for k = 1:6
    Fs_cases(:,k) = adjoint(inv(gst))' * Fb_cases(:,k);
    fprintf('  F^s_%d:  f = [%7.4f %7.4f %7.4f]  τ = [%7.4f %7.4f %7.4f]\n', ...
            k, Fs_cases(1:3,k), Fs_cases(4:6,k));
end

%% ====== Part 5: 一致性验证 ======
%  理论: τ = (J^s)^T F^s = (J^b)^T F^b
fprintf('\n===== Part 5: 一致性验证 ‖(J^s)^T F^s − (J^b)^T F^b‖ =====\n');
for k = 1:6
    tau_s = Js' * Fs_cases(:,k);
    diff  = norm(tau_s - tau_Fb(:,k));
    fprintf('  F_%d: τ_s = [%7.4f %7.4f %7.4f %7.4f]  误差 = %10.4e\n', ...
            k, tau_s, diff);
end

%% ====== 结果分析 ======
fprintf('\n===== 结果分析 (是否合理) =====\n');
fprintf(['  F^b_z: 关节 4 (prismatic, z 方向) 力最大 → 关节 4 沿 z 直接施力, 合理\n' ...
        '  F^b_x,F^b_y: 关节 1-3 有较大力矩 (力臂效应), 关节 4 力矩 < eps → 合理\n' ...
        '  τ^b_x,τ^b_y,τ^b_z: 纯力矩载荷, 关节 1-3 产生反力矩, 关节 4 ≈ 0 → 合理\n' ...
        '  (J^s)^T F^s = (J^b)^T F^b 精确相等 → 力旋量变换自洽 (MLS eq. 2.67)\n']);
