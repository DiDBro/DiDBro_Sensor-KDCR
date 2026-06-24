clearvars, clc
l0 = 0.3;
l1 = 0.9;
l2 = 0.7;


omega1 = [0;0;1];
omega2 = omega1;
omega3 = omega1;
v4     = [0;0;1];
q1 = [0;0;0];
q2 = [0;l1;0];
q3 = [0;l1+l2;0];
xi1 = [-hatm_num(omega1)*q1;omega1];
xi2 = [-hatm_num(omega2)*q2;omega2];
xi3 = [-hatm_num(omega3)*q3;omega3];
xi4 = [v4;zeros(3,1)];

xi = [xi1,xi2,xi3,xi4];
m1 = 35;
m2 = 25;
m3 = 18;
m4 = 7;
Ix1 = m1*l1*l1/12;
Iy1 = 0.05*Ix1;
Iz1 = Ix1;

Ix2 = m2*l2*l2/12;
Iy2 = 0.05*Ix2;
Iz2 = Ix2;

Iz3 = 0.1*Iz2;
Ix3 = 0.2*Iz3;
Iy3 = 0.2*Iz3;
Iz4 = 0.6*Iz3;
Ix4 = 0.2*Iz4;
Iy4 = 0.2*Iz4;

% as in Eq (4.9) p. 162
calM1 = [m1*eye(3) zeros(3);zeros(3) diag([Ix1 Iy1 Iz1])];
calM2 = [m2*eye(3) zeros(3);zeros(3) diag([Ix2 Iy2 Iz2])];
calM3 = [m3*eye(3) zeros(3);zeros(3) diag([Ix3 Iy3 Iz3])];
calM4 = [m4*eye(3) zeros(3);zeros(3) diag([Ix4 Iy4 Iz4])];
r1 = l1*0.4;
r2 = l2*0.45;
gsl10     = [eye(3) [0;r1;0.3];zeros(1,3),1];
Adgsl10   = adjmg(gsl10);
Adgsl10m1 = inv(Adgsl10);
gsl20     = [eye(3) [0;l1+r2;0.4];zeros(1,3),1];
Adgsl20   = adjmg(gsl20);
Adgsl20m1 = inv(Adgsl20);
gsl30     = [eye(3) [0;l1+l2;0.5];zeros(1,3),1];
Adgsl30   = adjmg(gsl30);
Adgsl30m1 = inv(Adgsl30);
gsl40     = [eye(3) [0;l1+l2;l0];zeros(1,3),1];
Adgsl40   = adjmg(gsl40);
Adgsl40m1 = inv(Adgsl40);
% Eq (4.28) p. 176
calMp            = Adgsl10m1'*calM1*Adgsl10m1;
calMp(1:6,1:6,2) = Adgsl20m1'*calM2*Adgsl20m1;
calMp(1:6,1:6,3) = Adgsl30m1'*calM3*Adgsl30m1;
calMp(1:6,1:6,4) = Adgsl40m1'*calM4*Adgsl40m1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% beta1 = 0.1; % Nms/rad
% beta2 = 0.05; % Nms/rad
% beta3 = 0.04; % Nms/rad
% beta4 = 1.0; % Ns/m
beta1 = 0.9; % Nms/rad
beta2 = 0.45; % Nms/rad
beta3 = 0.4; % Nms/rad
beta4 = 0.9; % Ns/m
% beta1 = 10.0; % Nms/rad
% beta2 = 5; % Nms/rad
% beta3 = 4; % Nms/rad
% beta4 = 10.0; % Ns/m
beta = [beta1,beta2,beta3,beta4];
m4g = m4*9.81;
theta1 = 0.3*pi;
theta2 = 0.2*pi;
theta3 = 0.35*pi;
theta4 = -0.03;

theta = [theta1,theta2,theta3,theta4];
dtheta = [0,0,0,0];
dtheta(1) = 0.08;
dtheta(2) = 0.15;
dtheta(3) = 0.25;
dtheta(4) = 0.07;


lM = zeros(4);
for ii = 1:4
        for jj = 1:4
            lM(ii,jj) = max([ii,jj]);
        end
end

[M,C,N] = MCN(xi,calMp,lM,beta,m4g,theta,dtheta);

load y-yd-ydd.mat
load ts2.mat
st0 = 1; % step start time for calculation of step in SIMULINK
st1 = st0 + 0.1;
st2 = st0 + 0.3;
st3 = st0 + 0.4;

