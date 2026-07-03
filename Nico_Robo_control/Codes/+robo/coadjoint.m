function Ad_g_invT = coadjoint(g)
% COADJOINT  力旋量的伴随变换 (Co-adjoint Transformation)
%    Ad_invT = coadjoint(g)
%    输入: g - 4×4 齐次变换矩阵 [R, p; 0,0,0,1]
%    输出: Ad_g^{-T} (6×6), 将 wrench 从 B 系变换到 A 系
%
%    公式 (MLS eq. 2.67):
%        F_a = Ad_{g_ab}^{-T} · F_b
%        Ad_g^{-T} = [R,  0;  hat(p)·R,  R]
%
%    与 twist 伴随对比:
%        Ad_g    = [R,  hat(p)·R;  0,  R]   ← twist 变换
%        Ad_g^{-T}= [R,  0;  hat(p)·R,  R]  ← wrench 变换 (co-adjoint)
%
%    功率不变性: F^T·V = (Ad_g^{-T}F)^T · (Ad_g·V)
    import robo.*
    if isa(g, 'sym'), g = formula(g); end
    R = g(1:3,1:3);  p = g(1:3,4);
    Ad_g_invT = [R, zeros(3,3); hatm(p)*R, R];
end
