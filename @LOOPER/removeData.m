function removeData(app, dataName)
if isfield(app.SavedData, dataName)
    app.SavedData = rmfield(app.SavedData, dataName);
end
end