function cb_LoadFile(app, ~)
[file, path] = uigetfile('*.mat', 'Select saved data', app.DefaultFileLocation);
app.MainWindow.Visible = 'off';
app.MainWindow.Visible = 'on';

if file ~= 0
    loadFile = [path '/' file];

    thisData = load(loadFile);
    app.SavedData = thisData.saveData;

    % Fill defaults for settings that are not provided
    app.initSettings();

    if app.hasData('ExperimentName')
        app.ExperimentNameEditField.Value = app.SavedData.ExperimentName;
    end

    if ~contains(loadFile, 'backup.mat')
        app.SavedData.Filename = loadFile;
    end

    app.plotLoadedData();
    app.checkStepValidity();

    app.setUpUI();
end
end
