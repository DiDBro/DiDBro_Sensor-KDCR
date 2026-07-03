function tau = inverseDynamics(thetadd, thetad, theta, xi, calMp, lM, beta, gst0)
% INVERSEDYNAMICS  基于 twist 的递归逆动力学 (Recursive Newton-Euler)
%    tau = inverseDynamics(thetadd, thetad, theta, xi, calMp, lM, beta)
%    tau = inverseDynamics(thetadd, thetad, theta, xi, calMp, lM, beta, gst0)
%
%    输入:
%        thetadd - n×1 期望关节加速度
%        thetad  - n×1 关节速度
%        theta   - n×1 关节位置
%        xi      - 6×n 矩阵, 每列为 twist ξ_i = [v_i; ω_i]
%        calMp   - 6×6×n 数组, 每页为连杆 i 在自身坐标系中的广义惯性矩阵
%        lM      - n×n 上三角矩阵, lM(i,j) = min 公共连杆索引 (惯性耦合)
%        beta    - n×1 粘性摩擦系数
%        gst0    - (可选) 4×4 参考构型工具位姿, 默认 eye(4)
%
%    输出:
%        tau     - n×1 关节力矩/力
%
%    公式:
%        M(θ)·θ̈ + C(θ,θ̇)·θ̇ + N(θ,θ̇) = τ
%
%    参见: forwardDynamics, computedTorque

    import robo.*

    n = length(theta);
    if nargin < 8
        gst0 = eye(4);
    end

    % ===== 步骤 1: 计算 M, C, N =====
    % 利用 twist 公式组装

    % 预先计算所有 g_{0,i}
    g = cell(1, n+1);
    g{1} = eye(4);
    for i = 1:n
        g{i+1} = g{i} * gtwist(xi(:, i), theta(i));
    end

    % 计算 A 矩阵: A_{i,j} = Ad_{g_{j,i}}^{-1}
    A = cell(n, n);
    for i = 1:n
        for j = 1:n
            if i > j
                g_ji = inv(g{j+1}) * g{i+1};
                A{i,j} = inv(adjoint(g_ji));
            elseif i == j
                A{i,j} = eye(6);
            else
                A{i,j} = zeros(6);
            end
        end
    end

    % --- 惯性矩阵 M ---
    M = zeros(n, n);
    for i = 1:n
        for j = 1:n
            M_ij = 0;
            for l = lM(i,j):n
                M_l = calMp(1:6, 1:6, l);
                M_ij = M_ij + xi(:,i)' * A{l,i}' * M_l * A{l,j} * xi(:,j);
            end
            M(i,j) = M_ij;
        end
    end

    % --- 科氏矩阵 C (利用 Christoffel 符号) ---
    C = zeros(n, n);
    for i = 1:n
        for j = 1:n
            C_ij = 0;
            for k = 1:n
                dM_ij_k = partialM(xi, calMp, lM, A, i, j, k, n);
                dM_ik_j = partialM(xi, calMp, lM, A, i, k, j, n);
                dM_kj_i = partialM(xi, calMp, lM, A, k, j, i, n);
                C_ij = C_ij + 0.5 * (dM_ij_k + dM_ik_j - dM_kj_i) * thetad(k);
            end
            C(i,j) = C_ij;
        end
    end

    % --- 重力/势能力 N ---
    g_accel = [0; 0; -9.81];
    G_base = [g_accel; zeros(3,1)];   % 空间坐标系中的重力旋量

    grad_V = zeros(n, 1);
    for i = 1:n
        sum_term = 0;
        for l = i:n
            M_l = calMp(1:6, 1:6, l);
            Ad_inv = inv(adjoint(g{l+1}));
            sum_term = sum_term + xi(:,i)' * Ad_inv' * M_l * G_base;
        end
        grad_V(i) = -sum_term;  % ∂V/∂θ_i = -重力广义力
    end

    N = -grad_V + beta(:) .* thetad(:);

    % ===== 步骤 2: 逆动力学 =====
    tau = M * thetadd(:) + C * thetad(:) + N;
end

% ========== 辅助函数: ∂M/∂θ_k ==========
function dM = partialM(xi, calMp, lM, A, i, j, k, n)
    dM = 0;
    for l = lM(i, j):n
        if k <= l
            M_l = calMp(1:6, 1:6, l);
            xi_i = xi(:, i);  xi_j = xi(:, j);  xi_k = xi(:, k);

            A_ki_xi = A{k,i} * xi_i;
            ad_ki = ad(A_ki_xi);
            A_kj_xi = A{k,j} * xi_j;
            ad_kj = ad(A_kj_xi);

            term1 = (ad_ki * xi_k)' * A{l,k}' * M_l * A{l,j} * xi_j;
            term2 = xi_i' * A{l,i}' * M_l * A{l,k} * (ad_kj * xi_k);
            dM = dM + term1 + term2;
        end
    end
end
