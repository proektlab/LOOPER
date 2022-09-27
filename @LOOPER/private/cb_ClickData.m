function cb_ClickData(app, event)
persistent checked
persistent tempValue

if isempty(checked)
    checked = 1;
    tempValue = app.SelectDataList.Value;% if you want to use this value later
    app.SelectDataList.Value = {};
    pause(0.25); %Add a delay to distinguish single click from a double click
    if checked == 1
        checked = [];
        app.SelectDataList.Value = tempValue;
    end
else


    if tempValue == app.SelectDataList.Value
        checked = [];
        app.SelectDataList.Value = tempValue;
        app.SelectVariable(event);
    end
end
end