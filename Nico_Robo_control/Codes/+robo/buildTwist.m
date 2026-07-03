function xi = buildTwist(v, omega)
% BUILDTWIST  从 v 和 omega 构建 6×1 twist 坐标
%    xi = buildTwist(v, omega)
%
%    输入: v     - 3×1 线速度分量
%          omega - 3×1 角速度分量 (旋转轴)
%    输出: xi    - 6×1 twist 坐标 = [v; omega]
%
%    用法: xi = buildTwist(v, omega);
%          g  = gtwist(xi, theta);     % 继续计算指数映射
%
%    这是 twistDecompose 的逆操作。
%
%    参见: twistDecompose, gtwist, G2twist

    xi = [v(:); omega(:)];
end
