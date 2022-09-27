function cb_SaveFile(app, ~)

if app.hasData('Filename')
    [file, path] = uiputfile('*.mat', 'Save data', app.SavedData.Filename);
else
    [file, path] = uiputfile('*.mat', 'Save data', fullfile(LOOPER.AppBaseDir, [matlab.lang.makeValidName(app.ExperimentNameEditField.Value,'ReplacementStyle','delete') '.mat']));
end
app.MainWindow.Visible = 'off';
app.MainWindow.Visible = 'on';

if file ~= 0
    app.SavedData.ExperimentName = app.ExperimentNameEditField.Value;
    app.SavedData.Filename = [path '/' file];

    app.saveLoadedData(app.SavedData.Filename);
end
end