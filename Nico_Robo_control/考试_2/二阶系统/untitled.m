clearvars, clc

g0 = 9.81;

% ===== Geometry =====
l1 = 0.9; %%FROM EXAM VALUE
l2 = 0.7; %%FROM EXAM VALUE

% COM distances from each joint
r1 = 0.4*l1; %%FROM EXAM VALUE
r2 = 0.45*l2; %%FROM EXAM VALUE

% ===== Joint twists =====
omega1 = [1;0;0];
omega2 = [1;0;0];

q1 = [0;0;0];
q2 = [0;0;-l1];

xi1 = [-hatm_num(omega1)*q1; omega1];
xi2 = [-hatm_num(omega2)*q2; omega2];

xi = [xi1, xi2];

% ===== Masses =====
m1 = 35;  %%FROM EXAM VALUE
m2 = 25;  %%FROM EXAM VALUE
m = [m1; m2];

% ===== Inertia tensors about COM frames =====
% Replace these with values given in the exam if provided
Ix1 = m1*l1*l1/12;   %%FROM EXAM VALUE
Iy1 = 0.05*Ix1;   %%FROM EXAM VALUE
Iz1 = Ix1;   %%FROM EXAM VALUE

Ix2 = m2*l2*l2/12;  %%FROM EXAM VALUE
Iy2 = 0.05*Ix2;   %%FROM EXAM VALUE
Iz2 = Ix2;    %%FROM EXAM VALUE

I1 = diag([Ix1, Iy1, Iz1]);
I2 = diag([Ix2, Iy2, Iz2]);

calM1 = [m1*eye(3), zeros(3);
         zeros(3),  I1];

calM2 = [m2*eye(3), zeros(3);
         zeros(3),  I2];

% ===== Initial COM frames =====
gsl10 = [eye(3), [0;0;-r1];
         zeros(1,3), 1];

gsl20 = [eye(3), [0;0;-l1-r2];
         zeros(1,3), 1];

gsl0 = zeros(4,4,2);
gsl0(:,:,1) = gsl10;
gsl0(:,:,2) = gsl20;

% ===== Transformed inertia matrices =====
Adgsl10m1 = inv(adjmg(gsl10));
Adgsl20m1 = inv(adjmg(gsl20));

calMp = zeros(6,6,2);
calMp(:,:,1) = Adgsl10m1' * calM1 * Adgsl10m1;
calMp(:,:,2) = Adgsl20m1' * calM2 * Adgsl20m1;

% ===== Friction =====
beta1 = 0.9;  %%FROM EXAM VALUE
beta2 = 0.45;  %%FROM EXAM VALUE
beta = [beta1; beta2];

% ===== Initial condition =====
theta = [1; 2];
dtheta = [1; 2];

% ===== lM matrix =====
n = 2;
lM = zeros(n,n);
for ii = 1:n
    for jj = 1:n
        lM(ii,jj) = max(ii,jj);
    end
end

% ===== Test M, C, N =====
format long;
[M,C,N] = MCN2(xi,calMp,lM,beta,m,gsl0,theta,dtheta);

% ===== Rounded step parameters =====
stepp = [0; 0.25; 2];  % [st0; t1; t3]
theta_des = [2;1];
% dtheta_des = theta_des;