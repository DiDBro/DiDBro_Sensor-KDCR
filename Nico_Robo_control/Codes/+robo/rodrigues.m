function R = rodrigues(omega, theta)
% RODRIGUES  罗德里格斯公式: 旋转轴 + 旋转角 -> 3x3 旋转矩阵
    omega = omega(:);
    w1 = omega(1); w2 = omega(2); w3 = omega(3);
    K = [  0, -w3,  w2;
          w3,   0, -w1;
         -w2,  w1,   0];
    R = eye(3) + sin(theta)*K + (1 - cos(theta))*(K^2);
end
