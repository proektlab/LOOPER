function [delayEmbeddedData, embeddedTime] = delayEmbed(data, numDelays, deltaT, useDerivatives, dontFlip)
    if ~exist('useDerivatives') || isempty(useDerivatives)
        useDerivatives = 1;
    end
    
    if ~exist('dontFlip') || isempty(dontFlip)
        dontFlip = 0;
    end
    
    if numDelays == 0 || deltaT == 0
        delayEmbeddedData = data;
        embeddedTime = 0;
        return;
    end
    
    flipped = 0;
    if ~dontFlip
        if size(data,2) < size(data,1)
            data = data';
            flipped = 1;
        end
    end

    nChans = size(data, 1);
    if useDerivatives
        filteredTrace = [zeros(nChans, 1), diff(data,1,2)];
        data = [data; filteredTrace];
        nChans = 2*nChans;
    end

    %%
    embeddedTime = numDelays*deltaT + useDerivatives;
    timeIndOffsets = repelem(useDerivatives + deltaT*(numDelays:-1:0)', nChans);
    timeInds = timeIndOffsets + (1:size(data, 2)-embeddedTime);
    chanInds = repmat((1:nChans)', numDelays + 1, size(timeInds, 2));
    linearInds = sub2ind(size(data), chanInds, timeInds);
    delayEmbeddedData = data(linearInds);
    
    if flipped
        delayEmbeddedData = delayEmbeddedData';
    end
