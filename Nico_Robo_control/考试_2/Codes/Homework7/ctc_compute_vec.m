function tau = ctc_compute_vec(input_vec)
% CTC_COMPUTE_VEC  CTC controller from multiplexed input vector
%   input_vec = [θ_d(4); θ̇_d(4); θ̈_d(4); θ(4); θ̇(4)]  as 20×1
%   Returns τ (4×1)
%
%   Implements:  τ = M(θ)·θ̈* + C(θ,θ̇)·θ̇ + N(θ,θ̇)
%   where  θ̈* = θ̈_d + Kᵥ(θ̇_d−θ̇) + Kₚ(θ_d−θ)

    n = 4;
    theta_d   = input_vec(1:n);
    thetad_d  = input_vec(n+1:2*n);
    thetadd_d = input_vec(2*n+1:3*n);
    theta     = input_vec(3*n+1:4*n);
    dtheta    = input_vec(4*n+1:5*n);

    Kp = 2500;
    Kv = 100;

    e    = theta_d  - theta;
    edot = thetad_d - dtheta;

    thetadd_star = thetadd_d + Kv * edot + Kp * e;

    [M, C, N] = MCNsim_ws(theta, dtheta);

    tau = M * thetadd_star + C * dtheta + N;
end
