function M_s = inertiaTransform(M_b, g)
% INERTIATRANSFORM  空间惯性矩阵的伴随变换
%    M_s = inertiaTransform(M_b, g)
%
%    输入:
%        M_b - 6×6 广义惯性矩阵 (在 body frame 中)
%              形式: M_b = [m·I₃,  m·hat(c)ᵀ;
%                          m·hat(c),  I_b        ]
%              其中 m = 质量, c = 质心位置 (body frame), I_b = 转动惯量
%        g   - 4×4 齐次变换矩阵, body frame → spatial frame
%
%    输出:
%        M_s - 6×6 广义惯性矩阵 (在 spatial frame 中)
%
%    变换公式 (MLS §4.3 eq. 4.14):
%        M_s = Ad_g^{-T} · M_b · Ad_g^{-1}
%
%    物理解释:
%        - 惯性矩阵描述了刚体对力/加速度的响应
%        - 从 body frame 到 spatial frame 的变换涉及
%          斯坦纳平移定理 (平行轴定理)
%        - 空间惯性矩阵依赖于当前构型 (随 g 变化)
%
%    用法:
%        已知连杆在自身体坐标系中的惯性 M_b,
%        用当前位姿 g 变换到空间坐标系中, 用于组装总惯性矩阵.

    import robo.*

    % Ad_g^{-1} = adjoint(inv(g))
    Ad_inv = adjoint(inv(g));

    % 变换: M_s = (Ad^{-1})^T · M_b · Ad^{-1}
    M_s = Ad_inv' * M_b * Ad_inv;
end
