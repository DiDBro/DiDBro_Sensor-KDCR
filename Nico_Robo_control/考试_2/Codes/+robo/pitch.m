function h = pitch(omega, v)
% PITCH  计算螺旋的节距 (pitch)
%   输入: omega - 3x1 旋转轴向量 (不一定归一化)
%         v     - 3x1 线速度分量
%   输出: h     - 节距标量
%               h = (omega'*v) / ||omega||^2  (含旋转运动)
%               h = inf                       (纯平移, omega ≈ 0)
%   参考: MLS eq. (2.42) p.48
%
%   注意: 对于纯平移 (omega = 0), 理论上 h → ∞;
%         此处返回 MATLAB inf 以正确处理后续计算.
    n2 = norm(omega)^2;
    if n2 < eps
        h = inf;          % 纯平移 → 无穷大螺距 (MLS p.48)
    else
        h = (omega' * v) / n2;
    end
end
