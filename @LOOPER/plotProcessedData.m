function plotProcessedData(app)
if app.hasData('TimeSeries')
    [~, thisPlot, ~] = app.plotPCA();
    looperTitle(thisPlot, 'Time Series')
end
end