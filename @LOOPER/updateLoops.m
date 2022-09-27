function updateLoops(app, UIData)

TOTAL_LOOPS = UIData.TOTAL_LOOPS;
maxClusters = UIData.maxClusters;
clusterIDs = UIData.clusterIDs;
loopClusterIDs = UIData.loopClusterIDs;
uniqueLoops = UIData.uniqueLoops;
loopCorrelationMatrix = UIData.loopCorrelationMatrix;
allLoops = UIData.allLoops;
stateSimilarities = UIData.stateSimilarities;
loopWeight = UIData.loopWeight;
loopLengths = UIData.loopLengths;
finalDynamicsStream = UIData.finalDynamicsStream;
pcaBasis = UIData.pcaBasis;
loopBandwidth = UIData.loopBandwidth;
clusterMeans = UIData.clusterMeans;
countClusters = UIData.countClusters;
TOTAL_LOOPS = UIData.TOTAL_LOOPS;
TOTAL_LOOPS = UIData.TOTAL_LOOPS;

shouldUseTerminalState = app.SavedData.UseTerminalState;

buildMinimalModelFromLoops

app.SavedData.BestStateCount = size(minimalModel,1);
app.SavedData.BestLoopCount = maxClusters;
app.SavedData.BestModel = minimalModel;
app.SavedData.BestEmission = statePositions;
app.SavedData.BestLoopAssignments = uniqueStates;
app.SavedData.BestStateMap = stateMap;

validationModel = minimalModel;
validationEmission = statePositions;

validateModel;

app.SavedData.LogLikelihoods = scoreMean;

saveData = app.SavedData;
plotLoops
plotReconstruction

if ~app.hasData("Outputs")
    app.SavedData.Ouputs = [];
end
app.SavedData.Ouputs.RSquared = Rsquared;

app.checkStepValidity();

test = 1;
end