function setUpUI(app)
app.loadPreprocessing(false);

if isfield(app.SavedData,'NearestNeighbors')
    app.NearestneighborsEditField.Value = app.SavedData.NearestNeighbors;
    app.LocalDimensionsCheckbox.Value = app.SavedData.UseLocalDimensions;
    app.RepopulationdensityEditField.Value = app.SavedData.RepopulateDensity;
    app.MinReturnTimeEditField.Value = app.SavedData.MinimumReturnTime;
end

if isfield(app.SavedData,'PutativeClusterCounts')
    clusterList = join(string(app.SavedData.PutativeClusterCounts), ", ");
    app.PutativeclustercountsEditField.Value = clusterList;
    app.DistancetypeEditField.Value = app.SavedData.DistanceType;
    app.MaxchecktimeEditField.Value = app.SavedData.MaxCheckTime;
end

if isfield(app.SavedData,'PutativeLoopCounts')
    loopList = join(string(app.SavedData.PutativeLoopCounts), ", ");
    app.PutativeloopcountsEditField.Value = loopList;

    if isfield(app.SavedData,'UseTerminalState')
        app.TerminalStateCheckbox.Value = app.SavedData.UseTerminalState;
    end

    if isfield(app.SavedData,'TotalStates')
        app.TargetstatecountEditField.Value = app.SavedData.TotalStates;
    end
end

if isfield(app.SavedData,'LogLikelihoods')
    app.BestloopcountEditField.Value = num2str(app.SavedData.BestLoopCount);
    app.BeststatecountEditField.Value = num2str(app.SavedData.BestStateCount);
end
app.ClearcomparisonmodelButton.Enable = isfield(app.SavedData,'AltTransitions');
app.ClearvalidationdataButton.Enable = isfield(app.SavedData,'AltDynamics');
end