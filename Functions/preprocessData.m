function [tempData, trialData, processedTrialSwitches, dataMean, dataSTD] = preprocessData(rawData, rawInput, inputLambda, rawOutput, outputLambda, rawTrialData, trialLambda, isTrainingData, smoothingAmount, shouldZScore, delayTime, delayCount, dataMean, dataSTD)
tempData = rawData';
dataIndices = 1:size(rawData, 1);
inputIndices = [];
if exist('rawInput', 'var') && ~isempty(rawInput) && inputLambda > 0
    tempData = [tempData, rawInput'];
    inputIndices = size(rawData, 1) + (1:size(rawInput,1));
end
outputIndices = [];
if exist('rawOutput', 'var') && ~isempty(rawOutput) && outputLambda > 0
    tempData = [tempData, rawOutput'];
    outputIndices = size(rawData, 1) + size(rawInput,1) + (1:size(rawOutput,1));
end
trialIndices = [];

tempData = tempData';

trialNumbers = rawTrialData;
allTrials = arrayfun(@(i) tempData(:, trialNumbers == i), 1:max(trialNumbers), 'uni', false);
processedTrialSwitches = cumsum(cellfun('size', allTrials, 2));

if smoothingAmount > 0
    filterFn = @(trial) filterData(trial, smoothingAmount, 'gaussian', true, 0);
    allTrials = cellfun(filterFn, allTrials, 'uni', false);
    tempData = horzcat(allTrials{:});
end

if isTrainingData
    dataMean = mean(tempData, 2);
    dataSTD = std(tempData, [], 2);
end

if shouldZScore
    for i = 1:length(allTrials)
        allTrials{i} = (allTrials{i} - dataMean) ./ dataSTD;
    end
    tempData = (tempData - dataMean) ./ dataSTD;
end

dataAmplitude = max(tempData, [], 2) - min(tempData, [], 2);
dataAmplitudeQuantile = quantile(tempData, 0.95, 2) - quantile(tempData, 0.05, 2);
dataAmplitudeQuantile(dataAmplitudeQuantile == 0) = dataAmplitude(dataAmplitudeQuantile == 0);
dataAmplitudeQuantile(dataAmplitudeQuantile == 0) = 1;


dataMagnitude = norm(dataAmplitudeQuantile(dataIndices));

if (~isempty(inputIndices))
    inputMagnitude = norm(dataAmplitudeQuantile(inputIndices));
    tempData(inputIndices,:) = tempData(inputIndices,:) ./ inputMagnitude .* dataMagnitude .* inputLambda;
end

if (~isempty(outputIndices))
    outputMagnitude = norm(dataAmplitudeQuantile(outputIndices));
    tempData(outputIndices,:) = tempData(outputIndices,:) ./ outputMagnitude .* dataMagnitude .* outputLambda;
end

if (~isempty(trialIndices))
    trialMagnitude = norm(dataAmplitudeQuantile(trialIndices));
    tempData(trialIndices,:) = tempData(trialIndices,:) ./ trialMagnitude .* dataMagnitude .* trialLambda;
end

if delayTime > 0 && delayCount > 0
    delayEmbedFn = @(trial) delayEmbed(trial, delayCount, delayTime, 0, true);
    allTrials = cellfun(delayEmbedFn, allTrials, 'uni', false);
    tempData = horzcat(allTrials{:});
    processedTrialSwitches = cumsum(cellfun('size', allTrials, 2));
end
trialData = allTrials;
end
