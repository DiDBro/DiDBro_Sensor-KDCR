function [tau, tau_euler, tau_gyro] = newtonEuler(I, omega, alpha, g_wrench)
% NEWTONEULER  刚体 Newton-Euler 方程
%    [tau, tau_euler, tau_gyro] = newtonEuler(I, omega, alpha)
%    [tau, tau_euler, tau_gyro] = newtonEuler(I, omega, alpha, g_wrench)
%
%    输入:
%        I         - 6×6 空间惯性矩阵 (在 body frame 中)
%                    或 3×3 转动惯量矩阵 (用于纯旋转, 与 g_wrench 同用)
%        omega     - 3×1 角速度 (在 body frame 中)
%        alpha     - 3×1 角加速度 (在 body frame 中)
%        g_wrench  - (可选) 6×1 重力/外力旋量 (在 body frame 中)
%
%    输出:
%        tau       - 6×1 合力旋量 = I·α + ad_ω^T · I · ω + g_wrench
%                    或 3×1 合力矩 (当 I 为 3×3 时)
%        tau_euler - 欧拉项: I·α
%        tau_gyro  - 陀螺项: ω × (I·ω) 或 ad_ω^T · I · ω
%
%    公式 (刚体动力学, MLS §4.3):
%        空间惯性矩阵形式 (6×6):
%            F = I · V̇ − ad_V^T · I · V     (注意符号约定)
%        即:  F = I · α_body + ad_ω^T · I · V
%
%        纯旋转形式 (3×3):
%            τ = I_rot · α + ω × (I_rot · ω)
%
%    说明:
%        - 陀螺项 ω×(I·ω) 是 Coriolis/向心力在刚体层面的体现
%        - ad_ω^T 中的反对称部分给出 ω× 效应
%        - 对轴对称刚体, I_rot · ω ∥ ω → 陀螺项 = 0

    import robo.*

    if nargin < 4
        g_wrench = zeros(6, 1);
    end

    omega = omega(:);
    alpha = alpha(:);

    if isequal(size(I), [3, 3])
        % ===== 纯旋转 (3×3 转动惯量) =====
        tau_euler = I * alpha;
        tau_gyro  = hatm(omega) * I * omega;   % ω × (I·ω)
        tau = tau_euler + tau_gyro;
    elseif isequal(size(I), [6, 6])
        % ===== 完整 6×6 空间惯性矩阵 =====
        V = [zeros(3,1); alpha(1:3)];  % 仅角加速 (可扩展)
        % 或者直接: alpha_body = [a; α], 其中 a 是线加速度

        % 注意: 需要完整的 body velocity V = [v; ω] 和加速度 V̇ = [v̇; ω̇]
        % 此处 omega 为角速度, alpha 为角加速度
        % 若只关心旋转, 可设 v = 0, v̇ = 0
        V     = [zeros(3,1); omega];
        V_dot = [zeros(3,1); alpha];

        % 构造 ad_V (李括号伴随矩阵)
        ad_V = ad(V);

        % 牛顿-欧拉:  F = I · V̇ − ad_V^T · I · V
        % 注意: 某些约定用 +ad_V^T, 取决于旋量顺序定义
        tau_euler = I * V_dot;
        tau_gyro  = -ad_V' * I * V;      % 陀螺/科氏项
        tau = tau_euler + tau_gyro + g_wrench;
    else
        error('newtonEuler: I 必须是 3×3 转动惯量矩阵或 6×6 空间惯性矩阵');
    end
end
