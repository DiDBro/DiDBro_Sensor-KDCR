function w = vee_so3(omega_hat)
% VEE_SO3  vee 算子 (so3): 3x3 反对称矩阵 -> 3x1 向量
    w = [omega_hat(3,2); omega_hat(1,3); omega_hat(2,1)];
end
