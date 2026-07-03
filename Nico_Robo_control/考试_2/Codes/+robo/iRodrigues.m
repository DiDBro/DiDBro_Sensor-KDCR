function [omega, theta] = iRodrigues(R)
% IRODRIGUES  逆罗德里格斯公式: 3x3 旋转矩阵 -> 旋转轴 omega + 旋转角 theta
%   输入 R 必须是 3x3 旋转矩阵 (SO(3))
%   输出:
%     omega: 3x1 单位旋转轴向量
%     theta: 旋转角度 (弧度, [0, pi])

    import robo.*

    tol = 1e-6;  % 数值容差

    % 确保 trace 在有效范围内 [-1, 3]
    tr = max(-1, min(3, trace(R)));

    theta = acos((tr - 1) / 2);

    if theta < tol
        % R ≈ I: 旋转角为零, omega 可任意取
        omega = [1; 0; 0];
        theta = 0;
    elseif abs(theta - pi) < tol
        % theta ≈ pi: 需要用平方项提取 omega
        K2 = (R - eye(3)) / 2;
        % 从对角线提取 omega 分量
        w1 = sign(K2(3,2)) * sqrt(max(0, -K2(2,2) - K2(3,3) + 1));
        w2 = sign(K2(1,3)) * sqrt(max(0, -K2(1,1) - K2(3,3) + 1));
        w3 = sign(K2(2,1)) * sqrt(max(0, -K2(1,1) - K2(2,2) + 1));
        w = [w1; w2; w3];
        % 用非对角项确认符号
        if abs(K2(2,1) - w1*w2) > tol || abs(K2(3,1) - w1*w3) > tol || abs(K2(3,2) - w2*w3) > tol
            w = -w;
        end
        omega = w / norm(w);
        theta = pi;
    else
        % 一般情况: omega_hat = (R - R') / (2*sin(theta))
        omega_hat = (R - R') / (2 * sin(theta));
        omega = vee_so3(omega_hat);
    end
end
