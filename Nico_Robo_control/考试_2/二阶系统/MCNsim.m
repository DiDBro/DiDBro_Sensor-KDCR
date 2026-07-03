function [Ms,Cs,Ns] = MCNsim(xi,calMp,lM,beta,theta,dtheta)
    n = length(theta);
    Ms = zeros(n, n);
    Cs = zeros(n, n);
    % Ns = zeros(n, 1);
    
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
            Ms(i, j) = M_ij;
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
            Cs(i, j) = C_ij;
        end
    end
    
    % ========== 步骤5：计算 N（根据图片公式和你的物理参数） ==========
    % 公式：N_i = ∂V/∂θ_i + β_i * θ̇_i
    
    % 5.1 计算重力势能梯度 ∂V/∂θ_i
    % ========== 步骤5：计算 N（使用解析公式，确保正确） ==========
% ========== 步骤5：计算 N（解析公式，纯数值，兼容 Simulink） ==========
    % 定义物理参数（与主脚本保持一致）
    r1 = 0.36;      % 0.9 * 0.4
    r2 = 0.315;     % 0.7 * 0.45
    g_val = 9.81;
    m1 = 35;
    m2 = 25;
    l1 = 0.9;

    % 计算势能梯度 ∂V/∂θ（解析式，无需符号）
    th1 = theta(1);
    th2 = theta(2);
    grad_V = zeros(n,1);
    grad_V(1) = m1*g_val*r1*sin(th1) + m2*g_val*(l1*sin(th1) + r2*sin(th1+th2));
    grad_V(2) = m2*g_val*r2*sin(th1+th2);

    % 摩擦项
    friction_term = beta(:) .* dtheta(:);

    % 最终 Ns（因为你的方程是 tau = M*ddq + C*dq + Ns）
    Ns = grad_V + friction_term;

end

% ========== 辅助函数：计算重力势能梯度 ∂V/∂θ (已根据你的代码调整) ==========


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

function Ad_g = adjmg(g)
        % 提取旋转和平移部分
    R = g(1:3, 1:3);
    p = g(1:3, 4);
    
    % 计算平移向量的反对称矩阵（使用自定义函数）
    p_hat = hatm_num(p);
    
    % 按照图片中的公式组装伴随矩阵
    % 形式： [R, p_hat*R; 0, R]
    Ad_g = [R,         p_hat * R;
            zeros(3),  R];
end