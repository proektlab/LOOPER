function [rawData, trialData, trialSwitches, inputs, outputs] = flattenData(dynamics, inputs, outputs)
% Take 2- or 3-D arrays or cell vectors of dynamics, inputs, and outputs, with trials along the
% 3rd dimension or the cell dimension, and convert to dimensions x time while outputting some
% information about trials.

% Get trial information from size of dynamics
rawData = looper.convertToCell(dynamics);
trialLengths = squeeze(cellfun('size', rawData, 2));
trialData = repelem(1:length(rawData), trialLengths);  
trialSwitches = find(diff(trialData) ~= 0);
rawData = cell2mat(rawData);

% process inputs and outputs if present
if exist('inputs', 'var') && ~isempty(inputs)
    inputs = cell2mat(looper.convertToCell(inputs));
else
    inputs = [];
end

if exist('outputs', 'var') && ~isempty(outputs)
    outputs = cell2mat(looper.convertToCell(ouptuts));
else
    outputs = [];
end

end

