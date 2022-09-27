function dataExists = hasData(app, dataName)
dataExists = isfield(app.SavedData, dataName);
end