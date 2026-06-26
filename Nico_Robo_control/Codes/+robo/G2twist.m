function [xi, theta] = G2twist(G)
% G2TWIST  从 4x4 齐次变换矩阵提取 twist 坐标 (v, omega) 和旋转角 theta
%   输入: G = [R, p; 0 0 0 1], 4x4 SE(3) 矩阵
%   输出: xi    = [v; omega], 6x1 twist 坐标 (omega 归一化为单位向量)
%          theta = 旋转角 (弧度); 若 R≈I 则为平移量 |p|

    import robo.*

    R = G(1:3, 1:3);
    p = G(1:3, 4);

    % --- 从 R 提取 omega 和 theta (iRodrigues) ---
    [omega, theta] = iRodrigues(R);

    % --- 用 MLS (2.38) 反解 v ---
    if theta < 1e-12
        % 纯平移: R ≈ I, theta ≈ 0
        omega = [0; 0; 0];        % 可视为绕任意轴 0°
        v = p / theta;            % p = v*theta → v = p/theta
        theta = norm(p);          % theta = |p|
        if theta > 0
            v = p / theta;        % v 单位化
        else
            v = [0; 0; 0];
        end
    else
        % 一般情况 MLS eq. (2.38): A·v = p
        omega_hat = hatm(omega);
        A = (eye(3) - R) * omega_hat + omega * omega' * theta;
        v = A \ p;
    end

    xi = [v; omega];
end
