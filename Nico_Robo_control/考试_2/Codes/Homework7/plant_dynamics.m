function thetadd = plant_dynamics(tau, theta, dtheta)
% PLANT_DYNAMICS  Compute joint acceleration from applied torque
%   thetadd = plant_dynamics(tau, theta, dtheta)
%
%   Solves the forward dynamics:  M(θ)·θ̈ = τ − C(θ,θ̇)·θ̇ − N(θ,θ̇)
%   →  θ̈ = M⁻¹(τ − Cθ̇ − N)
%
%   All inputs/outputs are 4×1 column vectors.

    [M, C, N] = MCNsim_ws(theta, dtheta);

    thetadd = M \ (tau - C * dtheta - N);
end
