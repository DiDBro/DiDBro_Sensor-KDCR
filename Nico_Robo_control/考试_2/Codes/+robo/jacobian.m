function [Js, Jb] = jacobian(xis, thetas, gst0)
% JACOBIAN  空间 Jacobian 与体 Jacobian (MLS §4.1, eq. 3.52–3.55)
%   [Js, Jb] = jacobian(xis, thetas)            — 工具在空间原点
%   [Js, Jb] = jacobian(xis, thetas, gst0)       — 工具在 gst(0)
%
%   输入: xis    = 6×n 矩阵, 每列为 twist ξ_i = [v_i; ω_i]
%         thetas = n×1 关节变量 (弧度 or m)
%         gst0   = 4×4 参考构型下工具相对于空间的位姿 (默认 = eye(4))
%
%   输出: Js  = 6×n 空间 Jacobian, J^s_i = Ad_{g_{s,i-1}} · ξ_i
%         Jb  = 6×n 体 Jacobian,  J^b_i = Ad_{g_{i,t}^{-1}} · ξ_i
%
%   公式:
%     J^s_i = Ad_{g_{s,i-1}} · ξ_i,   g_{s,i-1} = e^{ξ̂₁θ₁}…e^{ξ̂_{i-1}θ_{i-1}}  (MLS 3.54)
%     J^b   = Ad_{gst}^{-1} · J^s                                              (MLS 3.55→2.61)

    import robo.*

    if nargin < 3
        gst0 = eye(4);
    end

    n = length(thetas);
    if size(xis, 2) ~= n
        error('xis 的列数 (%d) 必须等于 thetas 的长度 (%d)', size(xis,2), n);
    end

    Js = zeros(6, n);

    % --- 逐列构造空间 Jacobian ---
    g_s = eye(4);                            % g_{s,0} = I
    for i = 1:n
        xi_i = xis(:, i);
        Js(:, i) = adjoint(g_s) * xi_i;      % J^s_i = Ad_{prev} · ξ_i
        g_s = g_s * gtwist(xi_i, thetas(i)); % 累积: g_{s,i} = g_{s,i-1}·e^{ξ̂_iθ_i}
    end

    % --- 末端位姿 (POE, MLS 3.3) ---
    gst = g_s * gst0;

    % --- 体 Jacobian ---
    if nargout >= 2
        Jb = adjoint(inv(gst)) * Js;         % J^b = Ad_{gst}^{-1} · J^s
    end
end
