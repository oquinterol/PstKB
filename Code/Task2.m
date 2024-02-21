%{
Task2, make a robustness analysis from all exchange reactions
%}
initCobraToolbox(false)
cd('~/Git/PstKB/')
% Read the metabolic reconstruction models
ModelOri = readCbModel('~/Git/PstKB/Models/PstKB.ori.xml');
ModelNew = readCbModel('~/Git/PstKB/Models/PstKB_cobra.xml');
% Identify exchange reactions in the ModelNew model
ExcRxns = ModelNew.rxns(findExcRxns(ModelNew));
%% Perform the analysis and plot the results for each reaction
for i = 1:length(ExcRxns)
    % Perform robustness analysis for each model and plot the results
    [RxnNew, ObjNew] = robustnessAnalysis(ModelNew, ExcRxns{i}, 50, false);
    [RxnOri, ObjOri] = robustnessAnalysis(ModelOri, ExcRxns{i}, 50, false);
    % Create a new figure
    figure('Position', [0, 0, 1000, 400]); % 1000x400 px
    % Divide the canvas into 1 row and 2 columns, and select the first subplot
    subplot(1, 2, 1);
    plot(RxnOri, ObjOri); % Plot the first dataset
    title('Model Ori'); % Add title to the first subplot
    % Select the second subplot
    subplot(1, 2, 2);
    plot(RxnNew, ObjNew); % Plot the second dataset
    title('Model New'); % Add title to the second subplot
    % General Title
    sgtitle(['Reaction: ', strrep(ExcRxns{i}, '_', '-')]);
    % Save the figure as an image in the "fig" folder with the name of the reaction
    filename = fullfile('fig', [ExcRxns{i}, '.png']);
    saveas(gcf, filename);
    % Close the current figure
    close;
end