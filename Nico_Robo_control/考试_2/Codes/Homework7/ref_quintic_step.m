function [theta_d, thetad_d, thetadd_d] = ref_quintic_step(t)
% REF_QUINTIC_STEP  4-DOF quintic rounded step reference trajectory
%   Generates desired joint positions, velocities, and accelerations
%   for a rounded step from 0 to target amplitude.
%
%   Joint 1: 2 rad, Joint 2: 1 rad, Joint 3: 0.5 rad, Joint 4: 0.08 m
%   Step starts at t0 = 1.0 s, duration dT = 0.4 s
%
%   Quintic polynomial: s(τ) = 6τ⁵ − 15τ⁴ + 10τ³, τ ∈ [0,1]
%   Ensures C² continuity (position, velocity, acceleration all = 0 at endpoints)

    t0 = 1.0;       % step start time [s]
    dT = 0.4;       % step duration [s]
    amps = [2; 1; 0.5; 0.08];  % target amplitudes [rad; rad; rad; m]

    if t < t0
        s = 0; sd = 0; sdd = 0;
    elseif t > t0 + dT
        s = 1; sd = 0; sdd = 0;
    else
        tau = (t - t0) / dT;
        tau2 = tau * tau;
        tau3 = tau2 * tau;
        tau4 = tau3 * tau;
        tau5 = tau4 * tau;
        s   = 6*tau5 - 15*tau4 + 10*tau3;
        sd  = (30*tau4 - 60*tau3 + 30*tau2) / dT;
        sdd = (120*tau3 - 180*tau2 + 60*tau) / (dT * dT);
    end

    theta_d   = amps * s;
    thetad_d  = amps * sd;
    thetadd_d = amps * sdd;
end
