function [filename, path] = getDefaultExperimentName(app)
allFiles = dir(fullfile(LOOPER.AppBaseDir, [app.DefaultFilename '*.mat']));
finalNumber = length(allFiles)+1;
for i = 1:length(allFiles)
    nextNumber = regexp(allFiles(i).name, [app.DefaultFilename '(\d).mat'], 'tokens');
    if ~isempty(nextNumber) && str2double(nextNumber{1}{1}) > i
        finalNumber = i;
        break;
    end
end

filename = [app.DefaultFilename num2str(finalNumber) '.mat'];
path = fullfile(LOOPER.AppBaseDir, filename);
end