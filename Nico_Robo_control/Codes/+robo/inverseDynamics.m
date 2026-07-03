function tau = inverseDynamics(thetadd, thetad, theta, xi, calMp, lM, beta)
% INVERSEDYNAMICS  逆动力学: 给定运动 → 求关节力矩 (MLS §4.2)
%    tau = inverseDynamics(thetadd, thetad, theta, xi, calMp, lM, beta)
%
%    公式: τ = M(θ)·θ̈ + C(θ,θ̇)·θ̇ + N(θ,θ̇)
%
%    这是前馈控制的基础: 给定期望轨迹, 算出需要的力矩.
    import robo.*
    [M, C, N] = inertiaMatrix(xi, calMp, lM, beta, theta, thetad);
    tau = M * thetadd(:) + C * thetad(:) + N;
end
