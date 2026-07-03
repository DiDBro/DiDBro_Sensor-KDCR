%clearvars, clc
%l0 = 0.2;
l1 = 0.9;
l2 = 0.7;
omega1 = [1;0;0];
omega2 = omega1;
%omega3 = omega1;
%v4     = [0;0;1];
q1 = [0;0;0];
q2 = [0;0;-l1];
%q3 = [0;l1+l2;0];
xi1 = [-hatm_num(omega1)*q1;omega1];
xi2 = [-hatm_num(omega2)*q2;omega2];
%xi3 = [-hatm_num(omega3)*q3;omega3];
%xi4 = [v4;zeros(3,1)];

%xi = [xi1,xi2,xi3,xi4];
xi = [xi1,xi2];
m1 = 35;
m2 = 25;
%m3 = 20;
%m4 = 5;
Ix1 = m1*l1*l1/12;
Iy1 = 0.05*Ix1;
Iz1 = Ix1;
Ix2 = m2*l2*l2/12;
Iy2 = 0.05*Ix2;
Iz2 = Ix2;
%Iz3 = 0.1*Iz2;
%Ix3 = 2*Iz3;
%Iy3 = 2*Iz3;
%Iz4 = 0.6*Iz3;
%Ix4 = 2*Iz4;
%Iy4 = 2*Iz4;

% as in Eq (4.9) p. 162
calM1 = [m1*eye(3) zeros(3);zeros(3) diag([Ix1 Iy1 Iz1])];
calM2 = [m2*eye(3) zeros(3);zeros(3) diag([Ix2 Iy2 Iz2])];
%calM3 = [m3*eye(3) zeros(3);zeros(3) diag([Ix3 Iy3 Iz3])];
%calM4 = [m4*eye(3) zeros(3);zeros(3) diag([Ix4 Iy4 Iz4])];
r1 = l1*0.4;
r2 = l2*0.45;
gsl10     = [eye(3) [0;0;-r1];zeros(1,3),1];
Adgsl10   = adjmg(gsl10);
Adgsl10m1 = inv(Adgsl10);
gsl20     = [eye(3) [0;0;-l1-r2];zeros(1,3),1];
Adgsl20   = adjmg(gsl20);
Adgsl20m1 = inv(Adgsl20);
%gsl30     = [eye(3) [0;l1+l2;0.5];zeros(1,3),1];
%Adgsl30   = adjmg(gsl30);
%Adgsl30m1 = inv(Adgsl30);
%gsl40     = [eye(3) [0;l1+l2;l0];zeros(1,3),1];
%Adgsl40   = adjmg(gsl40);
%Adgsl40m1 = inv(Adgsl40);
% Eq (4.28) p. 176
calMp            = Adgsl10m1'*calM1*Adgsl10m1;
calMp(1:6,1:6,2) = Adgsl20m1'*calM2*Adgsl20m1;
%calMp(1:6,1:6,3) = Adgsl30m1'*calM3*Adgsl30m1;
%calMp(1:6,1:6,4) = Adgsl40m1'*calM4*Adgsl40m1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% beta1 = 0.1; % Nms/rad
% beta2 = 0.05; % Nms/rad
% beta3 = 0.04; % Nms/rad
% beta4 = 1.0; % Ns/m
beta1 = 0.9; % Nms/rad
beta2 = 0.45; % Nms/rad
%beta3 = 0.4; % Nms/rad
%beta4 = 1.0; % Ns/m
% beta1 = 10.0; % Nms/rad
% beta2 = 5; % Nms/rad
% beta3 = 4; % Nms/rad
% beta4 = 10.0; % Ns/m
%beta = [beta1,beta2,beta3,beta4];
beta = [beta1,beta2];
format long
theta1 = 1;
theta2 = 2;
%theta3 = pi/2.5;
%theta4 = -0.04;

%theta = [theta1,theta2,theta3,theta4];
theta = [theta1,theta2];
%dtheta = [0,0,0,0];
%dtheta(1) = 0.05;
%dtheta(2) = 0.1;
%dtheta(3) = 0.2;
%dtheta(4) = 0.03;
dtheta = [1,2];
%dtheta(1) = 0;
%dtheta(2) = 0;

lM = zeros(2);
for ii = 1:2
        for jj = 1:2
            lM(ii,jj) = max([ii,jj]);
        end
end

l1 = 0.9; l2 =0.7;
r1 = 0.4*l1; 
r2 = 0.45*l2;
m1 = 35;m2 =25;
I1xx = m1*l1^2/12;I1zz = I1xx;I1yy = 0.05*I1xx;
I2xx = m2*l2^2/12;I2zz = I2xx;I2yy = 0.05*I2xx;
beta1 = 0.9; beta2 = 0.45;

[M,C,N] = MCNsim(xi,calMp,lM,beta,theta,dtheta);
rs1 = out.rs1;
load rs1.mat
%rs1 = out.rs1;
%save('rs1.mat','rs1')
