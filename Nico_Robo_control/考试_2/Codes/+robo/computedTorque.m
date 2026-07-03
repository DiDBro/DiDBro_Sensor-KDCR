function tau = computedTorque(theta_d, thetad_d, thetadd_d, theta, thetad, ...
                              xi, calMp, lM, beta, Kp, Kv)
% COMPUTEDTORQUE  计算力矩控制器 (Computed Torque Control, CTC)
%    tau = computedTorque(theta_d, thetad_d, thetadd_d, theta, thetad, ...
%                         xi, calMp, lM, beta, Kp, Kv)
%
%    输入:
%        theta_d   - n×1 期望关节位置
%        thetad_d  - n×1 期望关节速度
%        thetadd_d - n×1 期望关节加速度 (前馈)
%        theta     - n×1 实际关节位置
%        thetad    - n×1 实际关节速度
%        xi        - 6×n twist 矩阵
%        calMp     - 6×6×n 连杆惯性矩阵
%        lM        - n×n 惯性耦合索引
%        beta      - n×1 粘性摩擦系数
%        Kp        - 位置增益 (标量或 n×1)
%        Kv        - 速度增益 (标量或 n×1)
%
%    输出:
%        tau       - n×1 关节控制力矩
%
%    控制律:
%        τ = M(θ)·θ̈* + C(θ,θ̇)·θ̇ + N(θ,θ̇)
%
%    其中:
%        θ̈* = θ̈_d + Kᵥ·(θ̇_d − θ̇) + Kₚ·(θ_d − θ)
%
%    这是前馈 + PD 反馈的复合控制:
%        - 前馈项: M(θ)·θ̈_d + C(θ,θ̇)·θ̇_d + N(θ,θ̇)
%        - 反馈项: M(θ)·(Kᵥ·ė + Kₚ·e)   (误差动力学)
%
%    误差动力学 (当模型精确时):
%        M(θ)·(ë + Kᵥ·ė + Kₚ·e) = 0
%        → ë + Kᵥ·ė + Kₚ·e = 0   (解耦的线性误差动力学)
%
%    增益设计 (二阶系统, 临界阻尼 ζ=1):
%        Kp = ωₙ²              (位置增益)
%        Kv = 2·ζ·ωₙ = 2·ωₙ   (速度增益)

    import robo.*
    n = length(theta);

    % 默认增益
    if nargin < 10
        Kp = 2500;   % ωₙ = 50
    end
    if nargin < 11
        Kv = 100;    % 2ζωₙ = 100, ζ = 1
    end

    % 确保维度
    if isscalar(Kp), Kp = Kp * ones(n, 1); end
    if isscalar(Kv), Kv = Kv * ones(n, 1); end

    % 跟踪误差
    e    = theta_d(:)  - theta(:);
    edot = thetad_d(:) - thetad(:);

    % 期望加速度 + PD 修正
    thetadd_star = thetadd_d(:) + Kv(:) .* edot + Kp(:) .* e;

    % 逆动力学: τ = M·θ̈* + C·θ̇ + N
    tau = inverseDynamics(thetadd_star, thetad, theta, xi, calMp, lM, beta);
end
