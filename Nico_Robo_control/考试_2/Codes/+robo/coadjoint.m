function Ad_g_invT = coadjoint(g)
% COADJOINT  力旋量的伴随变换 (Co-adjoint Transformation)
%    输入: g - 4×4 齐次变换矩阵 [R, p; 0, 0, 0, 1]
%    输出: Ad_g_invT - 6×6 矩阵 = Ad_g^{-T}
%
%    用途: 将力旋量 (wrench) 从 B 系变换到 A 系
%          F_a = Ad_{g_ab}^{-T} · F_b     (MLS eq. 2.67)
%
%    其中: F = [f; τ] 为 6×1 力旋量, f 为力, τ 为力矩
%
%    公式推导:
%        Ad_g = [R,  hat(p)·R;  0, R]           ← twist 的伴随
%        Ad_g^{-T} = [R,     0;  hat(p)·R,  R]   ← wrench 的伴随
%
%    物理意义:
%        - 力 f 随旋转 R 变换
%        - 力矩 τ 随旋转 R 变换，但力 f 会产生额外的力矩 p × (R·f)
%
%    对偶性 (MLS §2.5):
%        Wrench 变换 F → Ad_g^{-T}·F  与
%        Twist  变换 V → Ad_g·V       是对偶的.
%        满足功率不变: F^T · V = (Ad_g^{-T}F)^T · (Ad_g·V)

    import robo.*
    if isa(g, 'sym')
        g = formula(g);
    end
    R = g(1:3, 1:3);
    p = g(1:3, 4);

    % Ad_g^{-T}: 将伴随转置并求逆
    % 解析形式: [R,  0;  hat(p)*R,  R]
    Ad_g_invT = [R,            zeros(3,3);
                 hatm(p) * R,  R          ];
end
