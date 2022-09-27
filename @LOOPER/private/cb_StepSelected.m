function cb_StepSelected(app, ~)
selectedButton = app.SelectstepButtonGroup.SelectedObject;
app.CurrentState = selectedButton.Tag;

app.setupState();

switch app.CurrentState
    case 'LoadButton'
        app.plotLoadedData();
    case 'PreprocessingButton'
        app.loadPreprocessing(true);
    case 'DiffusionMapButton'
        if app.hasData("AsymmetricMap")
            app.plotDiffusionMap();
        else
            app.plotProcessedData();
        end
    case 'ModelReductionButton'
    case 'FindLoopsButton'
    case 'ValidateButton'
        saveData = app.SavedData;

        plotLoops
        plotReconstruction

        if ~app.hasData("Outputs")
            app.SavedData.Ouputs = [];
        end
        app.SavedData.Ouputs.RSquared = Rsquared;
end

app.setUpUI()
end