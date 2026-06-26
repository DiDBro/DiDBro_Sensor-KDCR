function g = gtwist(xi, theta)
% GTWIST  twist 指数映射: 6x1 twist 坐标 -> 4x4 齐次变换矩阵
%   g = gtwist(xi, theta)
%   输入:  xi    = [v; omega], 6x1, omega 为旋转轴单位向量
%          theta = 旋转/平移量 (弧度)
%   输出:  g     = 4x4 齐次变换矩阵 = e^(ξ̂θ)
%   基于 MLS eq. (2.36)
%
%   与 POE 的关系: e^(ξ̂θ) 就是单关节的正运动学变换

    import robo.*

    v     = xi(1:3);  v     = v(:);
    omega = xi(4:6);  omega = omega(:);

    R = rodrigues(omega, theta);           % SO(3) 旋转部分

    if norm(omega) < 1e-12
        % 纯平移: omega = 0
        p = v * theta;
    else
        % 一般情况 MLS (2.36)
        omega_hat = hatm(omega);
        p = (eye(3) - R) * omega_hat * v + omega * omega' * v * theta;
    end

    g = [R, p; 0 0 0 1];
end
