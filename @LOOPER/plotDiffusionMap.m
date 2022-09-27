function plotDiffusionMap(app)
displayMatrix = app.SavedData.AsymmetricMap;
displayMatrix = displayMatrix ./ max(displayMatrix,[],2);

thisPlot = looperFigure(1);
hold off;
imagesc(displayMatrix);
xlabel('Observed state (timestep)');
ylabel('Observed state (timestep)');
looperTitle(thisPlot, 'Diffusion Map')
colormap(jet(256));
end