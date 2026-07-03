function tau = ctc_compute(theta_d, thetad_d, thetadd_d, theta, dtheta)
% CTC_COMPUTE  Computed Torque Controller for 4-DOF manipulator
%   tau = ctc_compute(theta_d, thetad_d, thetadd_d, theta, dtheta)
%
%   Implements:  τ = M(θ) · θ̈* + C(θ,θ̇) · θ̇ + N(θ,θ̇)
%   where θ̈* = θ̈_d + Kᵥ(θ̇_d − θ̇) + Kₚ(θ_d − θ)
%
%   All inputs/outputs are 4×1 column vectors.

    Kp = 2500;   % position gain (ωₙ²)
    Kv = 100;    % velocity gain (2ζωₙ, with ζ=1, ωₙ=50)

    e    = theta_d  - theta;
    edot = thetad_d - dtheta;

    thetadd_star = thetadd_d + Kv * edot + Kp * e;

    % 调用 MCNsim 计算动力学矩阵
    [M, C, N] = MCNsim_ws(theta, dtheta);

    tau = M * thetadd_star + C * dtheta + N;
end
