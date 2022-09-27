function cb_SaveToWorkSpace(app, ~)
app.saveLoadedData('tempLOOPERData.mat');

evalin('base', "load('tempLOOPERData.mat');")
end