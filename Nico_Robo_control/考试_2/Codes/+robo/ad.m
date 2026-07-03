function ad_xi = ad(xi)
% AD  se(3) 的李括号伴随算子 (Lie bracket / adjoint action on the algebra)
%    输入: xi = [v; omega], 6×1 twist 坐标
%    输出: ad_xi = 6×6 矩阵, 满足 ad_ξ · η = ad_ξ(η) = [ξ, η] (李括号)
%
%    矩阵形式 (对 twist 顺序 v; ω):
%        ad_ξ = [ hat(ω),  hat(v);
%                 zeros(3), hat(ω) ]
%
%    李括号定义 (MLS §2.3):
%        [ξ₁, ξ₂] = ad_{ξ₁} · ξ₂
%        = (ω₁×v₂ − ω₂×v₁ + ω₁×ω₂ 合并写作)
%
%    性质:
%        ad_{Ad_g · ξ} = Ad_g · ad_ξ · Ad_g^{-1}
%        e^{ad_ξ · θ} = Ad_{e^{ξ̂θ}}
%
%    用途:
%        1. 计算速度级别的加速度项
%        2. 计算科氏力/离心力矩阵的分量
%        3. 李括号计算

    import robo.*
    v     = xi(1:3);  v = v(:);
    omega = xi(4:6);  omega = omega(:);

    ad_xi = [hatm(omega), hatm(v);
             zeros(3,3), hatm(omega)];
end
