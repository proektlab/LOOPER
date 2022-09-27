function cb_SelectVariable(app, ~)
app.SelectVariableBox.Value = app.SelectDataList.Value;

app.SelectVariableCaller.Visible = 'on';
app.SelectDataPanel.Visible = 'off';
end