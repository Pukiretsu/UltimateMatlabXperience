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

% --------------------------- Simple --------------------------------------
% Se toma un n = 1 ya que solo se toma un subintervalo de 2 puntos
[Itrapecio, T_Error, T_ErrorPorcentual] = Trapecio(1,x_0,x_n,realValue);

% --------------------------- Compuesto -----------------------------------
% Se puede especificar la cantidad de subintervalos a tomar con la variable 
% nT 
nT = 2;
[ItrapecioC, TC_Error, TC_ErrorPorcentual] = Trapecio(nT,x_0,x_n,realValue); 

% -------------------------------------------------------------------------
% Metodo de Simpson 1/3
% -------------------------------------------------------------------------

% --------------------------- Simple --------------------------------------
% Se toma un n = 2 ya que se requieren 2 subintervalos conformados por 3
% puntos
[Isimpson1_3, S13_Error, S13_ErrorPorcentual] = Simpson13(2,x_0,x_n,realValue);

% --------------------------- Compuesto -----------------------------------
% Se puede especificar la cantidad de subintervalos a tomar con la variable 
% nS13
nS13 = 3;
[Isimpson1_3C, S13C_Error, S13C_ErrorPorcentual] = Simpson13(nS13,x_0,x_n,realValue);

% -------------------------------------------------------------------------
% Metodo de Simpson 3/8
% -------------------------------------------------------------------------

% --------------------------- Simple --------------------------------------
% Se toma un n = 3 ya que se requieren 2 subintervalos conformados por 4
% puntos

[Isimpson3_8, S38_Error, S38_ErrorPorcentual] = Simpson38(3,x_0,x_n,realValue);

% --------------------------- Compuesto -----------------------------------
% Se puede especificar la cantidad de subintervalos a tomar con la variable 
% nS38

nS38 = 4;

[Isimpson3_8C, S38C_Error, S38C_ErrorPorcentual] = Simpson38(nS38,x_0,x_n,realValue);

% -------------------------------------------------------------------------
% Metodo de Gauss Legendre
% -------------------------------------------------------------------------

% -------------------------- Para dos puntos ------------------------------
% Encontramos un valor de los limites para 2 puntos
% z1 = -0.577350269
% z2 = 0.577350269
% 
% Ya que los limites estan evaluados en -1 y 1 no es necesario realizar la
% sustitución

% Para la aproximación
IGausLegendre2p = double(f(-0.577350269)) + double(f(0.577350269));

% Para el error
GL2p_Error = abs(IGausLegendre2p - realValue);
GL2p_ErrorPorcentual = GL2p_Error/realValue * 100;

% -------------------------------------------------------------------------
% Resultados
% ------------------------------------------------------------------------- 

% Construccion de la tabla de resultados con los valores obtenidos

valor = [Itrapecio Isimpson1_3 Isimpson3_8 IGausLegendre2p ItrapecioC Isimpson1_3C Isimpson3_8C]';
Error = [T_Error S13_Error S38_Error GL2p_Error TC_Error S13C_Error S38C_Error]';
ErrorPorcentual = [T_ErrorPorcentual S13_ErrorPorcentual S38_ErrorPorcentual GL2p_ErrorPorcentual TC_ErrorPorcentual S13C_ErrorPorcentual S38C_ErrorPorcentual]';

Resultados = table(valor, Error, ErrorPorcentual);
Resultados.Properties.VariableNames = ["Aproximacion" "Error Relativo" "Error Porcentual (%)"];
metodo = ["Trapecio" "Simpson 1/3" "Simpson 3/8" "Gaus-Legendre 2 Puntos" "Trapecio Compuesto (2)" "Simpson 1/3 Compuesto2 (3)" "Simpson 3/8 Compuesto (4)"]';
Resultados.Properties.RowNames = metodo;

% Mostrar en pantalla los resultados
display(Resultados)

% Para seleccionar la mejor aproximacion con el error porcentual
[val, idx] = min(ErrorPorcentual);
display("La mejor aproximación será por el metodo de " + Resultados.Properties.RowNames(idx))

% ------------------------------------------------------------------------
% -                          Funciones                                   -
% ------------------------------------------------------------------------

% Obtener valores de la funcion
function resValues = functionValues(xi)
    resValues = 1/sqrt(2*pi())*exp(-xi.^2/2);
end

% Trapecio 
function [iValue, relError, percentError] = Trapecio(n, x0, xn, realValue)
    % Calculos para h y los puntos de subintervalos
    h = abs(x0 - xn)/n;
    xi = (x0:h:xn);
    values = functionValues(xi);
    
    % Calculamos la aproximación de la integral por trapecios
    iValue = h/2*(values(1) + 2*sum(values(2:end-1)) + values(end));
    
    % Evalua si la funcion lleva el Valor real para calculo de errores
    if nargin == 4
        relError = abs(iValue - realValue);
        percentError = relError/realValue * 100;
    else
        % TODO: Aqui deberian ir los calculos para errores por trapecio de forma
        % analitica.
        relError = nan;
        percentError = nan;
    end
end

% Simpson 1/3

function [iValue, relError, percentError] = Simpson13(n, x0, xn, realValue)
    % Calculos para h y los puntos de subintervalos
    h = abs(x0-xn)/n;
    xi = (x0:h:xn);
    values = functionValues(xi);

    % Calculamos la aproximación de la integral por Simpson 1/3
    iValue = h/3*(values(1) + 4*sum(values(2:2:end-1)) + 2*sum(values(3:3:end-1)) + values(end));
    
    % Evalua si la funcion lleva el Valor real para calculo de errores
    if nargin == 4
        relError = abs(iValue - realValue);
        percentError = relError/realValue * 100;
    else
        % TODO: Aqui deberian ir los calculos para errores por Simpson 1/3 
        % de forma analitica.
        relError = nan;
        percentError = nan;
    end
end

% Simpson 3/8

function [iValue, relError, percentError] = Simpson38(n, x0, xn, realValue)
    % Calculos para h y los puntos de subintervalos
    h = abs(x0-xn)/n;
    xi = (x0:h:xn);
    values = functionValues(xi);

    % Calculamos la aproximación de la integral por Simpson 3/8
    iValue = 3*h/8*(values(1) + 3 * (sum(values(2:3:end-1)) + sum(values(3:3:end-1))) + 2*sum(values(4:3:end-1))+ values(end));
    
    % Evalua si la funcion lleva el Valor real para calculo de errores
    if nargin == 4
        relError = abs(iValue - realValue);
        percentError = relError/realValue * 100;
    else
        % TODO: Aqui deberian ir los calculos para errores por Simpson 3/8 
        % de forma analitica.
        relError = nan;
        percentError = nan;
    end
end