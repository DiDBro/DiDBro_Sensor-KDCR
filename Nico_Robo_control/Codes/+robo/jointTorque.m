function tau = jointTorque(J, F, type)
% JOINTTORQUE  从末端力旋量和雅可比计算关节力矩 (MLS eq. 3.59)
%    tau = jointTorque(J, F)           % 默认空间形式
%    tau = jointTorque(J, F, 'body')   % 体力旋量形式
%
%    公式: τ = J^T · F
%        τ = J_s^T · F_s  (= J_b^T · F_b, 功率不变)
%
%    机械功: W = F^T·V = F^T·J·θ̇ = τ^T·θ̇
    if nargin < 3, type = 'spatial'; end
    tau = J' * F(:);
end
