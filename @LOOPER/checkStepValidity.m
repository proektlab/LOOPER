function checkStepValidity(app)
% Enable/disable controls based on how far data have been loaded/processed
if isfield(app.SavedData,'RawData')
    app.PlottimesEditField.Enable = true;
    app.setupPlotTimes()
else
    app.PlottimesEditField.Enable = false;
end

app.LoadButton.Enable = true;
app.ApplyprocessingButton.Enable = isfield(app.SavedData,'RawData');
app.BuilddiffusionmapButton.Enable = isfield(app.SavedData,'TimeSeries');
app.ReducemodelButton.Enable = isfield(app.SavedData,'AsymmetricMap');
app.ProcessloopsButton.Enable = isfield(app.SavedData,'ReducedMatrix');

app.RunallButton.Enable = isfield(app.SavedData,'RawData');
app.RunclusteringButton.Enable = isfield(app.SavedData,'AsymmetricMap');

app.ClearcomparisonmodelButton.Enable = isfield(app.SavedData,'AltTransitions');
app.ClearvalidationdataButton.Enable = isfield(app.SavedData,'AltDynamics');

app.ValidateButton.Enable = isfield(app.SavedData,'LogLikelihoods');
if isfield(app.SavedData,'LogLikelihoods')
    app.BestloopcountEditField.Value = num2str(app.SavedData.BestLoopCount);
    app.BeststatecountEditField.Value = num2str(app.SavedData.BestStateCount);
end
end