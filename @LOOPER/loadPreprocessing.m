function loadPreprocessing(app, shouldPlot)
if app.hasData("PreprocessData")
    app.ZScoreCheckbox.Value = app.SavedData.PreprocessData.ZScore;
    app.SmoothingEditField.Value = app.SavedData.PreprocessData.Smoothing;
    app.EmbeddelayEditField.Value = app.SavedData.PreprocessData.DelayTime;
    app.EmbedcountEditField.Value = app.SavedData.PreprocessData.DelayCount;
    app.InputlambdaEditField.Value = app.SavedData.PreprocessData.InputLambda;
    app.OutputlambdaEditField.Value = app.SavedData.PreprocessData.OutputLambda;
    app.TriallambdaEditField.Value = app.SavedData.PreprocessData.TrialLambda;

    app.MergeStartCheckbox.Value = app.SavedData.PreprocessData.MergeStarts;
    app.MergeEndCheckbox.Value = app.SavedData.PreprocessData.MergeEnds;
end

app.InputlambdaEditField.Enable = app.hasData('Inputs');
app.OutputlambdaEditField.Enable = app.hasData('Outputs');
app.TriallambdaEditField.Enable = app.hasData('TrialData') && max(app.SavedData.TrialData) > 1;
% 
% if app.hasData('TrialData') && max(app.SavedData.TrialData) > 1
%     app.MergeStartCheckbox.Enable = true;
%     app.MergeEndCheckbox.Enable = true;
% else
%     app.MergeStartCheckbox.Enable = false;
%     app.MergeEndCheckbox.Enable = false;
% 
%     app.MergeStartCheckbox.Value = false;
%     app.MergeEndCheckbox.Value = false;
% end

if shouldPlot && app.hasData('TimeSeries')
    app.plotProcessedData();
end
end