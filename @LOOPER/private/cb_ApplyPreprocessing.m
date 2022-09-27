function cb_ApplyPreprocessing(app, ~)

% Make a struct with the current parameters to pass to preprocessData
app.removeData('TimeSeries');
tempData = app.SavedData;
tempData.PreprocessData.ZScore = app.ZScoreCheckbox.Value;
tempData.PreprocessData.Smoothing = app.SmoothingEditField.Value;
tempData.PreprocessData.DelayTime = app.EmbeddelayEditField.Value;
tempData.PreprocessData.DelayCount = app.EmbedcountEditField.Value;
tempData.PreprocessData.MergeStarts = app.MergeStartCheckbox.Value;
tempData.PreprocessData.MergeEnds = app.MergeEndCheckbox.Value;
tempData.PreprocessData.InputLambda = app.InputlambdaEditField.Value;
tempData.PreprocessData.OutputLambda = app.OutputlambdaEditField.Value;
tempData.PreprocessData.TrialLambda = app.TriallambdaEditField.Value;

% if isfield(tempData, 'TrialData')
%     tempData.TrialData = zeros(1, size(tempData.RawData,2));
% 
%     if tempData.MergeStarts || 1
%         tempData.TrialData(1) = 1;
%         tempData.TrialData(tempData.RawTrialSwitches + 1) = 1;
%     end
% 
% %     if tempData.shouldMergeEnds
% %         tempData.TrialData(end) = -1;
% %         tempData.TrialData(tempData.RawTrialSwitches) = -1;
% %     end
% end

app.SavedData = looper.preprocessData(tempData, true);

app.loadPreprocessing(true);
app.checkStepValidity();
% app.saveLoadedData('');

end
