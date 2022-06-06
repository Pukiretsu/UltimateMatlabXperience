% Programa para comparar metodos de integracion         
% -------------------------------------------------------------------------
%
% Angel Gonzalez (github.com/Pukiretsu/UltimateMatlabXperience) [06-06-2022]
% 
% se tiene la funcion de estudio en el intervalo de -1 a 1

% Intervalo
x_0 = -1;
x_n = 1;

%Linearspace
li = linspace(x_0-1,x_n+1,10000);

% Función:
syms f(x)
f(x) = 1/sqrt(2*pi())*exp(-x^2/2);
values = 1/sqrt(2*pi())*exp(-li.^2/2);
func = @(x) 1/sqrt(2*pi())*exp(-x.^2/2);
%grafica:
plot(li,values);

% Calculamos el valor real

realValue = integral(func,x_0,x_n);

% -------------------------------------------------------------------------
% Metodo de trapecio
% -------------------------------------------------------------------------
% Para el metodo del trapecio tenemos un h tal que:
h = abs(x_0-x_n);

% Ahora la aproximacion de la integral será
Itrapecio = h/2*(double(f(-1)) + double(f(1)));

% Para el error utilizamos el valor real
T_Error = abs(Itrapecio - realValue);
T_ErrorPorcentual = T_Error/realValue * 100

% -------------------------------------------------------------------------
% Metodo de Simpson 1/3
% -------------------------------------------------------------------------
% Para el metodo del trapecio tenemos un h tal que:
h = abs(x_0-x_n)/2;

% Para la aproximacion
Isimpson1_3 = h/3*(double(f(-1))+4*double(f(0)) + double(f(1)));

% Para el error relativo utilizamos el valor real
S13_Error = abs(Isimpson1_3 - realValue);
S13_ErrorPorcentual = T_Error/realValue * 100;

% -------------------------------------------------------------------------
% Metodo de Simpson 3/8
% -------------------------------------------------------------------------
% Para el metodo del trapecio tenemos un h tal que:
h = abs(x_0-x_n)/3;
xi = linspace(-1,1,4);
funx = 1/sqrt(2*pi())*exp(-xi.^2/2);

% Para la aproximacion
Isimpson3_8 = 3*h/8*(funx(1)+ 3*funx(2) + 3*funx(3) + funx(4));

% Para el error utilizamos el valor real
S38_Error = abs(Isimpson1_3 - realValue);
S38_ErrorPorcentual = T_Error/realValue * 100;

metodo = ["Trapecio" "Simpson 1/3" "Simpson 3/8"]';
valor = [Itrapecio Isimpson1_3 Isimpson3_8]';
Error = [T_Error S13_Error S13_Error]';
ErrorPorcentual = [T_ErrorPorcentual S13_ErrorPorcentual S13_ErrorPorcentual]';
Resultados = table(valor, Error, ErrorPorcentual);
Resultados.Properties.VariableNames = ["Aproximacion" "Error Relativo" "Error Porcentual (%)"];
Resultados.Properties.RowNames = metodo;

display(Resultados)
