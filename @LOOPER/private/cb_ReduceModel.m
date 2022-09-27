function cb_ReduceModel(app, ~)

asymmetricProbabilities = app.SavedData.AsymmetricMap;
finalDynamicsStream = app.SavedData.FinalStream;

app.SavedData.PutativeClusterCounts = double(strsplit(string(app.PutativeclustercountsEditField.Value), ','));
clusterCounts = app.SavedData.PutativeClusterCounts;

app.SavedData.DistanceType = app.DistancetypeEditField.Value;
distanceType = app.SavedData.DistanceType;

app.SavedData.MaxCheckTime = app.MaxchecktimeEditField.Value;
maxCheckTime = app.SavedData.MaxCheckTime;

stateHasNext = app.SavedData.StateHasNext;

if size(app.SavedData.FinalStream,2) > 2
    [pcaBasis, pcaOutputs] = pca(app.SavedData.FinalStream, 'NumComponents', 3);
else
    pcaBasis = eye(size(app.SavedData.FinalStream,2));
end

DEBUG = 0;

% shouldUseTerminalState = app.SavedData.UseTerminalState;

reduceMatrix;

if hadError == 0
    app.SavedData.ReducedMatrix = finalReducedMatrix;
    app.SavedData.ClusterIDs = clusterIDs;
    app.SavedData.ClusterMeansPCA = clusterMeansPCA;
    app.SavedData.ClusterMeans = clusterMeans;
    app.SavedData.CountClusters = countClusters;


    app.checkStepValidity();
end
end