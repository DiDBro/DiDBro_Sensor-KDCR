function theta = PK1(xi, p, q, tol)
% PK1  Paden-Kahan 子问题 1: 绕单轴旋转使一点与另一点重合
%    e^(ξ̂θ) · p = q,  其中 ξ 为零螺距 twist (revolute)
%
%   输入: xi  = [v; omega] (6×1), omega 为单位旋转轴
%         p   = 3×1 或 4×1 (齐次坐标) 起始点
%         q   = 3×1 或 4×1 (齐次坐标) 目标点
%         tol = (可选) 约束容差, 默认 1e-10
%   输出: theta = 旋转角 (弧度), 约束不满足时返回 []
%
%   约束条件 (必须满足才有解):
%         1. ||(I-ωωᵀ)(p-r)|| == ||(I-ωωᵀ)(q-r)||  (到轴距离相等)
%         2. ωᵀ(p-r) == ωᵀ(q-r)                     (沿轴投影相等)
%   课件 April_27_inv_kinNT.pdf, MLS eq. (3.18)

    import robo.*

    omega = xi(4:6);  omega = omega(:);
    v_tw  = xi(1:3);  v_tw  = v_tw(:);

    % 兼容 4x1 齐次坐标, 取前 3 行
    p = p(1:3);  p = p(:);
    q = q(1:3);  q = q(:);

    % 默认容差
    if nargin < 4
        tol = 1e-10;
    end

    % 轴上一点 r: v = -ω×r → r⊥分量 = ω×v
    r = cross(omega, v_tw);

    u = p - r;
    v = q - r;

    % 投影到垂直 ω 的平面
    up = u - omega * (omega' * u);
    vp = v - omega * (omega' * v);

    % ===== 约束检查 =====

    % 检查 omega 是否为零向量 (退化轴)
    norm_omega = norm(omega);
    if norm_omega < tol
        warning('PK1:zero_axis', ...
            '旋转轴 omega 模长接近零 (|omega| = %.4g), 无法定义旋转轴。', norm_omega);
        theta = [];
        return;
    end

    nu = norm(up);
    nv = norm(vp);

    % 约束 1: 到旋转轴的距离必须相等
    % 旋转不改变点到轴的距离, 所以 ||up|| 必须等于 ||vp||
    dist_tol = tol * max(1, max(nu, nv));
    if abs(nu - nv) > dist_tol
        warning('PK1:distance_mismatch', ...
            ['点到旋转轴的距离不相等: |up| = %.6g, |vp| = %.6g, 差值 = %.2e.\n' ...
             '  旋转不改变点到轴的距离, 因此 p 无法通过绕此轴的纯旋转到达 q。\n' ...
             '  请检查: (1) p 和 q 是否由同一个点旋转生成? ' ...
             '(2) 旋转轴定义是否正确?'], ...
            nu, nv, abs(nu - nv));
        theta = [];
        return;
    end

    % 约束 2: 沿旋转轴的投影必须相等
    % 旋转不改变沿轴方向的分量
    u_par = omega' * u;
    v_par = omega' * v;
    proj_tol = tol * max(1, max(abs(u_par), abs(v_par)));
    if abs(u_par - v_par) > proj_tol
        warning('PK1:axis_projection_mismatch', ...
            ['沿旋转轴 ω 的投影不相等: ωᵀ(p-r) = %.6g, ωᵀ(q-r) = %.6g, 差值 = %.2e.\n' ...
             '  旋转不改变沿 ω 方向的分量, 因此 p 无法通过绕此轴的纯旋转到达 q.\n' ...
             '  请检查: (1) p 和 q 是否由同一个点旋转生成? ' ...
             '(2) 旋转轴方向是否正确?'], ...
            u_par, v_par, abs(u_par - v_par));
        theta = [];
        return;
    end

    % 处理 p, q 在轴上的退化情况 (up ≈ vp ≈ 0)
    if nu < tol
        % p 和 q 都在旋转轴上, 任意旋转角都满足, 返回 0
        theta = 0;
        return;
    end

    % 计算旋转角
    theta = atan2(omega' * cross(up, vp), up' * vp);
end
