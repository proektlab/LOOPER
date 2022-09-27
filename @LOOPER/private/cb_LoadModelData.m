function cb_LoadModelData(app, ~)
if ~evalin('base', ['exist(''' app.TransitionmatrixEditField.Value ''', ''var'')'])
    looperWarning(['Variable ' app.TransitionmatrixEditField.Value ' not found in workspace.'])
elseif ~evalin('base', ['exist(''' app.EmissionsEditField.Value ''', ''var'')'])
    looperWarning(['Variable ' app.EmissionsEditField.Value ' not found in workspace.'])
else
    app.SavedData.AltTransitions = evalin('base', app.TransitionmatrixEditField.Value);
    app.SavedData.AltEmissions = evalin('base', app.EmissionsEditField.Value);

    app.ValidatePanel.Visible = 'on';
    app.LoadMarkovPanel.Visible = 'off';

    app.checkStepValidity();
end
end
