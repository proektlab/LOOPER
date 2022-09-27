function [pcaBasis, trialIndices] = plotPCA(data, trialEnds, plotIndices, hFigure)
% Plot the given data, in a PCA basis if 3-or-more dimensional.
% data - dimensions x time, data to plot
% trialEnds - last sample # of each trial; plotIndices are relative to trials
% plotIndices - samples of each trial to plot
% hFigure - plot into this handle if nonempty

shouldPlot = ~isempty(hFigure);

if ~exist('trialEnds', 'var') || isempty(trialEnds)
    trialEnds = size(data, 2);
end

trialCount = length(trialEnds);
trialStarts = [1 trialEnds+1];
if isempty(plotIndices)
    maxTrialLength = max(diff(trialStarts));
    plotIndices = 1:maxTrialLength;
end

trialStarts(end) = [];
numDimensions = size(data, 1);

trialIndices = cell(trialCount, 1);
for i = 1:trialCount
    trialIndices{i} = trialStarts(i) - 1 + plotIndices(:);
    trialIndices{i}(trialIndices{i} > trialEnds(i)) = [];
end
trialIndices = cell2mat(trialIndices);

badIndices = setdiff(1:size(data,2), trialIndices);
badIndices = [badIndices, trialEnds];
data(:, badIndices) = nan;

if numDimensions == 1
    pcaBasis = eye(1,3);
    
    if shouldPlot
        plot(hFigure, data(1,:))
        
        xlabel('Time Series');
        ylabel('Time (timesteps)');
    end
elseif numDimensions == 2
    pcaBasis = eye(2,3);
    
    if shouldPlot
        plot(hFigure, data(1,:), data(2,:))
        
        xlabel('Dimension 1');
        ylabel('Dimension 2');
    end
else
    pcaTimeSeries = data;
    pcaTimeSeries(:,badIndices) = [];
    [pcaBasis, ~] = pca(pcaTimeSeries', 'NumComponents', 3);
    
    if shouldPlot
        h = plot3(hFigure, data'*pcaBasis(:,1), data'*pcaBasis(:,2), data'*pcaBasis(:,3));
        h.Color(4) = 0.2;
        
        xlabel('PC1');
        ylabel('PC2');
        zlabel('PC3');
    end
end

end

