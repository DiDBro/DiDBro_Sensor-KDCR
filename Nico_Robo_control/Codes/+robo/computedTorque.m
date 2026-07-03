function tau = computedTorque(theta_d, thetad_d, thetadd_d, theta, thetad, ...
                              xi, calMp, lM, beta, Kp, Kv)
% COMPUTEDTORQUE  计算力矩控制器 CTC (Computed Torque Control)
%    tau = computedTorque(theta_d, thetad_d, thetadd_d, theta, thetad, ...
%                         xi, calMp, lM, beta, Kp, Kv)
%
%    控制律:
%        τ = M(θ)·θ̈* + C(θ,θ̇)·θ̇ + N(θ,θ̇)
%        θ̈* = θ̈_d + Kᵥ(θ̇_d−θ̇) + Kₚ(θ_d−θ)
%
%    误差动力学 (模型精确时):
%        ë + Kᵥ·ė + Kₚ·e = 0   (解耦线性误差动力学)
%
%    增益设计 (临界阻尼 ζ=1):
%        Kp = ωₙ²,  Kv = 2ωₙ
%        常用: ωₙ=50 → Kp=2500, Kv=100
    import robo.*
    n = length(theta);
    if nargin < 10, Kp = 2500; end
    if nargin < 11, Kv = 100; end
    if isscalar(Kp), Kp = Kp * ones(n,1); end
    if isscalar(Kv), Kv = Kv * ones(n,1); end

    e    = theta_d(:)  - theta(:);
    edot = thetad_d(:) - thetad(:);
    thetadd_star = thetadd_d(:) + Kv(:).*edot + Kp(:).*e;
    tau = inverseDynamics(thetadd_star, thetad, theta, xi, calMp, lM, beta);
end
