function [M, C, N] = MCN(xi, calMp, lM, beta, m4g, theta, dtheta)
    n = length(theta);
    M = zeros(n, n);
    C = zeros(n, n);
    % N = zeros(n, 1);
    
    % ========== 关键步骤1：预先计算所有需要的变换矩阵 g = exp(ξθ) ==========
    g = cell(1, n+1);
    g{1} = eye(4);
    for i = 1:n
        xi_i = xi(:, i);
        g_joint = expm(hat_se3(xi_i) * theta(i));
        g{i+1} = g{i} * g_joint;
    end
    
    % ========== 关键步骤2：计算所有 A_{ij} ==========
    A = cell(n, n);
    for i = 1:n
        for j = 1:n
            if i > j
                g_ji = inv(g{j+1}) * g{i+1};
                A{i,j} = inv(adjmg(g_ji));
            elseif i == j
                A{i,j} = eye(6);
            else
                A{i,j} = zeros(6);
            end
        end
    end
    
    % ========== 步骤3：计算惯性矩阵 M ==========
    for i = 1:n
        for j = 1:n
            M_ij = 0;
            for l = lM(i, j):n
                M_l = calMp(1:6, 1:6, l);
                term = xi(:, i)' * A{l, i}' * M_l * A{l, j} * xi(:, j);
                M_ij = M_ij + term;
            end
            M(i, j) = M_ij;
        end
    end
    
    % ========== 步骤4：计算科氏矩阵 C（解析公式） ==========
    for i = 1:n
        for j = 1:n
            C_ij = 0;
            for k = 1:n
                dM_ij_dtheta_k = compute_partial_M(xi, calMp, lM, A, i, j, k, n);
                dM_ik_dtheta_j = compute_partial_M(xi, calMp, lM, A, i, k, j, n);
                dM_kj_dtheta_i = compute_partial_M(xi, calMp, lM, A, k, j, i, n);
                C_ij = C_ij + 0.5 * (dM_ij_dtheta_k + dM_ik_dtheta_j - dM_kj_dtheta_i) * dtheta(k);
            end
            C(i, j) = C_ij;
        end
    end
    
    % ========== 步骤5：计算 N（根据图片公式和你的物理参数） ==========
    % 公式：N_i = ∂V/∂θ_i + β_i * θ̇_i
    
    % 5.1 计算重力势能梯度 ∂V/∂θ_i
    grad_V = compute_gravity_potential_gradient(xi, calMp, g, n);
    
    % 5.2 计算粘性摩擦项 β_i * θ̇_i 
    % 你的beta是向量: [beta1, beta2, beta3, beta4]，单位对应各关节类型
    friction_term = beta(:) .* dtheta(:); % 确保维度匹配
    
    % 5.3 计算总N项: N = ∂V/∂θ + β * θ̇
    N = -grad_V + friction_term;
end

% ========== 辅助函数：计算重力势能梯度 ∂V/∂θ (已根据你的代码调整) ==========
function grad_V = compute_gravity_potential_gradient(xi, calMp, g, n)
    % 计算重力势能 V(θ) 关于 θ 的梯度
    % 根据旋量理论：∂V/∂θ_i = Σ_{l=i}^n ξ_i^T * (Ad^{-1}(g_{0l}))^T * M_l * G_0
    % 其中 G_0 是基座标系下的重力旋量
    
    grad_V = zeros(n, 1);
    
    % 基座标系下的重力加速度向量 (沿负z轴，大小9.81 m/s²)
    % 注意：重力对旋量的贡献取决于表示法
    % 对于空间旋量 ξ = [v; ω]，重力旋量为 G = [0; -g]
    g_accel = [0; 0; -9.81]; % 重力加速度向量
    
    % 构造基座标系下的重力旋量 G_0
    % 根据你的旋量构造方式 (xi = [-hat(w)*q; w])，这是空间旋量表示
    % 对于空间旋量，重力只有线速度部分：G_0 = [-g_accel; 0]
    G_base = zeros(6, 1);
    G_base(1:3) = -g_accel; % 线速度部分：负重力加速度
    G_base(4:6) = zeros(3,1); % 角速度部分：0
    
    for i = 1:n
        sum_term = 0;
        for l = i:n
            % 连杆 l 的空间惯性矩阵 (已在空间坐标系下，通过伴随变换得到)
            M_l = calMp(1:6, 1:6, l);
            
            % 从基座到连杆 l 的变换矩阵 g_{0l}
            g_0l = g{l+1};
            
            % 计算 Ad^{-1}(g_{0l}) 的转置
            Ad_inv = inv(adjmg(g_0l));
            Ad_inv_T = Ad_inv';
            
            % 计算该项对梯度 ∂V/∂θ_i 的贡献
            % 根据旋量理论，这是重力在关节i方向产生的广义力
            contribution = xi(:, i)' * Ad_inv_T * M_l * G_base;
            sum_term = sum_term + contribution;
        end
        
        % 得到的 sum_term 实际上是重力矩 G_i = -∂V/∂θ_i
        % 因此势能梯度为 ∂V/∂θ_i = -sum_term
        grad_V(i) = -sum_term;
    end
end

% ========== 其他辅助函数保持不变 ==========
function dM_ij_dtheta_k = compute_partial_M(xi, calMp, lM, A, i, j, k, n)
    dM_ij_dtheta_k = 0;
    
    for l = lM(i, j):n
        M_l = calMp(1:6, 1:6, l);
        xi_i = xi(:, i);
        xi_j = xi(:, j);
        xi_k = xi(:, k);
        
        if k <= l
            % 计算 ad(A_{ki} * xi_i)
            A_ki_xi_i = A{k, i} * xi_i;
            ad_Aki_xi_i = adjoint_lie_algebra(A_ki_xi_i);
            
            % 计算 ad(A_{kj} * xi_j)
            A_kj_xi_j = A{k, j} * xi_j;
            ad_Akj_xi_j = adjoint_lie_algebra(A_kj_xi_j);
            
            term1 = (ad_Aki_xi_i * xi_k)' * A{l, k}' * M_l * A{l, j} * xi_j;
            term2 = xi_i' * A{l, i}' * M_l * A{l, k} * (ad_Akj_xi_j * xi_k);
            
            dM_ij_dtheta_k = dM_ij_dtheta_k + term1 + term2;
        end
    end
end

function ad_xi = adjoint_lie_algebra(xi)
    v = xi(1:3);
    w = xi(4:6);
    w_hat = hatm_num(w);
    v_hat = hatm_num(v);
    ad_xi = [w_hat, v_hat;
             zeros(3), w_hat];
end

function se3 = hat_se3(xi)
    v = xi(1:3);
    w = xi(4:6);
    se3 = [hatm_num(w), v;
           zeros(1,3), 0];
end


function S = hatm_num(v)
    v1 = v(1);
    v2 = v(2);
    v3 = v(3);
    S = [0,   -v3,   v2;
         v3,   0,   -v1;
        -v2,   v1,   0];
end

function Ad_g = adjmg(g)
    R = g(1:3, 1:3);
    p = g(1:3, 4);
    p_hat = hatm_num(p);
    Ad_g = [R,         p_hat * R;
            zeros(3),  R];
end
