function cb_ClearModel(app, ~)
app.removeData('AltTransitions');
app.removeData('AltEmissions');

app.checkStepValidity();
end