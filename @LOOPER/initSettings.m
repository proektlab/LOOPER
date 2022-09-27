function initSettings(app)
% Set the SavedData for all uninitialized parameters to the defaults.
% Does not affect any UI elements.
[defaultParams, defaultPreprocessParams] = looper.getDefaultParams();

paramNames = fieldnames(defaultParams);
for i = 1:length(paramNames)
    name = paramNames{i};
    if ~app.hasData(name)
        app.SavedData.(name) = defaultParams.(name);
    end
end

if ~app.hasData('PreprocessData')
    app.SavedData.PreprocessData = defaultPreprocessParams;
else
    preParamNames = fieldnames(defaultPreprocessParams);
    for i = 1:length(preParamNames)
        name = preParamNames{i};
        if ~isfield(app.SavedData.PreprocessData, name)
            app.SavedData.PreprocessData.(name) = defaultPreprocessParams.(name);
        end
    end
end
end