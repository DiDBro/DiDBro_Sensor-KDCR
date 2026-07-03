function [M, C, N] = MCNsim_ws(theta, dtheta)
% MCNSIM_WS  Wrapper for MCNsim that reads parameters from base workspace
%   [M, C, N] = MCNsim_ws(theta, dtheta)
%
%   This wrapper allows MCNsim to be called from Simulink MATLAB Function
%   blocks without passing all the robot parameters as block inputs.
%   The parameters (xi, calMp, lM, beta, m4g) must be defined in the
%   MATLAB base workspace by running initialize_simulink.m first.

    % Read parameters from base workspace
    xi    = evalin('base', 'xi');
    calMp = evalin('base', 'calMp');
    lM    = evalin('base', 'lM');
    beta  = evalin('base', 'beta');

    [M, C, N] = MCNsim(xi, calMp, lM, beta, theta, dtheta);
end
