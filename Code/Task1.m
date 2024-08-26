%{
Task 1
1. Optimize the current model and create a table per reaction
2. Update the stoichiometry of the reactions and optimize again
3. Create a comparison table between the solutions of each model + a
relative delta or a way to measure their difference
%}
%% Initialize Cobratoolbox
initCobraToolbox(false)
cd('/home/Oscar/Git/PstKB/')
%% Load the model, 'ori' represents the current model
ModelOri = readCbModel('/home/Oscar/Git/PstKB/Models/PstKB.ori.xml');
% Optimize model
OptModelOri = optimizeCbModel(ModelOri);
%% Load 'cobra' represents the model with the updated stoichiometry
ModelNew = readCbModel('/home/Oscar/Git/PstKB/Models/PstKB_cobra.xml');
% Optimize Model
OptModelNew = optimizeCbModel(ModelNew);
%% Create table
tabla = table(ModelOri.rxns,ModelOri.rxnNames,OptModelOri.v,OptModelNew.v,'VariableNames',{'rxn ID','rxn Name','Ori','Cobra'});
% Add Delta Column which is the percentage change relative to Ori
tabla.DeltaPorcentual = ((tabla.Cobra - tabla.Ori) ./ tabla.Ori) * 100 ;
% Delta = Ori - Cobra
tabla.Delta= ((tabla.Ori - tabla.Cobra));
%% Save table to CSV
writetable(tabla, 'DeltaModels.csv');