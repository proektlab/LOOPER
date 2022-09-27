function tabID = newTab(app, figureNumber)
app.FigureTabs{end+1} = uitab(app.FigureTabGroup);
tabID = length(app.FigureTabs);
app.FigureTabs{tabID}.Title = ['Figure ' num2str(figureNumber)];
app.FigureTabs{tabID}.Tag = num2str(figureNumber);


% Create Figures
app.Figures{end+1} = uiaxes(app.FigureTabs{tabID});
title(app.Figures{tabID}, '')
xlabel(app.Figures{tabID}, 'X')
ylabel(app.Figures{tabID}, 'Y')
app.Figures{tabID}.Position = [11 6 584 484];

app.FigureIDs{tabID} = num2str(figureNumber);
end