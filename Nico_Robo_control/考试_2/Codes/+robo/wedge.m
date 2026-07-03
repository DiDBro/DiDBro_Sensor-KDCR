function xi_wedge = wedge(xi)
% WEDGE  wedge 算子: 6x1 向量 [v;omega] -> 4x4 矩阵
    import robo.*
    v         = xi(1:3);
    omega     = xi(4:6);
    omega_hat = hatm(omega);
    xi_wedge  = [omega_hat, v(:); zeros(1,4)];
end
