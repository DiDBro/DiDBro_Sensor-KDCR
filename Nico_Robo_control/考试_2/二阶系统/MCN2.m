function [Ms,Cs,Ns] = MCN2(xi,calMp,lM,beta,m,gsl0,theta,dtheta)
% MCNsim_EXAM
% Computes the inertia matrix M, Coriolis matrix C, and nonlinear term N
% for an open-chain manipulator using the Product of Exponentials formulation.
%
% Inputs:
%   xi      : 6 x n matrix of joint twists, each column is [v; w]
%   calMp   : 6 x 6 x n transformed spatial inertia matrices M'_i
%   lM      : n x n matrix with lM(i,j) = max(i,j)
%   beta    : n x 1 or 1 x n viscous friction coefficients
%   m       : n x 1 or 1 x n link masses
%   gsl0    : 4 x 4 x n initial COM frame configurations g_sl_i(0)
%   theta   : n x 1 or 1 x n joint positions
%   dtheta  : n x 1 or 1 x n joint velocities
%
% Outputs:
%   Ms      : n x n inertia matrix M(theta)
%   Cs      : n x n Coriolis matrix C(theta,dtheta)
%   Ns      : n x 1 nonlinear term, here gravity + viscous friction

    theta  = theta(:);
    dtheta = dtheta(:);
    beta   = beta(:);
    m      = m(:);

    n = length(theta);

    Ms = zeros(n,n);
    Cs = zeros(n,n);

    % ============================================================
    % Step 1: Compute the cumulative POE transformations
    %
    % g{1}   = identity
    % g{i+1} = exp(xi_1 theta_1) ... exp(xi_i theta_i)
    % ============================================================
    g = cell(1,n+1);
    g{1} = eye(4);

    for i = 1:n
        xi_i = xi(:,i);
        g_joint = expm(hat_se3(xi_i) * theta(i));
        g{i+1} = g{i} * g_joint;
    end

    % ============================================================
    % Step 2: Compute all A_{ij} matrices used in Proposition 4.3
    %
    % A_{ij} = Ad^{-1}(g_{ji}) for i > j
    % A_{ii} = I
    % A_{ij} = 0 for i < j
    % ============================================================
    A = cell(n,n);

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

    % ============================================================
    % Step 3: Compute the inertia matrix M(theta)
    %
    % M_ij = sum_{l=max(i,j)}^n xi_i^T A_li^T M'_l A_lj xi_j
    % ============================================================
    for i = 1:n
        for j = 1:n
            M_ij = 0;

            for l = lM(i,j):n
                M_l = calMp(:,:,l);

                term = xi(:,i)' * A{l,i}' * M_l * A{l,j} * xi(:,j);

                M_ij = M_ij + term;
            end

            Ms(i,j) = M_ij;
        end
    end

    % ============================================================
    % Step 4: Compute the Coriolis matrix C(theta,dtheta)
    %
    % C_ij = 1/2 sum_k (dM_ij/dtheta_k
    %                 + dM_ik/dtheta_j
    %                 - dM_kj/dtheta_i) dtheta_k
    % ============================================================
    for i = 1:n
        for j = 1:n
            C_ij = 0;

            for k = 1:n
                dM_ij_dtheta_k = compute_partial_M(xi,calMp,lM,A,i,j,k,n);
                dM_ik_dtheta_j = compute_partial_M(xi,calMp,lM,A,i,k,j,n);
                dM_kj_dtheta_i = compute_partial_M(xi,calMp,lM,A,k,j,i,n);

                C_ij = C_ij + 0.5 * ...
                    (dM_ij_dtheta_k + dM_ik_dtheta_j - dM_kj_dtheta_i) ...
                    * dtheta(k);
            end

            Cs(i,j) = C_ij;
        end
    end

    % ============================================================
    % Step 5: Compute N(theta,dtheta)
    %
    % For the exam 2R manipulator, both revolute axes are horizontal.
    % Therefore gravity produces joint torques and must be included.
    %
    % Potential energy:
    %   V(theta) = sum_i m_i g z_i(theta)
    %
    % Gravity vector:
    %   G(theta) = dV/dtheta
    %
    % Nonlinear term:
    %   N = G(theta) + beta .* dtheta
    % ============================================================
    gravity_term = compute_gravity_gradient_fd(xi,gsl0,m,theta);

    friction_term = beta .* dtheta;

    Ns = gravity_term + friction_term;
end

% =================================================================
% Compute dM_ij / dtheta_k using the analytical formula
% from Proposition 4.3.
% =================================================================
function dM_ij_dtheta_k = compute_partial_M(xi,calMp,lM,A,i,j,k,n)

    dM_ij_dtheta_k = 0;

    for l = lM(i,j):n
        M_l = calMp(:,:,l);

        xi_i = xi(:,i);
        xi_j = xi(:,j);
        xi_k = xi(:,k);

        if k <= l
            A_ki_xi_i = A{k,i} * xi_i;
            A_kj_xi_j = A{k,j} * xi_j;

            ad_Aki_xi_i = adjoint_lie_algebra(A_ki_xi_i);
            ad_Akj_xi_j = adjoint_lie_algebra(A_kj_xi_j);

            term1 = (ad_Aki_xi_i * xi_k)' ...
                    * A{l,k}' * M_l * A{l,j} * xi_j;

            term2 = xi_i' * A{l,i}' * M_l * A{l,k} ...
                    * (ad_Akj_xi_j * xi_k);

            dM_ij_dtheta_k = dM_ij_dtheta_k + term1 + term2;
        end
    end
end

% =================================================================
% Compute the gravity vector by finite difference of potential energy.
%
% This is more robust for the exam model because the two revolute
% axes are horizontal and the COM height changes with theta.
% =================================================================
function grad_V = compute_gravity_gradient_fd(xi,gsl0,m,theta)

    n = length(theta);
    h = 1e-6;

    grad_V = zeros(n,1);

    for i = 1:n
        e = zeros(n,1);
        e(i) = 1;

        V_plus  = potential_energy_POE(xi,gsl0,m,theta + h*e);
        V_minus = potential_energy_POE(xi,gsl0,m,theta - h*e);

        grad_V(i) = (V_plus - V_minus) / (2*h);
    end
end

% =================================================================
% Compute potential energy using POE kinematics.
%
% For each link i:
%   g_sl_i(theta) = exp(xi_1 theta_1) ... exp(xi_i theta_i) g_sl_i(0)
%
% Since frame L_i is attached to the COM of link i, the z-coordinate
% of g_sl_i(theta) is directly the COM height.
% =================================================================
function V = potential_energy_POE(xi,gsl0,m,theta)

    n = length(theta);
    g0 = 9.81;

    g = cell(1,n+1);
    g{1} = eye(4);

    for i = 1:n
        g_joint = expm(hat_se3(xi(:,i)) * theta(i));
        g{i+1} = g{i} * g_joint;
    end

    V = 0;

    for i = 1:n
        gsl_i = g{i+1} * gsl0(:,:,i);

        z_i = gsl_i(3,4);

        V = V + m(i) * g0 * z_i;
    end
end

% =================================================================
% Lie algebra adjoint operator ad_xi.
%
% For xi = [v; w],
%
% ad_xi = [ w_hat   v_hat
%           0       w_hat ]
% =================================================================
function ad_xi = adjoint_lie_algebra(xi)

    v = xi(1:3);
    w = xi(4:6);

    w_hat = hatm_num(w);
    v_hat = hatm_num(v);

    ad_xi = [w_hat,    v_hat;
             zeros(3), w_hat];
end

% =================================================================
% Convert a 6D twist xi = [v; w] into a 4x4 se(3) matrix.
% =================================================================
function se3 = hat_se3(xi)

    v = xi(1:3);
    w = xi(4:6);

    se3 = [hatm_num(w), v;
           zeros(1,3), 0];
end

% =================================================================
% Adjoint transformation matrix.
%
% For g = [R p; 0 1],
%
% Ad_g = [ R      p_hat R
%          0      R       ]
%
% This convention matches xi = [v; w].
% =================================================================
function Ad_g = adjmg(g)

    R = g(1:3,1:3);
    p = g(1:3,4);

    p_hat = hatm_num(p);

    Ad_g = [R,          p_hat * R;
            zeros(3),   R];
end