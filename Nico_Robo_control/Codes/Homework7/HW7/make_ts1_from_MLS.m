clearvars, clc

initialize_simulink

mdl = 'MLS4_4_rounded_step_inputR2024a';
load_system(mdl)

subsystem = [mdl '/Subsystem'];
ports = get_param(subsystem, 'PortHandles');
signalNames = {'y', 'yd', 'ydd'};

for ii = 1:numel(signalNames)
    set_param(ports.Outport(ii), 'DataLogging', 'on');
    set_param(ports.Outport(ii), 'DataLoggingNameMode', 'Custom');
    set_param(ports.Outport(ii), 'DataLoggingName', signalNames{ii});
end

simOut = sim(mdl);
logsout = simOut.logsout;

t = logsout.get(signalNames{1}).Values.Time;
data = zeros(numel(t), numel(signalNames));

for ii = 1:numel(signalNames)
    data(:, ii) = logsout.get(signalNames{ii}).Values.Data(:);
end

ts1 = timeseries(data, t);
save('generated_from_MLS.mat', 'ts1')

whos ts1
disp('size(ts1.Time) =')
disp(size(ts1.Time))
disp('size(ts1.Data) =')
disp(size(ts1.Data))
