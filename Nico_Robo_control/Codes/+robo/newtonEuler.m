function [tau, tau_euler, tau_gyro] = newtonEuler(I, omega, alpha, g_wrench)
% NEWTONEULER  刚体 Newton-Euler 方程 (Homework 6 核心公式)
%    [tau, tau_euler, tau_gyro] = newtonEuler(I, omega, alpha)
%    [tau, tau_euler, tau_gyro] = newtonEuler(I, omega, alpha, g_wrench)
%
%    输入:
%        I         - 3×3 转动惯量 (纯旋转) 或 6×6 空间惯性矩阵
%        omega     - 3×1 角速度 (body frame)
%        alpha     - 3×1 角加速度 (body frame)
%        g_wrench  - (可选) 6×1 重力/外力旋量
%
%    输出:
%        tau       - 合力矩 / 合力旋量
%        tau_euler - 欧拉项: I·α
%        tau_gyro  - 陀螺项: ω×(I·ω)
%
%    公式:
%        纯旋转 (3×3):  τ = I·α + ω×(I·ω)
%        空间形式 (6×6): F = I·V̇ − ad_V^T·I·V
%
%    典型例题: 飞机螺旋桨陀螺力矩
%        ω = ω_self + R'·ω_precession
%        α = −hat(ω_self)·R'·ω_precession
%        τ = I·α + ω×(I·ω)
    import robo.*
    if nargin < 4, g_wrench = zeros(6,1); end
    omega = omega(:);  alpha = alpha(:);

    if isequal(size(I), [3,3])
        tau_euler = I * alpha;
        tau_gyro  = hatm(omega) * I * omega;
        tau = tau_euler + tau_gyro;
    elseif isequal(size(I), [6,6])
        V = [zeros(3,1); omega];
        V_dot = [zeros(3,1); alpha];
        ad_V = ad(V);
        tau_euler = I * V_dot;
        tau_gyro  = -ad_V' * I * V;
        tau = tau_euler + tau_gyro + g_wrench;
    else
        error('newtonEuler: I 必须是 3×3 或 6×6 矩阵');
    end
end
