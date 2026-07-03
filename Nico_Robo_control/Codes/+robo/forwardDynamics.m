function thetadd = forwardDynamics(tau, thetad, theta, xi, calMp, lM, beta)
% FORWARDDYNAMICS  正动力学: 给定力矩 → 求关节加速度 (MLS §4.2)
%    thetadd = forwardDynamics(tau, thetad, theta, xi, calMp, lM, beta)
%
%    公式: θ̈ = M(θ)⁻¹ (τ − C(θ,θ̇)·θ̇ − N(θ,θ̇))
%
%    用途: 动力学仿真 (Simulink plant 模型).
    import robo.*
    [M, C, N] = inertiaMatrix(xi, calMp, lM, beta, theta, thetad);
    thetadd = M \ (tau(:) - C * thetad(:) - N);
end
