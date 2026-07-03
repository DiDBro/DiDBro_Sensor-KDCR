function [M, C, N] = inertiaMatrix(xi, calMp, lM, beta, theta, thetad)
% INERTIAMATRIX  组装关节空间动力学矩阵 (基于 twist 公式, MLS §4.3)
%    [M, C, N] = inertiaMatrix(xi, calMp, lM, beta, theta, thetad)
%
%    输入:
%        xi     - 6×n twist 矩阵, 每列 ξ_i = [v_i; ω_i]
%        calMp  - 6×6×n 连杆广义惯性矩阵
%        lM     - n×n 耦合索引 (通常 lM(i,j)=max(i,j))
%        beta   - n×1 粘性摩擦系数
%        theta  - n×1 关节位置
%        thetad - n×1 关节速度
%
%    输出:
%        M - n×n 惯性矩阵 (正定对称)
%        C - n×n 科氏/离心力矩阵 (Ṁ−2C 反对称)
%        N - n×1 重力 + 摩擦项
%
%    公式:
%        M_{ij} = Σ_{l=max(i,j)}^n ξ_i^T·A_{li}^T·M_l·A_{lj}·ξ_j
%        C_{ij} = Σ_k Γ_{ijk}·θ̇_k  (Christoffel 符号)
%        N_i = −∂V/∂θ_i + β_i·θ̇_i

    import robo.*
    n = length(theta);

    % 预先计算 g_{0,i}
    g = cell(1, n+1);  g{1} = eye(4);
    for i = 1:n
        g{i+1} = g{i} * gtwist(xi(:,i), theta(i));
    end

    % A_{i,j} = Ad_{g_{j,i}}^{-1}
    A = cell(n, n);
    for i = 1:n
        for j = 1:n
            if i > j
                A{i,j} = inv(adjoint(inv(g{j+1}) * g{i+1}));
            elseif i == j, A{i,j} = eye(6);
            else, A{i,j} = zeros(6);
            end
        end
    end

    % M
    M = zeros(n);
    for i = 1:n, for j = 1:n
        for l = max(i,j):n
            M_l = calMp(1:6,1:6,l);
            M(i,j) = M(i,j) + xi(:,i)' * A{l,i}' * M_l * A{l,j} * xi(:,j);
        end
    end, end

    % C (Christoffel)
    C = zeros(n);
    for i = 1:n, for j = 1:n, for k = 1:n
        C(i,j) = C(i,j) + 0.5 * (dM_dth(xi,calMp,A,i,j,k,n) ...
            + dM_dth(xi,calMp,A,i,k,j,n) - dM_dth(xi,calMp,A,k,j,i,n)) * thetad(k);
    end, end, end

    % N (gravity + friction)
    G_base = [0; 0; -9.81; 0; 0; 0];
    grad_V = zeros(n,1);
    for i = 1:n
        s = 0;
        for l = i:n
            M_l = calMp(1:6,1:6,l);
            s = s + xi(:,i)' * inv(adjoint(g{l+1}))' * M_l * G_base;
        end
        grad_V(i) = -s;
    end
    N = -grad_V + beta(:) .* thetad(:);
end

function dM = dM_dth(xi, calMp, A, i, j, k, n)
    dM = 0;
    for l = max(i,j):n
        if k <= l
            M_l = calMp(1:6,1:6,l);
            ad_ki = robo.ad(A{k,i} * xi(:,i));
            ad_kj = robo.ad(A{k,j} * xi(:,j));
            dM = dM + (ad_ki*xi(:,k))'*A{l,k}'*M_l*A{l,j}*xi(:,j) ...
                    + xi(:,i)'*A{l,i}'*M_l*A{l,k}*(ad_kj*xi(:,k));
        end
    end
end
