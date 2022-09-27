function [localProjections, sigma, bestDiffSigmaValues, gaussianProximity, neighborCount, proximityRatio] = findBestAxes(looperData, calcIndex, meanDistanceMatrix, verbose)
    dynamicsStream = looperData.TimeSeries';
    trialStream = looperData.TrialTimeSeries;
    nearestNeighbors = looperData.NearestNeighbors;
    useLocalDimensions = looperData.UseLocalDimensions;
    minReturnTime = looperData.MinimumReturnTime;

    if ~exist('meanDistanceMatrix', 'var') || isempty(meanDistanceMatrix)
        origDistances = pdist2(dynamicsStream(calcIndex, :), dynamicsStream);
    else
        origDistances = meanDistanceMatrix(calcIndex, :);
    end

    if ~exist('verbose', 'var') || isempty(verbose)
        verbose = 0;
    end
    if ~exist('nearestNeighbors', 'var') || isempty(nearestNeighbors)
        nearestNeighbors = 12;
    end
    if ~exist('useLocalDimensions', 'var') || isempty(useLocalDimensions)
        useLocalDimensions = 1;
    end
    if ~exist('minReturnTime', 'var') || isempty(minReturnTime)
        minReturnTime = 10;
    end
    
    % defaults if we have to exit early
    gaussianProximity = nan(size(origDistances));        
    localProjections = nan(size(dynamicsStream, 2), 1);
    sigma = nan;
    bestDiffSigmaValues = nan;
    neighborCount = nan;
    proximityRatio = nan(size(origDistances));

tic
    
    trialEnds = cumsum(cellfun('size', trialStream(:)', 2));
    trialStarts = [1 trialEnds+1];
    
    % Just output nans at trial ends b/c we don't compute velocity at these points
    if ismember(calcIndex, trialEnds)
        return;
    end

    % N_original from paper - for estimating local noise
    origNeighborInds = getNearestNeighbors(origDistances, calcIndex, minReturnTime, nearestNeighbors);
    assert(origNeighborInds(1) == calcIndex, 'hmm, closest point is not the current point?');

    if useLocalDimensions
        stdInds = [origNeighborInds-1 origNeighborInds+1];
        stdInds(stdInds < 1) = [];
        stdInds(stdInds > size(dynamicsStream,1)) = [];
        stdInds(ismember(stdInds, trialStarts)) = [];
        stdInds(ismember(stdInds, trialEnds)) = [];
        stdInds = [origNeighborInds, stdInds];
        currentSTD = std(dynamicsStream(stdInds,:));
    else
        currentSTD = ones([1, size(dynamicsStream,2)]);
    end

    currentSTD = currentSTD / sqrt(sum(currentSTD.^2));
    currentSTD(currentSTD < 1e-4) = 1e-4;
    currentStream = dynamicsStream ./ currentSTD;

    % scaled distances of current state from all other states
    scaledDistances = pdist2(currentStream(calcIndex,:), currentStream);

    % Gaussian-smoothed derivative kernel
    smoothSigma = 1;
    x = -ceil(3*smoothSigma):ceil(3*smoothSigma);
    kernel = -x.*exp(-x.^2/(2*smoothSigma^2))/(smoothSigma^3*sqrt(2*pi));

    currentDiff = cell(length(trialStream), 1);
    for j = 1:length(trialStream)  % get smoothed velocity in each trial individually
        thisTrial = trialStream{j}' ./ currentSTD;
        currentDiff{j} = filterData(thisTrial, 0, kernel, 1, 0);
        currentDiff{j}(end,:) = nan;
    end
    currentDiff = cell2mat(currentDiff);

    % bail out if we don't have velocity distances for this point
    if isnan(currentDiff(calcIndex, 1))
        return;
    end

    % cosine distances of scaled current velocity from all other velocities
    thisDiffDistances = pdist2(currentDiff(calcIndex,:), currentDiff, 'cosine');

    % distance that takes both position and velocity into account
    totalDists = 1 - (1 - scaledDistances ./ max(scaledDistances,[],2)) .* (1 - thisDiffDistances ./ max(thisDiffDistances,[],2));

    % Find N_scaled to determine diffusion map radius and calc proximity based on that
    scaledNeighborInds = getNearestNeighbors(totalDists, calcIndex, minReturnTime, nearestNeighbors);
    sigma = totalDists(scaledNeighborInds(end)); 
    gaussianProximity = exp(-totalDists.^2/(2*sigma^2));

    % other return values
    localProjections = currentSTD(:);
    bestDiffSigmaValues = 0;
    neighborCount = length(scaledNeighborInds);
    outCluster = gaussianProximity < exp(-1); % if we want points out of the cluster to have dist > 2s, shouldn't this be "< exp(-2)"?
    proximityRatio = gaussianProximity / mean(gaussianProximity(outCluster));

    % summary plots
    if verbose
        figure(4)
        clf;
        plot(sort(gaussianProximity, 'descend'));
        title(['k = ' num2str(nearestNeighbors)]);

        plotIndices = find(gaussianProximity > exp(-1));
        
        if size(currentStream,2) > 3
            [~, plotBasis] = pca(currentStream', 'NumComponents', 3);
        else
            plotBasis = eye([size(currentStream,2) 3]);
        end

        figure(2);
        clf;
        hold on;
        h = plot3(currentStream*plotBasis(:,1),currentStream*plotBasis(:,2),currentStream*plotBasis(:,3));
        h.Color(4) = 0.2;
        scatter3(currentStream(plotIndices,:)*plotBasis(:,1),currentStream(plotIndices,:)*plotBasis(:,2),currentStream(plotIndices,:)*plotBasis(:,3), 32, gaussianProximity(plotIndices))
        xlabel('DPC1');
        ylabel('DPC2');
        zlabel('DPC3');
        colormap(jet(256));
    end
end

function sortedNeighborInds = getNearestNeighbors(distVec, calcIndex, minReturnTime, k)
% Find the k nearest neighbors based on the distances in distVec, with no two neighbors closer
% in time than minReturnTime samples.

sortedNeighborInds = zeros(1, k);

% first one is the calcIndex, always
sortedNeighborInds(1) = calcIndex;
distVec(calcIndex + (-minReturnTime:minReturnTime)) = nan;

for i = 2:k
    [~, nextInd] = findpeaks(-distVec, 'NPeaks', 1, 'SortStr', 'descend');
    
    if isempty(nextInd)
        sortedNeighborInds(i:end) = [];
        break;
    else
        sortedNeighborInds(i) = nextInd;
        % block out neighborhood so it is not used in the next iteration
        distVec(nextInd + (-minReturnTime:minReturnTime)) = nan;
    end
end
end
