function removeFigure(app, figure)
for i = 1:length(app.Figures)
    if app.Figures{i} == figure
        app.FigureTabs(i) = [];
        app.Figures(i) = [];
        app.FigureIDs(i) = [];
        break;
    end
end
end