function cb_FindLoops(app, ~)
asymmetricProbabilities = app.SavedData.AsymmetricMap;
finalDynamicsStream = app.SavedData.FinalStream;
reducedMatrix = app.SavedData.ReducedMatrix;
clusterIDs = app.SavedData.ClusterIDs;
stateHasNext = app.SavedData.StateHasNext;
stateValidities= app.SavedData.ValidStates;
clusterMeansPCA = app.SavedData.ClusterMeansPCA;
clusterMeans = app.SavedData.ClusterMeans;
countClusters = app.SavedData.CountClusters;

app.SavedData.PutativeLoopCounts = cell2mat(cellfun(@str2num,strsplit(app.PutativeloopcountsEditField.Value, ','),'uniform',0));
putativeLoopCounts = app.SavedData.PutativeLoopCounts;

app.SavedData.UseTerminalState = app.TerminalStateCheckbox.Value;
shouldUseTerminalState = app.SavedData.UseTerminalState;

app.SavedData.TotalStates = app.TargetstatecountEditField.Value;
totalClusters = app.SavedData.TotalStates;

selectingLoops = 0;

if size(app.SavedData.FinalStream,2) > 2
    [pcaBasis, pcaOutputs] = pca(app.SavedData.FinalStream, 'NumComponents', 3);
else
    pcaBasis = eye(size(app.SavedData.FinalStream,2));
end


trialSwitchTimes = app.SavedData.TrialSwitches;

buildMinimalModelFromMatrix;

app.SavedData.BestStateCount = bestStateCount;
app.SavedData.LogLikelihoods = allLikelihoods;
app.SavedData.BestLoopCount = bestLoopCount;
app.SavedData.BestModel = bestModel;
app.SavedData.BestEmission = bestEmission;
app.SavedData.BestLoopAssignments = bestLoopAssignments;
app.SavedData.BestStateMap = bestStateMap;

saveData = app.SavedData;
plotLoops
plotReconstruction

if ~app.hasData("Outputs")
    app.SavedData.Ouputs = [];
end
app.SavedData.Ouputs.RSquared = Rsquared;

app.checkStepValidity();
end