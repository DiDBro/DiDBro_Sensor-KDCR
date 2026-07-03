function tau = jointTorque(J, F, type)
% JOINTTORQUE  从末端力旋量和雅可比计算关节力矩
%    tau = jointTorque(J, F)
%    tau = jointTorque(J, F, type)
%
%    输入:
%        J    - 6×n 雅可比矩阵 (空间 J_s 或 体 J_b)
%        F    - 6×1 力旋量 (空间 F_s 或 体 F_b)
%        type - (可选) 'spatial' (默认) 或 'body', 指定雅可比和力旋量的类型
%
%    输出:
%        tau  - n×1 关节力矩向量
%
%    公式 (MLS §3.4, 力/运动对偶性):
%        τ = J^T · F
%
%    具体而言 (MLS eq. 3.59):
%        τ = J_s^T · F_s    (空间雅可比 + 空间力旋量)
%        τ = J_b^T · F_b    (体雅可比   + 体力旋量)
%
%    两种形式给出相同的 τ (功率不变).
%
%    验证关系:
%        (J_s)^T · F_s = (J_b)^T · F_b
%        因为 J_b = Ad_{gst}^{-1} · J_s,  F_s = Ad_g^{-T} · F_b
%
%    机械功:  W = F^T · V = F^T · J · θ̇ = τ^T · θ̇
%
%    参见: jacobian, coadjoint

    if nargin < 3
        type = 'spatial';
    end

    tau = J' * F(:);
end
