function cb_SelectLoops(app, ~)
asymmetricProbabilities = app.SavedData.AsymmetricMap;
finalDynamicsStream = app.SavedData.FinalStream;
reducedMatrix = app.SavedData.ReducedMatrix;
clusterIDs = app.SavedData.ClusterIDs;
stateHasNext = app.SavedData.StateHasNext;
stateValidities= app.SavedData.ValidStates;
clusterMeansPCA = app.SavedData.ClusterMeansPCA;
clusterMeans = app.SavedData.ClusterMeans;
countClusters = app.SavedData.CountClusters;

putativeLoopCounts = app.StartingloopsEditField.Value;

app.SavedData.TotalStates = app.TargetstatecountEditField.Value;
totalClusters = app.SavedData.TotalStates;

app.SavedData.UseTerminalState = app.TerminalStateCheckbox.Value;
shouldUseTerminalState = app.SavedData.UseTerminalState;

selectingLoops = 1;

trialSwitchTimes = app.SavedData.TrialSwitches;

[pcaBasis, pcaOutputs] = pca(app.SavedData.FinalStream, 'NumComponents', 3);


buildMinimalModelFromMatrix;

% app.SavedData.BestStateCount = bestStateCount;
% app.SavedData.LogLikelihoods = allLikelihoods;
% app.SavedData.BestLoopCount = bestLoopCount;
% app.SavedData.BestModel = bestModel;
% app.SavedData.BestEmission = bestEmission;
% 
% app.checkStepValidity();
end