function build_HW7_PartA()
% BUILD_HW7_PARTA  Build clean CTC Simulink model for HW7 Part (a)
%   Uses Interpreted MATLAB Function blocks (1-in, 1-out) with Mux/Demux.
%   PREREQUISITE: run initialize_simulink.m first.
%
%   Architecture:
%     Clock → Ref_Gen_Wrap → Demux ──θ_d──┬──┐
%                              ├─θ̇_d───┤  │
%                              └─θ̈_d───┤  │  ┌───────────────────────────┐
%                                       │  │  │ From_theta ←── θ ────────┤
%                                       ▼  ▼  │ From_dtheta ←── θ̇ ──────┤
%                              Mux_CTC_5in → [CTC_Ctrl_vec] → Sat → [Plant_vec] → θ̈ → ∫ → θ̇ → ∫ → θ
%                                                                             ↑
%                                                        Mux_Plant_3in ←── τ, θ, θ̇

    model = 'HW7_PartA';
    if bdIsLoaded(model), close_system(model, 0); end
    new_system(model);
    open_system(model);

    % ===== ADD BLOCKS =====

    % Clock
    add_block('simulink/Sources/Clock', [model '/Clock']);
    set_param([model '/Clock'], 'Position', [30, 150, 80, 180]);

    % Reference Generator (returns [theta_d; thetad_d; thetadd_d] as 12x1)
    add_block('simulink/User-Defined Functions/Interpreted MATLAB Function', [model '/Ref_Gen_Wrap']);
    set_param([model '/Ref_Gen_Wrap'], 'Position', [150, 100, 330, 240]);
    set_param([model '/Ref_Gen_Wrap'], 'MATLABFcn', 'ref_gen_wrapper');
    set_param([model '/Ref_Gen_Wrap'], 'OutputDimensions', '12');

    % Demux: split 12x1 → three 4x1 (θ_d, θ̇_d, θ̈_d)
    add_block('simulink/Signal Routing/Demux', [model '/Demux_Ref']);
    set_param([model '/Demux_Ref'], 'Position', [390, 130, 410, 210]);
    set_param([model '/Demux_Ref'], 'Outputs', '[4 4 4]');

    % Mux for CTC: 5 inputs → 20x1 vector (virtual)
    add_block('simulink/Signal Routing/Mux', [model '/Mux_CTC']);
    set_param([model '/Mux_CTC'], 'Position', [480, 200, 500, 320]);
    set_param([model '/Mux_CTC'], 'Inputs', '5');

    % Signal Conversion: virtual → non-virtual (so it stays as 1 wide vector)
    add_block('simulink/Signal Attributes/Signal Conversion', [model '/SigConv_CTC']);
    set_param([model '/SigConv_CTC'], 'Position', [530, 250, 560, 270]);
    set_param([model '/SigConv_CTC'], 'ConversionOutput', 'Signal copy');

    % CTC Controller (1 input = 20x1, 1 output = 4x1 τ)
    add_block('simulink/User-Defined Functions/Interpreted MATLAB Function', [model '/CTC_Compute']);
    set_param([model '/CTC_Compute'], 'Position', [600, 100, 780, 260]);
    set_param([model '/CTC_Compute'], 'MATLABFcn', 'ctc_compute_vec');
    set_param([model '/CTC_Compute'], 'OutputDimensions', '4');

    % Saturation
    add_block('simulink/Discontinuities/Saturation', [model '/Saturation']);
    set_param([model '/Saturation'], 'Position', [850, 150, 900, 200]);
    set_param([model '/Saturation'], 'UpperLimit', '[6000; 2000; 1000; 100]');
    set_param([model '/Saturation'], 'LowerLimit', '[-6000; -2000; -1000; -100]');

    % Mux for Plant: 3 inputs → 12x1 [τ; θ; θ̇] (virtual)
    add_block('simulink/Signal Routing/Mux', [model '/Mux_Plant']);
    set_param([model '/Mux_Plant'], 'Position', [910, 250, 930, 340]);
    set_param([model '/Mux_Plant'], 'Inputs', '3');

    % Signal Conversion: virtual → non-virtual
    add_block('simulink/Signal Attributes/Signal Conversion', [model '/SigConv_Plant']);
    set_param([model '/SigConv_Plant'], 'Position', [960, 290, 990, 310]);
    set_param([model '/SigConv_Plant'], 'ConversionOutput', 'Signal copy');

    % Plant Dynamics (1 input = 12x1, 1 output = 4x1 θ̈)
    add_block('simulink/User-Defined Functions/Interpreted MATLAB Function', [model '/Plant_Dynamics']);
    set_param([model '/Plant_Dynamics'], 'Position', [1030, 100, 1210, 260]);
    set_param([model '/Plant_Dynamics'], 'MATLABFcn', 'plant_dynamics_vec');
    set_param([model '/Plant_Dynamics'], 'OutputDimensions', '4');

    % Integrators
    add_block('simulink/Continuous/Integrator', [model '/Integrator_dtheta']);
    set_param([model '/Integrator_dtheta'], 'Position', [1280, 100, 1340, 160]);
    set_param([model '/Integrator_dtheta'], 'InitialCondition', '[0; 0; 0; 0]');

    add_block('simulink/Continuous/Integrator', [model '/Integrator_theta']);
    set_param([model '/Integrator_theta'], 'Position', [1280, 200, 1340, 260]);
    set_param([model '/Integrator_theta'], 'InitialCondition', '[0.3*pi; 0.2*pi; 0.35*pi; -0.03]');

    % Goto for feedback
    add_block('simulink/Signal Routing/Goto', [model '/Goto_theta']);
    set_param([model '/Goto_theta'], 'Position', [1410, 200, 1460, 230]);
    set_param([model '/Goto_theta'], 'GotoTag', 'theta');
    set_param([model '/Goto_theta'], 'TagVisibility', 'local');

    add_block('simulink/Signal Routing/Goto', [model '/Goto_dtheta']);
    set_param([model '/Goto_dtheta'], 'Position', [1410, 110, 1460, 140]);
    set_param([model '/Goto_dtheta'], 'GotoTag', 'dtheta');
    set_param([model '/Goto_dtheta'], 'TagVisibility', 'local');

    % From blocks for CTC feedback
    add_block('simulink/Signal Routing/From', [model '/From_theta_CTC']);
    set_param([model '/From_theta_CTC'], 'Position', [380, 270, 440, 300]);
    set_param([model '/From_theta_CTC'], 'GotoTag', 'theta');

    add_block('simulink/Signal Routing/From', [model '/From_dtheta_CTC']);
    set_param([model '/From_dtheta_CTC'], 'Position', [380, 320, 440, 350]);
    set_param([model '/From_dtheta_CTC'], 'GotoTag', 'dtheta');

    % From blocks for Plant feedback
    add_block('simulink/Signal Routing/From', [model '/From_theta_Plant']);
    set_param([model '/From_theta_Plant'], 'Position', [850, 280, 910, 310]);
    set_param([model '/From_theta_Plant'], 'GotoTag', 'theta');

    add_block('simulink/Signal Routing/From', [model '/From_dtheta_Plant']);
    set_param([model '/From_dtheta_Plant'], 'Position', [850, 330, 910, 360]);
    set_param([model '/From_dtheta_Plant'], 'GotoTag', 'dtheta');

    % Scope for theta (compare θ_d vs θ)
    add_block('simulink/Commonly Used Blocks/Scope', [model '/Scope_theta']);
    set_param([model '/Scope_theta'], 'Position', [1550, 100, 1620, 200]);
    set_param([model '/Scope_theta'], 'NumInputPorts', '2');

    % Scope for torque
    add_block('simulink/Commonly Used Blocks/Scope', [model '/Scope_tau']);
    set_param([model '/Scope_tau'], 'Position', [1550, 240, 1620, 340]);

    % Mux for scope (θ_d + θ)
    add_block('simulink/Signal Routing/Mux', [model '/Mux_scope']);
    set_param([model '/Mux_scope'], 'Position', [1470, 120, 1490, 180]);
    set_param([model '/Mux_scope'], 'Inputs', '2');

    % To Workspace
    add_block('simulink/Sinks/To Workspace', [model '/ToWks_theta']);
    set_param([model '/ToWks_theta'], 'Position', [1550, 400, 1620, 440]);
    set_param([model '/ToWks_theta'], 'VariableName', 'theta_out');
    set_param([model '/ToWks_theta'], 'SaveFormat', 'Array');

    add_block('simulink/Sinks/To Workspace', [model '/ToWks_tau']);
    set_param([model '/ToWks_tau'], 'Position', [1550, 460, 1620, 500]);
    set_param([model '/ToWks_tau'], 'VariableName', 'tau_out');
    set_param([model '/ToWks_tau'], 'SaveFormat', 'Array');

    % ===== CONNECT =====

    % Forward path
    add_line(model, 'Clock/1', 'Ref_Gen_Wrap/1');
    add_line(model, 'Ref_Gen_Wrap/1', 'Demux_Ref/1');

    % Demux outputs → Mux_CTC (θ_d, θ̇_d, θ̈_d)
    add_line(model, 'Demux_Ref/1', 'Mux_CTC/1');
    add_line(model, 'Demux_Ref/2', 'Mux_CTC/2');
    add_line(model, 'Demux_Ref/3', 'Mux_CTC/3');

    % Feedback From → Mux_CTC (θ, θ̇)
    add_line(model, 'From_theta_CTC/1', 'Mux_CTC/4');
    add_line(model, 'From_dtheta_CTC/1', 'Mux_CTC/5');

    % Mux_CTC → SigConv_CTC → CTC_Compute
    add_line(model, 'Mux_CTC/1', 'SigConv_CTC/1');
    add_line(model, 'SigConv_CTC/1', 'CTC_Compute/1');

    % CTC_Compute → Saturation
    add_line(model, 'CTC_Compute/1', 'Saturation/1');

    % Saturation → Mux_Plant (τ)
    add_line(model, 'Saturation/1', 'Mux_Plant/1');

    % Feedback From → Mux_Plant (θ, θ̇)
    add_line(model, 'From_theta_Plant/1', 'Mux_Plant/2');
    add_line(model, 'From_dtheta_Plant/1', 'Mux_Plant/3');

    % Mux_Plant → SigConv_Plant → Plant_Dynamics
    add_line(model, 'Mux_Plant/1', 'SigConv_Plant/1');
    add_line(model, 'SigConv_Plant/1', 'Plant_Dynamics/1');

    % Plant_Dynamics → Integrator chain
    add_line(model, 'Plant_Dynamics/1', 'Integrator_dtheta/1');
    add_line(model, 'Integrator_dtheta/1', 'Integrator_theta/1');

    % Integrator → Goto
    add_line(model, 'Integrator_theta/1', 'Goto_theta/1');
    add_line(model, 'Integrator_dtheta/1', 'Goto_dtheta/1');

    % Scope connections
    add_line(model, 'Demux_Ref/1', 'Mux_scope/1');
    add_line(model, 'Integrator_theta/1', 'Mux_scope/2');
    add_line(model, 'Mux_scope/1', 'Scope_theta/1');
    add_line(model, 'Saturation/1', 'Scope_tau/1');

    % To Workspace
    add_line(model, 'Integrator_theta/1', 'ToWks_theta/1');
    add_line(model, 'Saturation/1', 'ToWks_tau/1');

    % ===== MODEL SETTINGS =====
    set_param(model, 'StopTime', '3');
    set_param(model, 'SolverType', 'Variable-step');
    set_param(model, 'Solver', 'ode45');
    set_param(model, 'MaxStep', '0.005');
    set_param(model, 'RelTol', '1e-6');

    % ===== SAVE =====
    save_system(model);
    fprintf('\n=== HW7_PartA built! ===\n');
    fprintf('Architecture:\n');
    fprintf('  Clock → Ref_GW → Demux ─[θ_d,θ̇_d,θ̈_d,θ,θ̇]→ Mux → CTC_vec → Sat\n');
    fprintf('  Sat ─[τ,θ,θ̇]→ Mux → Plant_vec → ∫dθ → ∫θ → Goto → From ─→ feedback\n');
    fprintf('\nTo run:  sim(''HW7_PartA'')\n');
end
