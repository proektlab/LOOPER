function cb_LoadModel(app, ~)
%set up selector UI
app.ValidatePanel.Visible = 'off';
app.LoadMarkovPanel.Visible = 'on';

app.STATESEditField.Value = size(app.SavedData.BestModel,1);
end
