function cb_PreviewNeighborhood(app, ~)

cursorMode = datacursormode(gcf);
datatips = cursorMode.getCursorInfo();

previewIndex = 0;
if (~isempty(datatips) && isfield(datatips(1), 'DataIndex'))
    previewIndex = datatips(1).DataIndex;
elseif app.PreviewindexEditField.Value > 0
    previewIndex = app.PreviewindexEditField.Value;
else
    app.plotProcessedData();

    looperWarning("Please select a point on the plot using the Data Cursor, or input a preview index.");
end

app.SavedData.NearestNeighbors = app.NearestneighborsEditField.Value;
app.SavedData.UseLocalDimensions = app.LocalDimensionsCheckbox.Value;
app.SavedData.RepopulateDensity = app.RepopulationdensityEditField.Value;
app.SavedData.MinimumReturnTime = app.MinReturnTimeEditField.Value;

[localProjections, ~, ~, gaussianProximity, neighborCount] = looper.findBestAxes(app.SavedData, previewIndex, [], 1);

app.PreviewindexEditField.Value = previewIndex;

if ~isnan(neighborCount)
    plotIndices = find(gaussianProximity > exp(-1));
%     localStream = app.SavedData.TimeSeries';
    localStream = (app.SavedData.TimeSeries .* localProjections)';
%     localStream(app.SavedData.TrialSwitches,:) = nan;

    [pcaBasis, thisPlot] = app.plotPCA(1, localStream', app.SavedData.TrialSwitches);
% 
%     [plotBasis, ~] = pca(localStream, 'NumComponents', min(4, size(localStream,2)));
% 
%     thisPlot = looperFigure(1);
%     hold off;
%     colors = lines(8);
%     h = plot3(localStream*plotBasis(:,1),localStream*plotBasis(:,2),localStream*plotBasis(:,3));
%     h.Color(4) = 0.2;
    hold on;
    scatter3(localStream(plotIndices,:)*pcaBasis(:,1),localStream(plotIndices,:)*pcaBasis(:,2),localStream(plotIndices,:)*pcaBasis(:,3), 32, localDistances(plotIndices))
    xlabel('DPC1');
    ylabel('DPC2');
    zlabel('DPC3');
    looperTitle(thisPlot, 'Local Neighborhood')
    colormap(jet(256));
end
% position = localStream(datatips(1).DataIndex,:)*plotBasis;
% makedatatip(h, position)
% end
% 
% function loadDiffusionMap(app)
% if (app.hasData("PreprocessData"))
%     app.ZScoreCheckbox.Value = app.SavedData.PreprocessData.ZScore;
%     app.SmoothingEditField.Value = app.SavedData.PreprocessData.Smoothing;
%     app.EmbeddelayEditField.Value = app.SavedData.PreprocessData.DelayTime;
%     app.EmbedcountEditField.Value = app.SavedData.PreprocessData.DelayCount;
% end
% 
% if app.hasData('TimeSeries')
%     app.plotProcessedData();
% end
end