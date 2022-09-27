function cb_startup(app, oldSettings, shouldRun, dynamics, inputs, outputs, parameters)
% oldSettings allows loading the data/settings from a previous run.
% parameters allows overriding any settings (gets merged into oldSettings or defaults)

if ~exist('inputs', 'var')
    inputs = [];
end

if ~exist('outputs', 'var')
    outputs = [];
end

% Show panels corresponding to the current state
app.CurrentState = 'LoadButton';
app.setupState();

components = properties(app);
for i = 1:length(components)
    app.(components{i}).Tag = components{i};
end

app.MainWindow = app.UIFigure;

filename = app.getDefaultExperimentName();
app.ExperimentNameEditField.Value = filename(1:end-4);

app.setupTabs();

if exist('oldSettings', 'var') && ~isempty(oldSettings)
    app.SavedData = oldSettings;
end

if ~app.hasData("PreprocessData")
    app.SavedData.PreprocessData = struct;
end

% Fill default parameters in app.SavedData
app.initSettings();

if exist('dynamics', 'var') && ~isempty(dynamics)
    [rawData, trialData, trialSwitches, inputs, outputs] = ...
        looper.flattenData(dynamics, inputs, outputs);

    app.SavedData.RawData = rawData;
    app.SavedData.TrialData = trialData;
    if ~isempty(trialSwitches)
        app.SavedData.RawTrialSwitches = trialSwitches;
    end
    if ~isempty(inputs)
        app.SavedData.Inputs = inputs;
    end
    if ~isempty(outputs)
        app.SavedData.Outputs = outputs;
    end
end

% override from contents of parameters
if exist('parameters', 'var') && ~isempty(parameters)
    fields = fieldnames(parameters);

    for i = 1:length(fields)
        if strcmp(fields{i}, 'PreprocessData')
            preprocessParameters = parameters.PreprocessData;
            preprocessFields = fieldnames(preprocessParameters);

            for j = 1:length(preprocessFields)
                app.SavedData.PreprocessData.(preprocessFields{j}) = preprocessParameters.(preprocessFields{j});
            end
        else
            app.SavedData.(fields{i}) = parameters.(fields{i});
        end
    end
end

% enable/disable buttons and fields
app.checkStepValidity();
% fill values in UI from SavedData
app.setUpUI();

if exist('shouldRun', 'var') && ~isempty(shouldRun) && shouldRun
    app.RunAllSteps();

    app.SaveToWorkSpace();

    close(app.UIFigure);
end
end