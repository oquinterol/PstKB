%{
Task2, make a robustness analysis from all exchange reactions
%}
%% Initialize Cobratoolbox
initCobraToolbox(false)
cd('/home/Oscar/Git/PstKB/')
%% Load 'cobra' model
ModelNew = readCbModel('/home/Oscar/Git/PstKB/Models/PstKB_cobra.xml');
% Optimize Model
OptModelNew = optimizeCbModel(ModelNew);
%% Make Robustness analysis (My wayy)
resultados = [];
ExcRxns = ModelNew.rxns(findExcRxns(ModelNew));
for i=1:length(ExcRxns)
    RobAn = robustnessAnalysis(ModelNew, ExcRxns(i), 50, false);
    resultados = [resultados; RobAn'];
end
% Grafica los resultados y asigna las leyendas
plot(resultados');
legend(ExcRxns);
%% Realiza el análisis para cada reacción y almacena los resultados en una matriz (ChatGPT Way)
resultados = zeros(length(ExcRxns), 50);
for i = 1:length(ExcRxns)
    RobAn = robustnessAnalysis(ModelNew, ExcRxns{i}, 50, false); % Cambio ExcRxns(i) por ExcRxns{i}
    resultados(i, :) = RobAn'; % Transpongo RobAn antes de asignarlo a resultados
end
% Grafica los resultados y asigna las leyendas
figure; % Crea una nueva figura
hold on; % Permite superponer múltiples gráficos en la misma figura
colores = lines(length(ExcRxns)); % Genera una paleta de colores automáticamente
lineStyles = {'-', '--', ':', '-.'}; % Estilos de línea diferentes
for i = 1:length(ExcRxns)
    plot(resultados(i,:), 'Color', colores(i,:), 'LineStyle', lineStyles{mod(i,4)+1}); % Selecciona un estilo de línea diferente para cada conjunto de datos
end
legend(ExcRxns);
hold off; % Finaliza la superposición de gráficos
xlabel('Robustess Analysis');
ylabel('Reacciones de intercambio');
title('General del Analisis de Robustez');
%% Graficas independientes para cada Reaccion 
% Realiza el análisis y grafica los resultados para cada reacción
for i = 1:length(ExcRxns)
    % Realiza el análisis para la reacción i
    RobAn = robustnessAnalysis(ModelNew, ExcRxns{i}, 50, false);
    % Crea una nueva figura para cada reacción
    figure;
    plot(RobAn);
    % Añade etiquetas y título
    xlabel(['Reaccion: ',ExcRxns{i}]);
    ylabel('Robustness Analysis');
    title(['Gráfica para la reacción: ', ExcRxns{i}]);
    % Guarda la figura como una imagen en la carpeta "fig" con el nombre de la reacción
    nombre_archivo = fullfile('fig', [ExcRxns{i}, '.png']);
    saveas(gcf, nombre_archivo);
    close;
end