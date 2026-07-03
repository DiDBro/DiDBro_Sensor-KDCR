function [R, p] = twistExp(omega, v, theta)
% TWISTEXP  twist 指数映射的分量形式: 分别返回 R 和 p
%    [R, p] = twistExp(omega, v, theta)
%
%    输入: omega - 3×1 旋转轴 (单位向量)
%          v     - 3×1 线速度分量
%          theta - 旋转角度 (弧度)
%    输出: R     - 3×3 旋转矩阵 (SO(3))
%          p     - 3×1 平移向量
%
%    公式 (MLS eq. 2.36):
%        R = e^{ω̂θ} = I + sinθ·ω̂ + (1−cosθ)·ω̂²   (Rodrigues)
%        p = (I − R)·ω̂·v + ω·ωᵀ·v·θ              (|ω| ≠ 0)
%        p = v·θ                                    (|ω| = 0, 纯平移)
%
%    等价于 gtwist(buildTwist(v,omega), theta) 的内部计算，
%    但直接返回 R 和 p 分量，方便公式推导和手算验证。
%
%    参见: gtwist, rodrigues, buildTwist

    import robo.*

    omega = omega(:);
    v     = v(:);

    % 旋转部分: Rodrigues 公式
    R = rodrigues(omega, theta);

    % 平移部分
    if norm(omega) < 1e-12
        % 纯平移: ω = 0 → R = I, p = v·θ
        p = v * theta;
    else
        % 一般情况 MLS eq. (2.36)
        omega_hat = hatm(omega);
        p = (eye(3) - R) * omega_hat * v + omega * omega' * v * theta;
    end
end
