function cb_LoadData(app, ~)
if app.LoadingAlternative
    [success, rawData, inputs, outputs, trialData] = app.processMultipleTrials('Alt');
    if success
        tempAltData = app.SavedData;
        tempAltData.RawData = rawData;
        tempAltData.Inputs = inputs;
        tempAltData.Outputs = outputs;
        tempAltData.TrialData = trialData;
        tempAltData = preprocessData(tempAltData, false);
        app.SavedData.AltDynamics = tempAltData.TimeSeries;
    end

    app.ValidatePanel.Visible = 'on';
    app.LoadDataPanel.Visible = 'off';

else
    success = app.processMultipleTrials('');
    if success
        app.plotLoadedData();
        %                     app.saveLoadedData('');
    end
end

app.checkStepValidity();
end