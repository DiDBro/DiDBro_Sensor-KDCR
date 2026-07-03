function theta = PK3(xi, p, q, delta)
% PK3  Paden-Kahan 子问题 3: 绕轴旋转使一点到另一点的距离为给定值
%   求解 ‖q − e^(ξ̂θ)·p‖ = δ
%
%   输入: xi    = [v; omega] (6×1)
%         p     = 3×1 或 4×1 (齐次坐标) 起始点
%         q     = 3×1 或 4×1 (齐次坐标) 目标点 (圆心)
%         delta = 正数, 目标距离
%   输出: theta = 2×1 列向量 (θ₀±φ); 无解时 []

    import robo.*

    omega = xi(4:6);  omega = omega(:);
    v_tw  = xi(1:3);  v_tw  = v_tw(:);

    % 兼容 4x1 齐次坐标
    p = p(1:3);  p = p(:);
    q = q(1:3);  q = q(:);

    % ===== 轴上一点 r =====
    r = cross(omega, v_tw);

    % ===== 平移 =====
    u = p - r;
    v = q - r;

    u_par  = omega * (omega' * u);
    u_perp = u - u_par;
    v_par  = omega * (omega' * v);
    v_perp = v - v_par;

    nu = norm(u_perp);
    nv = norm(v_perp);

    if nu < 1e-14 || nv < 1e-14
        if abs(norm(v_par - u_par) - delta) < 1e-10
            theta = [0; 0];
        else
            theta = [];
        end
        return;
    end

    theta0 = atan2(omega' * cross(u_perp, v_perp), u_perp' * v_perp);

    c_num = nv^2 + nu^2 + norm(v_par - u_par)^2 - delta^2;
    c_den = 2 * nv * nu;
    cos_phi = c_num / c_den;

    if cos_phi < -1 - 1e-12 || cos_phi > 1 + 1e-12
        theta = [];
        return;
    end

    cos_phi = max(-1, min(1, cos_phi));
    phi = acos(cos_phi);

    theta = [theta0 + phi; theta0 - phi];
end
