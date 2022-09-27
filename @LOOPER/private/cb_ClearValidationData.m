function cb_ClearValidationData(app, ~)
app.removeData('AltDynamics');

app.checkStepValidity();
end