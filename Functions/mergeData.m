function [mergedData] = mergeData(data)
    mergedData = horzcat(data{:});
end
