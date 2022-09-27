function [pcaBasis, thisPlot, trialIndices] = plotPCA(app, shouldPlot, data, trialEnds)
if ~exist('shouldPlot', 'var') || isempty(shouldPlot)
    shouldPlot = 1;
end

thisPlot = [];
if shouldPlot
    thisPlot = looperFigure(1);
    hold off;
end

if ~exist('data', 'var') || isempty(data)
    data = [];
end

if ~exist('trialEnds', 'var') || isempty(trialEnds)
    trialEnds = [];
end

if ~isempty(data)
    timeSeries = data;
elseif isfield(app.SavedData,'TimeSeries')
    timeSeries = app.SavedData.TimeSeries;
    trialEnds = app.SavedData.TrialSwitches;
elseif isfield(app.SavedData,'RawData')
    timeSeries = app.SavedData.RawData;
    trialEnds = [];
    if isfield(app.SavedData,'RawTrialSwitches')
        trialEnds = app.SavedData.RawTrialSwitches;
    end
end

if ~isempty(app.PlottimesEditField.Value)
    plotIndices = eval(app.PlottimesEditField.Value);
else
    plotIndices = [];
end

[pcaBasis, trialIndices] = looper.plotPCA(timeSeries, trialEnds, plotIndices, thisPlot);
end