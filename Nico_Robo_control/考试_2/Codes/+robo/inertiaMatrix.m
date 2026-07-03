function [M, C, N] = inertiaMatrix(xi, calMp, lM, beta, theta, thetad)
% INERTIAMATRIX  组装关节空间动力学矩阵 (基于 twist 公式)
%    [M, C, N] = inertiaMatrix(xi, calMp, lM, beta, theta, thetad)
%
%    输入:
%        xi     - 6×n 矩阵, 每列为 twist ξ_i = [v_i; ω_i]
%        calMp  - 6×6×n 数组, calMp(:,:,l) = 连杆 l 在自身体坐标系中的广义惯性矩阵
%                  形式: [ m·I₃,   m·hat(c_l)ᵀ;
%                          m·hat(c_l),  I_{b,l}        ]
%        lM     - n×n 矩阵, lM(i,j) = min{ 同时影响 i,j 的最大公共连杆索引 }
%                 通常为 lM(i,j) = max(i, j), 即从 max(i,j) 开始累加
%        beta   - n×1 粘性摩擦系数向量
%        theta  - n×1 关节位置
%        thetad - n×1 关节速度
%
%    输出:
%        M - n×n 惯性矩阵 (正定对称)
%        C - n×n 科氏/离心力矩阵 (满足 Ṁ − 2C 为反对称)
%        N - n×1 重力 + 摩擦项
%
%    公式 (MLS §4.3):
%        M_{ij} = Σ_{l=max(i,j)}^n  ξ_i^T · A_{l,i}^T · M_l · A_{l,j} · ξ_j
%        其中 A_{l,i} = Ad_{g_{i,l}}^{-1}  (将 twist 从 i 系变换到 l 系)
%
%        C_{ij} = Σ_k Γ_{ijk} θ̇_k   (Christoffel 符号)
%        Γ_{ijk} = ½(∂M_{ij}/∂θ_k + ∂M_{ik}/∂θ_j − ∂M_{kj}/∂θ_i)
%
%        N_i = −∂V/∂θ_i + β_i·θ̇_i    (重力势能力 + 粘性摩擦)
%
%    注意:
%        - 科氏矩阵 C 的构造方式满足 Ṁ − 2C 反对称, 保证能量守恒
%        - C(θ,θ̇)·θ̇ 也可用 C_matrix * thetad 计算
%        - 如有外部力旋量, 需额外加入 J^T·F 项

    import robo.*
    n = length(theta);

    % ===== 1. 预先计算所有 g_{0,i} = e^{ξ̂₁θ₁} … e^{ξ̂_iθ_i} =====
    g = cell(1, n+1);
    g{1} = eye(4);
    for i = 1:n
        g{i+1} = g{i} * gtwist(xi(:, i), theta(i));
    end

    % ===== 2. 计算 A_{i,j} = Ad_{g_{j,i}}^{-1} =====
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

    % ===== 3. 惯性矩阵 M =====
    M = zeros(n, n);
    for i = 1:n
        for j = 1:n
            for l = max(i, j):n    % 或 lM(i,j):n
                M_l = calMp(1:6, 1:6, l);
                M(i,j) = M(i,j) + xi(:,i)' * A{l,i}' * M_l * A{l,j} * xi(:,j);
            end
        end
    end

    % ===== 4. 科氏矩阵 C (Christoffel 符号) =====
    C = zeros(n, n);
    for i = 1:n
        for j = 1:n
            for k = 1:n
                dM_ij_k = dM_dtheta(xi, calMp, lM, A, i, j, k, n);
                dM_ik_j = dM_dtheta(xi, calMp, lM, A, i, k, j, n);
                dM_kj_i = dM_dtheta(xi, calMp, lM, A, k, j, i, n);
                C(i,j) = C(i,j) + 0.5 * (dM_ij_k + dM_ik_j - dM_kj_i) * thetad(k);
            end
        end
    end

    % ===== 5. N = 势能力梯度 + 摩擦 =====
    g_accel = [0; 0; -9.81];
    G_base = [g_accel; zeros(3,1)];

    grad_V = zeros(n, 1);
    for i = 1:n
        s = 0;
        for l = i:n
            M_l = calMp(1:6, 1:6, l);
            Ad_inv = inv(adjoint(g{l+1}));
            s = s + xi(:,i)' * Ad_inv' * M_l * G_base;
        end
        grad_V(i) = -s;
    end

    N = -grad_V + beta(:) .* thetad(:);
end

% ========== 辅助: ∂M_{ij}/∂θ_k ==========
function dM = dM_dtheta(xi, calMp, lM, A, i, j, k, n)
    dM = 0;
    for l = max(i,j):n
        if k <= l
            M_l = calMp(1:6, 1:6, l);
            xi_i = xi(:,i);  xi_j = xi(:,j);  xi_k = xi(:,k);

            % ad_{A_{ki}·ξ_i}
            ad_ki = robo.ad(A{k,i} * xi_i);
            % ad_{A_{kj}·ξ_j}
            ad_kj = robo.ad(A{k,j} * xi_j);

            dM = dM + (ad_ki * xi_k)' * A{l,k}' * M_l * A{l,j} * xi_j ...
                    + xi_i' * A{l,i}' * M_l * A{l,k} * (ad_kj * xi_k);
        end
    end
end
