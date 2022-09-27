function showLoadPanel(app, loadingAlternative)
app.LoadingAlternative = loadingAlternative;
app.LoadmatfileButton.Visible = ~loadingAlternative;
app.Cancel.Visible = loadingAlternative;
app.LoadDataPanel.Visible = 'on';
end