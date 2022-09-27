function saveLoadedData(app, filename)
if strcmp(filename, '')
    filename = app.DefaultFileLocation;
end

saveData = app.SavedData;
save(filename, 'saveData');
end