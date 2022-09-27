function setupState(app)
components = properties(app);
for i = 1:length(components)
    thisComponent = app.(components{i});
    if isvalid(thisComponent) && strcmp(thisComponent.Type, 'uipanel')
        thisComponent.Visible = 'off';
    end
end

app.MainPanel.Visible = 'on';

switch app.CurrentState
    case 'LoadButton'
        app.showLoadPanel(false);
    case 'PreprocessingButton'
        app.PreprocessingPanel.Visible = 'on';
    case 'DiffusionMapButton'
        app.DiffusionmappingPanel.Visible = 'on';
    case 'ModelReductionButton'
        app.ModelreductionPanel.Visible = 'on';
    case 'FindLoopsButton'
        app.FindloopsPanel.Visible = 'on';
    case 'ValidateButton'
        app.ValidatePanel.Visible = 'on';
end
end