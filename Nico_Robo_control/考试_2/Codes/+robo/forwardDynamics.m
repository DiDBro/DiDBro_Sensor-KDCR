function thetadd = forwardDynamics(tau, thetad, theta, xi, calMp, lM, beta)
% FORWARDDYNAMICS  正动力学: 从关节力矩计算关节加速度
%    thetadd = forwardDynamics(tau, thetad, theta, xi, calMp, lM, beta)
%
%    输入:
%        tau    - n×1 关节力矩/力 (驱动力)
%        thetad - n×1 关节速度
%        theta  - n×1 关节位置
%        xi     - 6×n twist 矩阵
%        calMp  - 6×6×n 连杆惯性矩阵
%        lM     - n×n 惯性耦合索引
%        beta   - n×1 粘性摩擦系数
%
%    输出:
%        thetadd - n×1 关节加速度
%
%    公式 (MLS §4.2):
%        M(θ) · θ̈ = τ − C(θ,θ̇) · θ̇ − N(θ,θ̇)
%        θ̈ = M^{-1} (τ − C · θ̇ − N)
%
%    参见: inverseDynamics, computedTorque

    % 调用逆动力学计算 M, C, N (传入 thetadd=0 仅用于组装矩阵)
    [M, C, N] = computeMCN(xi, calMp, lM, beta, theta, thetad);

    % 正动力学: θ̈ = M⁻¹ (τ − C θ̇ − N)
    thetadd = M \ (tau(:) - C * thetad(:) - N);
end

% ========== 内部函数: 计算 M, C, N (与 inverseDynamics 共用) ==========
function [M, C, N] = computeMCN(xi, calMp, lM, beta, theta, dtheta)
    import robo.*
    n = length(theta);

    % 预先计算 g_{0,i}
    g = cell(1, n+1);
    g{1} = eye(4);
    for i = 1:n
        g{i+1} = g{i} * gtwist(xi(:, i), theta(i));
    end

    % A 矩阵
    A = cell(n, n);
    for i = 1:n
        for j = 1:n
            if i > j
                g_ji = inv(g{j+1}) * g{i+1};
                A{i,j} = inv(adjoint(g_ji));
            elseif i == j, A{i,j} = eye(6);
            else, A{i,j} = zeros(6);
            end
        end
    end

    % M
    M = zeros(n);
    for i = 1:n
        for j = 1:n
            for l = lM(i,j):n
                M_l = calMp(1:6,1:6,l);
                M(i,j) = M(i,j) + xi(:,i)' * A{l,i}' * M_l * A{l,j} * xi(:,j);
            end
        end
    end

    % C (Christoffel)
    C = zeros(n);
    for i = 1:n
        for j = 1:n
            for k = 1:n
                C(i,j) = C(i,j) + 0.5 * (partialM(xi,calMp,lM,A,i,j,k,n) + ...
                    partialM(xi,calMp,lM,A,i,k,j,n) - partialM(xi,calMp,lM,A,k,j,i,n)) * dtheta(k);
            end
        end
    end

    % N (gravity + friction)
    g_accel = [0;0;-9.81];  G_base = [g_accel; zeros(3,1)];
    grad_V = zeros(n,1);
    for i = 1:n
        s = 0;
        for l = i:n
            M_l = calMp(1:6,1:6,l);
            Ad_inv = inv(adjoint(g{l+1}));
            s = s + xi(:,i)' * Ad_inv' * M_l * G_base;
        end
        grad_V(i) = -s;
    end
    N = -grad_V + beta(:) .* dtheta(:);
end

function dM = partialM(xi, calMp, lM, A, i, j, k, n)
    dM = 0;
    for l = lM(i,j):n
        if k <= l
            M_l = calMp(1:6,1:6,l);
            xi_i=xi(:,i); xi_j=xi(:,j); xi_k=xi(:,k);
            ad_ki = robo.ad(A{k,i}*xi_i);
            ad_kj = robo.ad(A{k,j}*xi_j);
            dM = dM + (ad_ki*xi_k)'*A{l,k}'*M_l*A{l,j}*xi_j ...
                    + xi_i'*A{l,i}'*M_l*A{l,k}*(ad_kj*xi_k);
        end
    end
end
