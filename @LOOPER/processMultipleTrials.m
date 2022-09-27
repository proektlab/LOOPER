function [success, rawData, inputs, outputs, trialData] = processMultipleTrials(app, affix)
success = false;
rawData = [];
trialData = [];
inputs = [];
outputs = [];

app.removeData([affix 'RawData']);
app.removeData([affix 'Inputs']);
app.removeData([affix 'Outputs']);
app.removeData([affix 'TrialData']);

if evalin('base', ['exist(''' app.DataEditField.Value ''', ''var'')'])
    rawData = evalin('base', app.DataEditField.Value);

    if evalin('base', ['exist(''' app.InputsEditField.Value ''', ''var'')'])
        inputs = evalin('base', app.InputsEditField.Value);
    else
        inputs = [];
    end

    if evalin('base', ['exist(''' app.OutputsEditField.Value ''', ''var'')'])
        outputs = evalin('base', app.OutputsEditField.Value);
    else
        outputs = [];
    end

    [rawData, trialData, trialSwitches, inputs, outputs] = ...
        looper.flattenData(rawData, inputs, outputs);

    app.SavedData.([affix 'RawData']) = rawData;
    app.SavedData.([affix 'TrialData']) = trialData;
    if ~isempty(inputs)
        app.SavedData.([affix 'Inputs']) = inputs;
    end
    if ~isempty(outputs)
        app.SavedData.([affix 'Outputs']) = outputs;
    end
    if ~isempty(trialSwitches)
        app.SavedData.([affix 'RawTrialSwitches']) = trialSwitches;
    end

    success = true;
else
    app.warning(['Variable ' app.DataEditField.Value ' not found in workspace.'])
end
end