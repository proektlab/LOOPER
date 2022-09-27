function validateData(LOOPERData, validateData, validateInputs, validateOutputs)
    if ~exist('validateInputs', 'var')
        validateInputs = [];
    end
    
    if ~exist('validateOutputs', 'var')
        validateOutputs = [];
    end
    
    [rawData, trialData, ~, inputs, outputs] = looper.flattenData(validateData, validateInputs, validateOutputs);

    % make an alternate LOOPERData struct for the new data
    altData = LOOPERData;
    altData.RawData = rawData;
    altData.TrialData = trialData;
    altData.Inputs = inputs;
    altData.Outputs = outputs;
    
    altData = preprocessData(altData, false);
    altDynamics = altData.TimeSeries;

    finalDynamicsStream = altDynamics';
    validationModel = LOOPERData.BestModel;
    validationEmission = LOOPERData.BestEmission;

    originalDataSize = size(LOOPERData.RawData);

    validateModel;
    
    numDataPoints = size(finalDynamicsStream, 1);
            
    disp(['Score: ' num2str(scoreMean) ' +/- ' num2str(1.96 * scoreSTD / sqrt(size(finalDynamicsStream,1)))]);
end
