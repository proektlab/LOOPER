function cb_BuildDiffusionMap(app, ~)

app.SavedData.NearestNeighbors = app.NearestneighborsEditField.Value;
app.SavedData.UseLocalDimensions = app.LocalDimensionsCheckbox.Value;
app.SavedData.RepopulateDensity = app.RepopulationdensityEditField.Value;
app.SavedData.MinimumReturnTime = app.MinReturnTimeEditField.Value;

looper.buildDiffusionMap(app.SavedData);

app.SavedData.AsymmetricMap = asymmetricProbabilities;
app.SavedData.FinalIndicies = finalIndicies;
app.SavedData.FinalStream = finalDynamicsStream;
app.SavedData.ValidStates = stateValidities;
app.SavedData.DiffusionMapIndicies = diffusionMapIndicies;
app.SavedData.StateHasNext = stateHasNext;

app.checkStepValidity();
end