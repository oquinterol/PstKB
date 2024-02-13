%{
Task 1
1. Optimize the current model and create a table per reaction
2. Update the stoichiometry of the reactions and optimize again
3. Create a comparison table between the solutions of each model + a
relative delta or a way to measure their difference
%}

%% Initialize Cobratoolbox
initCobraToolbox(false)

%% Load the model, 'ori' represents the current model
ModelOri = readCbModel('/home/Oscar/Git/PstKB/PstKB.ori.xml');
OptModelOri = optimizeCbModel(ModelOri);
% Call the printFluxVector function and redirect the output to a text file
diary('FluxOri.txt');
printFluxVector(ModelOri, OptModelOri.v, 0);
diary off;
% import file as table
tablaOri = readtable('FluxOri.txt', 'ReadVariableNames', false);
%% Load 'cobra' represents the model with the updated stoichiometry
ModelNew = readCbModel('/home/Oscar/Git/PstKB/PstKB_cobra.xml');
OptModelNew = optimizeCbModel(ModelNew);
% Call printFluxVector and redirect the output to a text file
diary('FluxNew.txt');
printFluxVector(ModelNew, OptModelNew.v, 0);
diary off;
% import data from file
tablaNew = readtable('FluxNew.txt','ReadVariableNames',false);
%% Combinar las dos tablas
tabla = join(tablaOri,tablaNew,"Keys","Var1");
% Actualizar nombres
tabla.Properties.VariableNames(1) = "Reaction";
tabla.Properties.VariableNames(2) = "Ori";
tabla.Properties.VariableNames(3) = "Cobra";
% Agregar la Columna Delta
%tabla.Delta = 
tabla.DeltaRelativo = ((tabla.Ori - tabla.Cobra) ./ tabla.Ori);
%% Guarda la tabla en un archivo CSV
writetable(tabla, 'DeltaModels.csv');
