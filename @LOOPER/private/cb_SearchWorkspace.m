function cb_SearchWorkspace(app, event)
fillBoxName = event.Source.Tag;
fillBoxName = [fillBoxName(1:end-6) 'EditField'];
fillBox = app.(fillBoxName);

app.SelectVariableBox = fillBox;
app.SelectVariableCaller = event.Source.Parent;

%set up selector UI
app.SelectVariableCaller.Visible = 'off';
app.SelectDataPanel.Visible = 'on';

data = evalin('base', 'whos');

sortType = "horizontal";
if fillBox == app.TransitionmatrixEditField
    sortType = "square";
elseif fillBox == app.EmissionsEditField
    sortType = "states";
end

dataInfo = cell(length(data), 1);
dataScores = zeros(length(data), 1);
dataNames = {data.name};
for i = 1:length(data)
    if evalin('base', ['iscell(' data(i).name ')'])
        dataSize = evalin('base', ['size(' data(i).name '{1})']);
        isNumeric = isnumeric(evalin('base', [data(i).name '{1}']));
        class = evalin('base', ['class(' data(i).name '{1})']);

        dataInfo{i} = [data(i).name ' ' num2str(dataSize(1)) 'x' num2str(dataSize(2)) 'x' num2str(max(data(i).size)) ' ' class];
    elseif size(data(i),3) > 1
        dataSize = data(i).size;
        isNumeric = isnumeric(evalin('base', data(i).name));

        dataInfo{i} = [data(i).name ' ' num2str(dataSize(1)) 'x' num2str(dataSize(2)) 'x' num2str(dataSize(3)) ' ' data(i).class];
    else
        dataInfo{i} = [data(i).name ' ' num2str(data(i).size(1)) 'x' num2str(data(i).size(2)) ' ' data(i).class];

        dataSize = data(i).size;
        isNumeric = isnumeric(evalin('base', data(i).name));
    end


    if sortType == "square"
        if app.STATESEditField.Value > 0
            numStates = app.STATESEditField.Value;

            dataScores(i) = 1 / (1 + abs(dataSize(1) - numStates)) / (1 + abs(dataSize(2) - dataSize(1)));
        else
            dataScores(i) = dataSize(1) / (1 + abs(dataSize(2) - dataSize(1)));
        end
    elseif sortType == "states"
        if app.STATESEditField.Value > 0
            numStates = app.STATESEditField.Value;

            dataScores(i) = dataSize(2) / (1 + abs(numStates - dataSize(1)))^2;
        else
            dataScores(i) = dataSize(2)^2 / dataSize(1);
        end
    else
        dataScores(i) = dataSize(2)^2 / dataSize(1);
    end

    if ~isNumeric || dataSize(1) == 0 || dataSize(2) == 0
        dataScores(i) = 0;
    end
end

[sortedValues, sortOrder] = sort(dataScores, 'descend');

sortOrder(sortedValues == 0) = [];
sortOrder = sortOrder(1:min(length(sortOrder), 20));

dataInfo = dataInfo(sortOrder);
dataNames = dataNames(sortOrder);

app.SelectDataList.ItemsData = dataNames;
app.SelectDataList.Items = dataInfo;
end