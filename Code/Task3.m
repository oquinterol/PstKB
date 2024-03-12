%{
Task 3: Sequential Evaluation and Optimization of Potato Metabolic Model
The objective of this task is to methodically assess each modification made
to the potato metabolic model.
%}
initCobraToolbox(false)
cd('~/Git/PstKB/')
% Read the metabolic reconstruction models
ModelOri = readCbModel('~/Git/PstKB/Models/PstKB.ori.xml');
%% Test load new  values to update model
Tabla = readtable("Data/Comparative-OFs.csv");
%% Reaccion objetivo
RxnID_Obj = 'R_bio1_biomass';
%% Identify exchange reactions in the ModelNew model
ExcRxns = ModelOri.rxns(findExcRxns(ModelOri));
%% Iterar las reacciones

% Inicialización de la matriz para almacenar los resultados
resultados = zeros(height(Tabla), 4);
% Bucle para actualizar la estequiometria de cada especie y optimizar
for i = 1:height(Tabla)
  % Creación de una copia del modelo original
  ModelUp = ModelOri;  
  % Obtención del ID de la especie
  id = Tabla.ID{i};  
  disp(id)
  % Obtención del valor de estequiometria
  nuevoValor = Tabla.PstKB_cobra(i);  
  %disp(nuevoValor)
  % Búsqueda del índice del metabolito
  %prueba=findMetIDs(ModelUp, id);
  %disp(prueba);
  %metIndex = findMetIDs(ModelUp, id);  
  % Actualización del valor de la estequiometria en la reacción objetivo
  %ModelUp.metCoeffs(metIndex, findRxnIDs(ModelUp, RxnID_Obj)) = nuevoValor;
  % Optimización del modelo
  %solution = optimizeCbModel(ModelUp);
  % Almacenamiento de los resultados
  %resultados(i, 1) = i;
  %resultados(i, 2) = id;
  %resultados(i, 3) = nuevoValor;
  %resultados(i, 4) = solution.f;
end