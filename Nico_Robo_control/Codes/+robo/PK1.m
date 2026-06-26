function theta = PK1(xi, p, q)
% PK1  Paden-Kahan 子问题 1: 绕单轴旋转使一点与另一点重合
%    e^(ξ̂θ) · p = q,  其中 ξ 为零螺距 twist (revolute)
%
%   输入: xi = [v; omega] (6×1), omega 为单位旋转轴
%         p  = 3×1 或 4×1 (齐次坐标) 起始点
%         q  = 3×1 或 4×1 (齐次坐标) 目标点
%   输出: theta = 旋转角 (弧度)
%
%   课件 April_27_inv_kinNT.pdf, MLS eq. (3.18)

    import robo.*

    omega = xi(4:6);  omega = omega(:);
    v_tw  = xi(1:3);  v_tw  = v_tw(:);

    % 兼容 4x1 齐次坐标, 取前 3 行
    p = p(1:3);  p = p(:);
    q = q(1:3);  q = q(:);

    % 轴上一点 r: v = -ω×r → r⊥分量 = ω×v
    r = cross(omega, v_tw);

    u = p - r;
    v = q - r;

    % 投影到垂直 ω 的平面
    up = u - omega * (omega' * u);
    vp = v - omega * (omega' * v);

    tol = 1e-9;
    assert(abs(norm(up) - norm(vp)) < tol, ...
        'PK1: p 和 q 沿 ω 方向的距离不相等, 无解');

    theta = atan2(omega' * cross(up, vp), up' * vp);
end
