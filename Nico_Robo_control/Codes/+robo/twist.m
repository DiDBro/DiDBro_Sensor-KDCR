function zeta = twist(omega, v)
% TWIST  构建 4x4 twist 矩阵
    import robo.*
    hat_omega = hatm_sym(omega);
    zeta = [hat_omega, v(:); 0, 0, 0, 0];
end
