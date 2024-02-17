%% Crear una tabla comparando la estequimetria de todas las reacciones

%% Load the model, 'ori' represents the current model
ModelOri = readCbModel('/home/Oscar/Git/PstKB/Models/PstKB.ori.xml');
% Optimize model
OptModelOri = optimizeCbModel(ModelOri);
%% Load 'cobra' represents the model with the updated stoichiometry
ModelNew = readCbModel('/home/Oscar/Git/PstKB/Models/PstKB_cobra.xml');
% Optimize Model
OptModelNew = optimizeCbModel(ModelNew);

%% Create Table
