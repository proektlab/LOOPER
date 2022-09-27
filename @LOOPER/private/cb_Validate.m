function cb_Validate(app, ~)
finalDynamicsStream = app.SavedData.TimeSeries';
validationModel = app.SavedData.BestModel;
validationEmission = app.SavedData.BestEmission;

originalDataSize = size(app.SavedData.RawData);

isAltModel = false;
isAltDynamics = false;

if isfield(app.SavedData,'AltTransitions')
    validationModel = app.SavedData.AltTransitions;
    validationEmission = app.SavedData.AltEmissions;

    isAltModel = true;
end

if isfield(app.SavedData, 'AltDynamics')
    finalDynamicsStream = app.SavedData.AltDynamics';

    isAltDynamics = true;
end

validateModel;

numDataPoints = size(finalDynamicsStream, 1);

disp(['Score: ' num2str(scoreMean) ' +/- ' num2str(1.96 * scoreSTD / sqrt(size(finalDynamicsStream,1)))]);

if ~isAltModel && ~isAltDynamics
    if ~app.hasData("Outputs")
        app.SavedData.Ouputs = [];
    end
    app.SavedData.Ouputs.ValidationScore = scoreMean;
end
end