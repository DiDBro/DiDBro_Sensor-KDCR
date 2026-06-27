%% Homework 6 — 螺旋桨进动力矩 (Newton-Euler 方程)
%  飞机水平转弧, 机身以 ω_p 绕 z 轴偏航
%  螺旋桨以 ω_s 绕机身 y 轴高速旋转
%  体坐标系 B 初始与机体系 A 重合, 后绕 y 轴转 θ (螺旋桨自转)
%
%  Newton-Euler (体坐标系):  τ_B = I_B·α_B + ω_B × (I_B·ω_B)
%  再变换回机体系:           τ_A = R · τ_B

clc; clear; close all;
addpath(fileparts(fileparts(mfilename('fullpath'))));
import robo.*

%% ===== 1. 符号推导 (syms) =====
syms omega_s omega_p theta real
syms I I0 real   % I 用于 part (a) 双叶, I0 用于 part (b) 八叶

%% 1.1 旋转矩阵: B → A, 绕 y 轴转 θ
R = Ry(theta);   % robo 里的 Ry

%% 1.2 总角速度与角加速度 (机体系 A 中)
%  ω_p = [0; 0; ω_p],  ω_s = [0; ω_s; 0]
omega_A = [0; omega_s; omega_p];

%  螺旋桨相对机身的 ω_s 恒定, 但机身以 ω_p 旋转
%  → 在机体系中 ω_s 的方向不变, 对其求导 = ω_p × ω_s (进动角加速度)
alpha_A = cross([0; 0; omega_p], [0; omega_s; 0]);   % = [-ω_p·ω_s; 0; 0]

%% 1.3 变换到体坐标系 B
omega_B = R' * omega_A;    % ω_B = R^T · ω_A
alpha_B = R' * alpha_A;    % α_B = R^T · α_A

fprintf('===== 符号结果: ω_B =====\n');  pretty(omega_B);
fprintf('===== 符号结果: α_B =====\n');  pretty(alpha_B);

%% 1.4 Part (a) 双叶螺旋桨 (细杆): I_B = diag([I, I, 0])
I_Ba = diag([I, I, 0]);
h_Ba = I_Ba * omega_B;                              % I_B·ω_B
tau_Ba_sym = I_Ba * alpha_B + cross(omega_B, h_Ba); % Newton-Euler
tau_Aa_sym = R * tau_Ba_sym;                        % → 机体系

fprintf('\n===== Part (a) τ_B  (体坐标系) =====\n');
pretty(simplify(tau_Ba_sym));
fprintf('===== Part (a) τ_A  (机体系) =====\n');
pretty(simplify(tau_Aa_sym));

%% 1.5 Part (b) 八叶螺旋桨 (薄盘): I_B = diag([I0, 2*I0, I0])
I_Bb = diag([I0, 2*I0, I0]);
h_Bb = I_Bb * omega_B;
tau_Bb_sym = I_Bb * alpha_B + cross(omega_B, h_Bb);
tau_Ab_sym = R * tau_Bb_sym;

fprintf('\n===== Part (b) τ_B  (体坐标系) =====\n');
pretty(simplify(tau_Bb_sym));
fprintf('===== Part (b) τ_A  (机体系) =====\n');
pretty(simplify(tau_Ab_sym));

%% ===== 2. 代数值 (三个角度 θ = 0, π/4, π/2) =====
ws = 420;    % rad/s
wp = 0.1;    % rad/s
Ia = 2.26;   % kg·m², part (a)
Ib = 4.52;   % kg·m², part (b)

thetas = [0, pi/4, pi/2];
theta_labels = {'θ = 0', 'θ = π/4', 'θ = π/2'};

tau_Ba_val = sym(zeros(3, 3));  tau_Aa_val = sym(zeros(3, 3));
tau_Bb_val = sym(zeros(3, 3));  tau_Ab_val = sym(zeros(3, 3));

fprintf('\n============== 数值结果 ==============\n');

for k = 1:3
    th = thetas(k);
    vals = {omega_s, ws; omega_p, wp; theta, th};

    tau_Ba_val(:,k) = double(subs(tau_Ba_sym, vals));
    tau_Aa_val(:,k) = double(subs(tau_Aa_sym, vals));
    tau_Bb_val(:,k) = double(subs(tau_Bb_sym, vals));
    tau_Ab_val(:,k) = double(subs(tau_Ab_sym, vals));
end

% --- 打印 Part (a) ---
fprintf('\n========== Part (a) 双叶螺旋桨 (I = %.2f) ==========\n', Ia);
for k = 1:3
    fprintf('\n--- %s ---\n', theta_labels{k});
    fprintf('  τ_B = [%10.4f; %10.4f; %10.4f] N·m  (体坐标系)\n', tau_Ba_val(:,k));
    fprintf('  τ_A = [%10.4f; %10.4f; %10.4f] N·m  (机体系)\n',   tau_Aa_val(:,k));
end

% --- 打印 Part (b) ---
fprintf('\n========== Part (b) 八叶螺旋桨 (I0 = %.2f) ==========\n', Ib);
for k = 1:3
    fprintf('\n--- %s ---\n', theta_labels{k});
    fprintf('  τ_B = [%10.4f; %10.4f; %10.4f] N·m  (体坐标系)\n', tau_Bb_val(:,k));
    fprintf('  τ_A = [%10.4f; %10.4f; %10.4f] N·m  (机体系)\n',   tau_Ab_val(:,k));
end

%% ===== 3. 表格汇总 =====
fprintf('\n\n============== 汇总表格 ==============\n');

fprintf('\n--- Part (a) 双叶螺旋桨 ---\n');
fprintf(' θ      | τ_B (体坐标系) N·m        | τ_A (机体系) N·m\n');
fprintf('--------|-----------------------------|---------------------------\n');
for k = 1:3
    fprintf(' %-6s | [%7.2f %7.2f %7.2f] | [%7.2f %7.2f %7.2f]\n', ...
        theta_labels{k}, tau_Ba_val(:,k), tau_Aa_val(:,k));
end

fprintf('\n--- Part (b) 八叶螺旋桨 ---\n');
fprintf(' θ      | τ_B (体坐标系) N·m        | τ_A (机体系) N·m\n');
fprintf('--------|-----------------------------|---------------------------\n');
for k = 1:3
    fprintf(' %-6s | [%7.2f %7.2f %7.2f] | [%7.2f %7.2f %7.2f]\n', ...
        theta_labels{k}, tau_Bb_val(:,k), tau_Ab_val(:,k));
end

%% ===== 4. 结论 =====
fprintf('\n============== 结论与观察 ==============\n');
fprintf(['\n1. 八叶螺旋桨 (轴对称圆盘 I_xx=I_zz):\n' ...
         '   τ_A = [%.2f; 0; 0] N·m, 与 θ 无关 → 恒定进动力矩.\n' ...
         '   这是经典的陀螺仪效应: 轴对称转子偏航时产生恒定陀螺力矩.\n'], tau_Ab_val(1,1));

fprintf(['\n2. 双叶螺旋桨 (细杆 I_xx=I_yy, I_zz=0):\n' ...
         '   τ_A 的 x,z 分量随 θ 做 sin(2θ)/cos²(θ) 周期性振荡.\n' ...
         '   θ=0 时 |τ_Ax| 最大 (%.2f N·m), θ=π/2 时 τ_A = 0.\n' ...
         '   → 发动机每转产生 2 个力矩脉冲, 导致机身周期性振动.\n'], max(abs(tau_Aa_val(1,:))));

fprintf(['\n3. 这是航空工程中双叶 vs 多叶螺旋桨选择的力学依据:\n' ...
         '   多叶 (轴对称) 消除周期性振动, 但重量和阻力增加.\n']);
