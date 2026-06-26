function [theta1, theta2] = PK2(xi1, xi2, p, q)
% PK2  Paden-Kahan 子问题 2: 绕两条相交轴旋转使一点与另一点重合
%   求解: e^(ξ̂₁θ₁) · e^(ξ̂₂θ₂) · p = q
%   ξ₁, ξ₂ 为零螺距 twist (revolute), 轴线不平行且相交
%
%   输入: xi1, xi2 = [v; omega] (6×1)
%         p = 3×1 或 4×1 (齐次坐标) 起始点
%         q = 3×1 或 4×1 (齐次坐标) 目标点
%   输出: theta1, theta2 — 1×2 行向量, 两解 (±γ), 无解时 []

    import robo.*

    omega1 = xi1(4:6);  omega1 = omega1(:);
    omega2 = xi2(4:6);  omega2 = omega2(:);
    v1     = xi1(1:3);  v1     = v1(:);
    v2     = xi2(1:3);  v2     = v2(:);

    % 兼容 4x1 齐次坐标
    p = p(1:3);  p = p(:);
    q = q(1:3);  q = q(:);

    % ===== 求两轴交点 r =====
    A = [hatm(omega1); hatm(omega2)];     % 6×3
    b = [-v1; -v2];                       % 6×1
    r = A \ b;

    % ===== 平移至交点 =====
    u = p - r;
    v = q - r;

    a12 = omega1' * omega2;
    d   = 1 - a12^2;

    if abs(d) < 1e-12
        error('PK2: 两旋转轴平行, 请用平面几何法求解');
    end

    a1v = omega1' * v;
    a2u = omega2' * u;

    alpha = (a1v - a12 * a2u) / d;
    beta  = (a2u - a12 * a1v) / d;

    gamma2 = (u'*u - alpha^2 - beta^2 - 2*alpha*beta*a12) / d;

    if gamma2 < -1e-12
        theta1 = [];
        theta2 = [];
        return;
    end

    gamma   = sqrt(max(0, gamma2));
    omega12 = cross(omega1, omega2);

    theta1 = zeros(1, 2);
    theta2 = zeros(1, 2);

    signs = [-1, 1];
    for k = 1:2
        sgn = signs(k);
        z = alpha * omega1 + beta * omega2 + sgn * gamma * omega12;

        % θ₁: e^(ω̂₁θ₁) · z = v
        up1 = z - omega1 * (omega1' * z);
        vp1 = v - omega1 * (omega1' * v);
        theta1(k) = atan2(omega1' * cross(up1, vp1), up1' * vp1);

        % θ₂: e^(ω̂₂θ₂) · u = z
        up2 = u - omega2 * (omega2' * u);
        zp  = z - omega2 * (omega2' * z);
        theta2(k) = atan2(omega2' * cross(up2, zp), up2' * zp);
    end
end
