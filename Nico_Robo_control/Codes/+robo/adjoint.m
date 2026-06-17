function Ad_g = adjoint(g)
% ADJOINT  伴随变换矩阵 (Adjoint Transformation)
%   输入: g - 4x4 齐次变换矩阵 [R, p; 0, 0, 0, 1]
%   输出: Ad_g - 6x6 伴随矩阵
%
%   用途: 将 twist 坐标从 B 系变换到 A 系
%         V_a = Ad_g_ab * V_b
%   其中: V = [v; omega] 为 6x1 twist 坐标向量
%
%   公式:
%        Ad_g = [R,     skew(p)*R;
%                0_3x3,  R        ]

    import robo.*
    if isa(g, 'sym')
        g = formula(g);
    end
    % 提取 R 和 p
    R = g(1:3, 1:3);
    p = g(1:3, 4);

    % 构造伴随矩阵
    Ad_g = [R,            hatm_sym(p) * R;
            zeros(3,3),   R               ];
end
