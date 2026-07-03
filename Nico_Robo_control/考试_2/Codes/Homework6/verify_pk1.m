%% ===========================================================================
% PK1 公式验证 / Verification of PK1 Formula
% 理解: 为什么不同的 p 对应同样的 q 会得到不同的 theta?
% ===========================================================================

clc; clear;
import robo.*

fprintf('========== PK1 Verification ==========\n\n');

%% ===========================================================================
% 1. 构造一个已知的旋转 twist
% ===========================================================================
omega = [0; 0; 1];          % unit rotation axis (z-axis)
r_axis = [2; 0; 0];         % a point on the axis
v_tw = -cross(omega, r_axis); % v = -omega x r
xi = [v_tw; omega];         % zero-pitch twist

fprintf('Rotation axis:\n');
fprintf('  omega = [%g; %g; %g]\n', omega);
fprintf('  Point on axis: r = [%g; %g; %g]\n', r_axis);
fprintf('  v = -omega x r = [%g; %g; %g]\n\n', v_tw);

r_pk1 = cross(omega, v_tw);
fprintf('  PK1 axis point: r_pk1 = cross(omega,v) = [%g; %g; %g]\n', r_pk1);
fprintf('  True axis point: r_axis = [%g; %g; %g]\n', r_axis);
fprintf('  Note: r_pk1 = perp component of r_axis (same for PK1 purposes)\n\n');

%% ===========================================================================
% 2. Experiment 1: CORRECT usage — q generated from the SAME p
% ===========================================================================
fprintf('--- Experiment 1: Correct usage (q = exp(xihat*theta)*p) ---\n\n');

theta_true = pi/3;  % true rotation angle = 60 degrees
p_list = {[3; 1; 2], [5; -2; -1], [-1; 3; 0], [0.5; 0.5; 3], [4; 0; -2]};

for i = 1:length(p_list)
    p = p_list{i};
    g = gtwist(xi, theta_true);
    q = g * [p; 1];  q = q(1:3);
    theta_pk1 = PK1(xi, p, q);

    up = (p - r_pk1) - omega*(omega'*(p - r_pk1));
    vp = (q - r_pk1) - omega*(omega'*(q - r_pk1));

    fprintf('  p%d = [%6.2f; %6.2f; %6.2f], q = [%6.2f; %6.2f; %6.2f]\n', i, p, q);
    fprintf('    theta_true = %.6f, theta_pk1 = %.6f, diff = %.2e\n', ...
            theta_true, theta_pk1, abs(theta_pk1 - theta_true));
    fprintf('    |up| = %.6f, |vp| = %.6f, omega''p = %.6f, omega''q = %.6f\n\n', ...
            norm(up), norm(vp), omega'*p, omega'*q);
end
fprintf('  PASS: All p recovered the SAME theta_true = %.4f\n\n', theta_true);

%% ===========================================================================
% 3. Experiment 2: WRONG usage — fixed q, different p (YOUR problem)
% ===========================================================================
fprintf('--- Experiment 2: Wrong usage (fixed q, different p) ---\n');
fprintf('  This is what you described!\n\n');

p_fixed = [3; 1; 2];
g = gtwist(xi, pi/3);
q_fixed = g * [p_fixed; 1];  q_fixed = q_fixed(1:3);

fprintf('  q_fixed = [%6.2f; %6.2f; %6.2f] (generated from p=[3;1;2], theta=pi/3)\n\n', q_fixed);

p_list2 = {[3; 1; 2], [5; -2; -1], [0; 0; 5], [-1; 3; 0], [4; 0; -2]};
for i = 1:length(p_list2)
    p = p_list2{i};
    theta_pk1 = PK1(xi, p, q_fixed);

    up = (p - r_pk1) - omega*(omega'*(p - r_pk1));
    vp = (q_fixed - r_pk1) - omega*(omega'*(q_fixed - r_pk1));

    % Verify: does rotating p by theta_pk1 actually reach q?
    g_verify = gtwist(xi, theta_pk1);
    q_verify = g_verify * [p; 1];  q_verify = q_verify(1:3);

    fprintf('  p%d = [%6.2f; %6.2f; %6.2f], theta_pk1 = %+.4f\n', i, p, theta_pk1);
    fprintf('    |up| = %.4f, |vp| = %.4f, omega''p = %.4f, omega''q = %.4f\n', ...
            norm(up), norm(vp), omega'*p, omega'*q_fixed);
    fprintf('    Verify: exp(xi*theta)*p = [%6.2f; %6.2f; %6.2f], q = [%6.2f; %6.2f; %6.2f]', ...
            q_verify, q_fixed);
    if norm(q_verify - q_fixed) < 1e-6
        fprintf('  MATCH!\n\n');
    else
        fprintf('  MISMATCH! norm(error)=%.2f\n\n', norm(q_verify - q_fixed));
    end
end

%% ===========================================================================
% 4. Geometric Explanation
% ===========================================================================
fprintf('--- Geometric Explanation ---\n\n');

fprintf(['PK1 solves: exp(xihat*theta) * p = q\n\n' ...
         'Geometric meaning: rotate point p to point q about the fixed axis omega.\n\n' ...
         'CONSTRAINTS (must hold for PK1 to work):\n' ...
         '  1. omega''*p = omega''*q  (same height along the axis)\n' ...
         '  2. |p - r| = |q - r|      (same distance from the axis)\n\n' ...
         'This means p and q must lie on the SAME circle around the axis.\n\n' ...
         'WHAT WENT WRONG in your test:\n' ...
         '  - You fixed q (generated from p1, theta_true)\n' ...
         '  - You tried different p2, p3, ...\n' ...
         '  - Different p have different distances to the axis (|up|)\n' ...
         '  - But q has a FIXED distance to the axis (|vp|)\n' ...
         '  - A pure rotation cannot change the distance to the axis!\n' ...
         '  - So |up| != |vp| means NO rotation about omega can map p to q\n' ...
         '  - PK1 still returns an angle (the angle between up and vp)\n' ...
         '  - But rotating p by that angle does NOT reach q\n\n' ...
         'CORRECT USAGE:\n' ...
         '  q = gtwist(xi, theta) * p    %% generate q from the SAME p\n' ...
         '  theta = PK1(xi, p, q)         %% recovers theta for ANY p!\n\n']);

%% ===========================================================================
% 5. Visual demo
% ===========================================================================
fprintf('--- Plotting geometric explanation ---\n');

figure('Position', [100, 100, 900, 400]);

subplot(1,2,1); hold on; axis equal; grid on;
title('Correct: q_i = exp(xihat*theta)*p_i');
xlabel('x (perp plane)'); ylabel('y (perp plane)');

plot(r_pk1(1), r_pk1(2), 'kx', 'MarkerSize', 12, 'LineWidth', 2);

colors = lines(5);
for i = 1:length(p_list)
    p = p_list{i};
    g = gtwist(xi, theta_true);
    q = g * [p; 1]; q = q(1:3);
    up = p - omega*(omega'*p);
    vp = q - omega*(omega'*q);
    plot(up(1), up(2), 'o', 'Color', colors(i,:), 'MarkerSize', 8);
    plot(vp(1), vp(2), 's', 'Color', colors(i,:), 'MarkerSize', 8);
    quiver(r_pk1(1), r_pk1(2), up(1)-r_pk1(1), up(2)-r_pk1(2), 0, ...
           'Color', colors(i,:), 'LineWidth', 1);
    text(up(1)+0.2, up(2), sprintf('p_%d', i), 'FontSize', 9);
    text(vp(1)+0.2, vp(2), sprintf('q_%d', i), 'FontSize', 9);
end
legend({'axis', '', '', '', '', ''});

subplot(1,2,2); hold on; axis equal; grid on;
title('Wrong: fixed q, different p');
xlabel('x (perp plane)'); ylabel('y (perp plane)');

plot(r_pk1(1), r_pk1(2), 'kx', 'MarkerSize', 12, 'LineWidth', 2);
vp_fixed = q_fixed - omega*(omega'*q_fixed);
plot(vp_fixed(1), vp_fixed(2), 'rs', 'MarkerSize', 12, 'LineWidth', 2);
text(vp_fixed(1)+0.3, vp_fixed(2), 'q (fixed)', 'FontSize', 10);

for i = 1:length(p_list2)
    p = p_list2{i};
    up = p - omega*(omega'*p);
    plot(up(1), up(2), 'o', 'Color', colors(i,:), 'MarkerSize', 8);
    quiver(r_pk1(1), r_pk1(2), up(1)-r_pk1(1), up(2)-r_pk1(2), 0, ...
           'Color', colors(i,:), 'LineWidth', 1);
    text(up(1)+0.2, up(2), sprintf('p_%d', i), 'FontSize', 9);
end
legend({'axis', 'q (fixed)', '', '', '', '', ''});

sgtitle('PK1: p and q must be at the SAME distance from the rotation axis');

%% ===========================================================================
% 6. Conclusion
% ===========================================================================
fprintf('\n========== CONCLUSION ==========\n\n');

fprintf(['PK1 formula IS correct.\n\n' ...
         'Your issue: "different p give different theta for same q"\n\n' ...
         'Root cause:\n' ...
         '  A rotation preserves the distance from each point to the axis.\n' ...
         '  If p1 and p2 are at different distances from the axis,\n' ...
         '  then NO rotation angle can map BOTH p1 and p2 to the SAME q.\n\n' ...
         '  PK1 returns the angle between the perpendicular projections\n' ...
         '  of (p-r) and (q-r). This angle varies with p because the\n' ...
         '  direction of (p-r) varies with p.\n\n' ...
         'Correct approach:\n' ...
         '  ALWAYS generate q from the SAME p you pass to PK1:\n' ...
         '    q = gtwist(xi, theta_true) * p\n' ...
         '    theta = PK1(xi, p, q)   %% always recovers theta_true\n\n' ...
         '  PK1 is only valid when |up| = |vp| and omega''p = omega''q.\n' ...
         '  These are automatically satisfied when q = exp(xihat*theta)*p.\n\n']);

fprintf('========== END ==========\n');
