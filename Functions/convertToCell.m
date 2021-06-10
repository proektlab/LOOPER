function data = convertToCell(data)
    if size(data,3) > 1
        data = num2cell(data, [1, 2]);
    elseif ~iscell(data)
        data = {data};
    end
end
