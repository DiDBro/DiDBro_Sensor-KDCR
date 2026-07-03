function xi_hat = hat_se3(xi)
    % 将运动旋量 ξ = [v; ω] 转换为 se(3) 矩阵
    v = xi(1:3);
    w = xi(4:6);
    xi_hat = [hatm_num(w), v;
              zeros(1,3), 0];
end
function S = hatm_num(v)
    v1 = v(1);
    v2 = v(2);
    v3 = v(3);
    S = [0,   -v3,   v2;
         v3,   0,   -v1;
        -v2,   v1,   0];
end
