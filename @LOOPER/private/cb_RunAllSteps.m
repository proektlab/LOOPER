function cb_RunAllSteps(app, ~)
app.ApplyPreprocessing();
app.BuildDiffusionMap();
app.ReduceModel();
app.FindLoops();
end