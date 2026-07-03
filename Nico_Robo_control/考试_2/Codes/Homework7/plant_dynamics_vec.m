function thetadd = plant_dynamics_vec(input_vec)
% PLANT_DYNAMICS_VEC  Forward dynamics from multiplexed input
%   input_vec = [τ(4); θ(4); θ̇(4)]  as 12×1
%   Returns θ̈ (4×1)
%
%   Solves:  M(θ)·θ̈ = τ − C(θ,θ̇)·θ̇ − N(θ,θ̇)

    n = 4;
    tau    = input_vec(1:n);
    theta  = input_vec(n+1:2*n);
    dtheta = input_vec(2*n+1:3*n);

    [M, C, N] = MCNsim_ws(theta, dtheta);

    thetadd = M \ (tau - C * dtheta - N);
end
