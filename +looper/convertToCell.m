function data = convertToCell(data)
    if ~iscell(data)
        data = num2cell(data, [1, 2]);
    end
    
    data = reshape(data, 1, []);
end
