function M_s = inertiaTransform(M_b, g)
% INERTIATRANSFORM  空间惯性矩阵的伴随变换 (MLS §4.3 eq. 4.14)
%    M_s = inertiaTransform(M_b, g)
%    输入: M_b (6×6) body frame 广义惯性矩阵
%          g   (4×4) body → spatial 的齐次变换
%    输出: M_s (6×6) spatial frame 广义惯性矩阵
%
%    公式: M_s = Ad_g^{-T} · M_b · Ad_g^{-1}
%
%    广义惯性矩阵结构 (body frame):
%        M_b = [ m·I₃,   m·ĉᵀ;
%                m·ĉ,     I_b  ]
%    m=质量, c=质心, I_b=绕质心转动惯量
    import robo.*
    Ad_inv = adjoint(inv(g));
    M_s = Ad_inv' * M_b * Ad_inv;
end
