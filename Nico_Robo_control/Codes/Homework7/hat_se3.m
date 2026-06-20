function xi_hat = hat_se3(xi)
    % 将运动旋量 ξ = [v; ω] 转换为 se(3) 矩阵
    v = xi(1:3);
    w = xi(4:6);
    xi_hat = [hatm_num(w), v; 
              zeros(1,3), 0];
end