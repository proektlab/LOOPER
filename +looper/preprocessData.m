function looperData = preprocessData(looperData, isTrainingData)
params = looperData.PreprocessData;
tempData = looperData.RawData'; % time x channels
dataIndices = 1:size(tempData, 2);
totalIndices = dataIndices(end);

inputIndices = [];
if isfield(looperData, 'Inputs') && ~isempty(looperData.Inputs) && params.InputLambda > 0
    inputData = looperData.Inputs';
    tempData = [tempData, inputData];
    inputIndices = totalIndices + (1:size(inputData, 2));
    totalIndices = inputIndices(end);
end

outputIndices = [];
if isfield(looperData, 'Outputs') && ~isempty(looperData.Outputs) && params.OutputLambda > 0
    outputData = looperData.Outputs';
    tempData = [tempData, outputData];
    outputIndices = totalIndices + (1:size(outputData, 2));
    totalIndices = outputIndices(end);
end
trialIndices = [];

tempData = tempData'; % back to channels x time

trialNumbers = looperData.TrialData;

% index of the end of each trial
processedTrialSwitches = find([diff(trialNumbers) ~= 0, true]);
eachTrialLength = diff([0, processedTrialSwitches]);
allTrials = mat2cell(tempData, totalIndices, eachTrialLength);

if params.Smoothing > 0
    for i = 1:length(allTrials)
        allTrials{i} = filterData(allTrials{i}, params.Smoothing, 'gaussian', true, 0);
    end
    tempData = cell2num(allTrials);
end

if isTrainingData
    looperData.DataMean = mean(tempData, 2);
    looperData.DataSTD = std(tempData, [], 2);
end

if params.ZScore
    for i = 1:length(allTrials)
        allTrials{i} = (allTrials{i} - looperData.DataMean) ./ looperData.DataSTD;
    end
    tempData = (tempData - looperData.DataMean) ./ looperData.DataSTD;
end

dataAmplitude = max(tempData, [], 2) - min(tempData, [], 2);
dataAmplitudeQuantile = quantile(tempData, 0.95, 2) - quantile(tempData, 0.05, 2);
dataAmplitudeQuantile(dataAmplitudeQuantile == 0) = dataAmplitude(dataAmplitudeQuantile == 0);
dataAmplitudeQuantile(dataAmplitudeQuantile == 0) = 1;


dataMagnitude = norm(dataAmplitudeQuantile(dataIndices));

if (~isempty(inputIndices))
    inputMagnitude = norm(dataAmplitudeQuantile(inputIndices));
    tempData(inputIndices,:) = tempData(inputIndices,:) ./ inputMagnitude .* dataMagnitude .* params.InputLambda;
end

if (~isempty(outputIndices))
    outputMagnitude = norm(dataAmplitudeQuantile(outputIndices));
    tempData(outputIndices,:) = tempData(outputIndices,:) ./ outputMagnitude .* dataMagnitude .* params.OutputLambda;
end

if (~isempty(trialIndices))
    trialMagnitude = norm(dataAmplitudeQuantile(trialIndices));
    tempData(trialIndices,:) = tempData(trialIndices,:) ./ trialMagnitude .* dataMagnitude .* params.TrialLambda;
end

if params.DelayTime > 0 && params.DelayCount > 0
    for i = 1:length(allTrials)
        allTrials{i} = delayEmbed(allTrials{i}, params.DelayCount, params.DelayTime, 0, true);
    end
    processedTrialSwitches = cumsum(cellfun('size', allTrials, 2));
    tempData = cell2num(allTrials);
end

looperData.TrialTimeSeries = allTrials;
looperData.TrialSwitches = processedTrialSwitches;
looperData.TimeSeries = tempData;
end