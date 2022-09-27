function plotLoadedData(app)
if app.hasData('RawData')
    thisPlot = looperFigure(1);
    size(app.SavedData.RawData)
    imagesc(thisPlot, app.SavedData.RawData)
    looperTitle(thisPlot, 'Data')
    ylabel(thisPlot, 'Data Channel #')
    xlabel(thisPlot, 'Time (steps)')
    xlim(thisPlot, [0 length(app.SavedData.RawData)])

    if app.hasData('RawTrialSwitches')
        RawTrialSwitches = app.SavedData.RawTrialSwitches;
    else
        RawTrialSwitches = [];

        app.SavedData.TrialData = [];
        app.SavedData.RawTrialSwitches = [];
    end

    % Plot red lines between trials
    if max(app.SavedData.TrialData > 1)
        yLimit = ylim(thisPlot);
        hold on;
        for i = 1:length(RawTrialSwitches)
            plot(ones(1,2)*RawTrialSwitches(i), yLimit, 'r', 'LineWidth', 1);
        end
    end

    if app.hasData('Inputs')
        thisPlot = looperFigure(2);
        imagesc(thisPlot, app.SavedData.Inputs)
        looperTitle(thisPlot, 'Input')
        ylabel(thisPlot, 'Input Channel #')
        xlabel(thisPlot, 'Time (steps)')
        xlim(thisPlot, [0 length(app.SavedData.Inputs)])

        if max(app.SavedData.TrialData > 1)
            yLimit = ylim(thisPlot);
            hold on;
            for i = 1:length(RawTrialSwitches)
                plot(ones(1,2)*RawTrialSwitches(i), yLimit, 'r', 'LineWidth', 1);
            end
        end
    end

    if app.hasData('Outputs')
        thisPlot = looperFigure(3);
        imagesc(thisPlot, app.SavedData.Outputs)
        looperTitle(thisPlot, 'Outputs')
        ylabel(thisPlot, 'Output Channel #')
        xlabel(thisPlot, 'Time (steps)')
        xlim(thisPlot, [0 length(app.SavedData.Outputs)])

        if max(app.SavedData.TrialData > 1)
            yLimit = ylim(thisPlot);
            hold on;
            for i = 1:length(RawTrialSwitches)
                plot(ones(1,2)*RawTrialSwitches(i), yLimit, 'r', 'LineWidth', 1);
            end
        end
    end

%     if app.hasData('TrialData')
%         thisPlot = looperFigure(3);
%         imagesc(thisPlot, app.SavedData.TrialData)
%         looperTitle(thisPlot, 'Timecourse')
%         ylabel(thisPlot, 'Time (au)')
%         xlabel(thisPlot, 'Frame #')
%         xlim(thisPlot, [0 length(app.SavedData.TrialData)])
%     end
end
end