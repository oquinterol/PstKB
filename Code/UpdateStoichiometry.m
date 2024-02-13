%{ 
Modify the stoichiometry of the species in the objective function,
bio1_biomass -> These values will be replaced by the values found in the 
modelData.xls file, Comparative OFs sheet, PstKB_cobra column
%}

% Cargar la hoja de excel, modelData.xls
PathFileXLS = '/home/Oscar/Git/PstKB/modelData.xls';
ComparativeTable = readtable(PathFileXLS,'Sheet','Comparative OFs');

% Load the model as a libSBML object, 'ori' represents the current model and
% 'cobra' represents the model with the updated stoichiometry.
PathFileOri = '/home/Oscar/Git/PstKB/PstKB.ori.xml';
PathFileCobra = '/home/Oscar/Git/PstKB/PstKB_cobra.xml';
papita = readCbModel(PathFileOri);
% Objective Function is: 'bio1_biomass'
% Encontrar la reacción de la función objetivo 'bio1_biomass'
idx_funcion_objetivo = find(strcmp(papita.rxns, 'bio1_biomass'));
% Obtener los índices de las especies asociadas a la función objetivo
especies_funcion_objetivo_idx = find(papita.S(:, idx_funcion_objetivo) ~= 0);
% Obtener los nombres de las especies asociadas a la función objetivo
especies_funcion_objetivo = papita.mets(especies_funcion_objetivo_idx);
% Mostrar las especies de la función objetivo
disp('Especies de la función objetivo:');
disp(especies_funcion_objetivo);


