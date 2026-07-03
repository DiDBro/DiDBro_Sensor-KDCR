function plot_HW7_PartA()
% PLOT_HW7_PARTA  Generate figures from HW7 Part A simulation data
%   Run AFTER:  initialize_simulink; simOut = sim('HW7_PartA');

    % Get data from workspace
    theta = evalin('base', 'theta_out');
    tau   = evalin('base', 'tau_out');
    time  = evalin('base', 'tout');  % Simulink's built-in time output

    % Compute reference trajectory for comparison
    theta_d = zeros(length(time), 4);
    for i = 1:length(time)
        [td, ~, ~] = ref_quintic_step(time(i));
        theta_d(i, :) = td';
    end

    % Joint names
    jnames = {'Joint 1 (revolute)', 'Joint 2 (revolute)', ...
              'Joint 3 (revolute)', 'Joint 4 (prismatic)'};
    units  = {'rad', 'rad', 'rad', 'm'};
    targets = [2, 1, 0.5, 0.08];

    % ===== Figure 1: Joint position tracking =====
    figure('Name', 'HW7 Part A - Joint Tracking', 'Position', [100, 100, 900, 700]);
    for j = 1:4
        subplot(4, 1, j);
        plot(time, theta_d(:, j), 'b--', 'LineWidth', 1.5); hold on;
        plot(time, theta(:, j), 'r-', 'LineWidth', 1.5);
        yline(targets(j), 'k:', 'LineWidth', 1);
        ylabel(sprintf('\\theta_%d (%s)', j, units{j}));
        legend('\theta_d', '\theta', 'target', 'Location', 'best');
        title(jnames{j});
        grid on;
    end
    xlabel('Time (s)');
    sgtitle('HW7 Part (a): CTC Joint Position Tracking');

    % ===== Figure 2: Tracking errors =====
    figure('Name', 'HW7 Part A - Tracking Errors', 'Position', [150, 100, 900, 500]);
    for j = 1:4
        subplot(2, 2, j);
        plot(time, theta_d(:, j) - theta(:, j), 'r-', 'LineWidth', 1.5);
        ylabel(sprintf('e_%d (%s)', j, units{j}));
        title(jnames{j});
        grid on;
    end
    xlabel('Time (s)');
    sgtitle('HW7 Part (a): Tracking Errors  e = \theta_d - \theta');

    % ===== Figure 3: Control torques =====
    figure('Name', 'HW7 Part A - Control Torques', 'Position', [200, 100, 900, 700]);
    tau_limits = [6000, 2000, 1000, 100];
    for j = 1:4
        subplot(4, 1, j);
        plot(time, tau(:, j), 'b-', 'LineWidth', 1.5); hold on;
        yline( tau_limits(j), 'r--', 'LineWidth', 1);
        yline(-tau_limits(j), 'r--', 'LineWidth', 1);
        ylabel(sprintf('\\tau_%d (Nm)', j));
        legend('\tau', 'saturation limit', 'Location', 'best');
        title(sprintf('Joint %d Torque (limit = ±%g)', j, tau_limits(j)));
        grid on;
    end
    xlabel('Time (s)');
    sgtitle('HW7 Part (a): Control Torques with Saturation');

    % ===== Summary stats =====
    fprintf('\n=== HW7 Part (a) Summary ===\n');
    fprintf('Simulation time: %.1f s,  %d steps\n', time(end), length(time));
    fprintf('Joint  |  Target  |  Final   |  Error    |  Max |tau|\n');
    fprintf('-------+----------+----------+-----------+----------\n');
    for j = 1:4
        fprintf('  %d    | %8.4f | %8.4f | %9.2e | %8.1f\n', ...
            j, targets(j), theta(end, j), theta(end, j)-targets(j), max(abs(tau(:, j))));
    end
    fprintf('\nPlots generated. Save figures for your report.\n');
end
