% Problemas de Aproximacion polinomial
% -------------------------------------------------------------------------
% Se sospecha que las elevadas concentraciones de tanina en las hojas de
% los robles maduros inhiben el crecimiento de las larvas de la polilla
% invernal que tanto dañana a los arboles en algunos años. La tabla anexa
% contiene el peso promedio de una muestra de larvas, formada en los
% primeros 28 dias despues del nacimiento
%
%   a. Use interpolacion de Lagrange para aproximar la curva del peso
%   promedio de las muestras
%
%   b. Determine el maximo polinomio interpolante para calcular el peso
%   promedio maximo de la muestra
%
%--------------------------------------------------------------------------
%       Programado por Angel Gonzalez (AKA Pukiretsu) [13/05/2022]
%
% Mas info en https://github.com/Pukiretsu/UltimateMatlabXperience

% Configuracion de variables
syms lagrangeint(x)
%primer ejercicio
disp("Primer Punto: ")

% Declaracion de datos
xi = [0 6 10 13 17 20 28];
yi = [6.67 17.33 42.67 37.33 30.10 29.31 28.74];

Datos = [xi' yi'];

disp("Se sospecha que las elevadas concentraciones de tanina en las hojas de")
disp("los robles maduros inhiben el crecimiento de las larvas de la polilla")
disp("invernal que tanto dañana a los arboles en algunos años. La tabla anexa")
disp("contiene el peso promedio de una muestra de larvas, formada en los")
disp("primeros 28 dias despues del nacimiento")

disp("Se tienen los siguientes datos: ")
display(Datos)

% Hallamos el polinomio de Lagrange
maxGrade = Lg_MaxPolyGrade(xi, yi);
lagrangeint(x) = LagrangeAproxPoly(xi, yi, maxGrade, false);

% Calculamos su respectiva derivada para hallar el maximo promedio
derivada = diff(lagrangeint); 

% En caso de ser necesarios solo los coeficientes del polinomio descomentar
%Coeficientes_LG = sym2poly(lagrangeint(x)); 
%Coeficientes_dLGdx = sym2poly(derivada); 

disp("A. El polinomio de lagrange de grado "+ maxGrade + " que mejor se ajusta es: ")
Polinomio = expand(lagrangeint)

% Encontramos los puntos criticos de la derivada
raicesdx = vpasolve(derivada);

% Evaluamos los puntos criticos
Evaluation = zeros(0);

for i = 1 : size(raicesdx)
    if isreal(raicesdx(i)) % Evaluamos solo las raices reales
        Evaluation(i) = lagrangeint(raicesdx(i));
    end
end

disp("B. Promedio maximo: " + max(Evaluation))

% Realizamos el calculo del error cuadratico medio

Error = zeros(0);

for i = 1:length(xi)
    Error(i) = lagrangeint(xi(i)) - yi(i);
end

ErrorCuadratico = sqrt(sum(Error.^2)/length(xi)); 

disp("Error cuadrático medio: " + ErrorCuadratico)


% Grafica de los puntos y la curva de ajuste

y = linspace(-1,30,1000);
approxfun = lagrangeint(y);
dxfun = derivada(y);

hold on

    % Grafica de los datos
    plot(xi,yi,"gx",LineWidth=5)
    % Grafica del polinomio de interpolación
    plot(y,approxfun, "r-")

hold off
% -------------------------------------------------------------------------
% [Espacio para las funciones]
% -------------------------------------------------------------------------
function LagrangePoly = LagrangeAproxPoly (xData, yData, nGrade, DISPLAY)
    % Declaramos las funciones simbolicas 
    %   LagrangePolynom -> Almacena la respuesta final, es decir el 
    %   polinomio entero de interpolación 
    %   LagrangeFactor_ -> Almacena temporalmente los factores de lagrange (Ln)
    %   necesarios para construir el polinomio de aproximación
    syms LagrangePolynom(x) LagrangeFactor_(x)
    LagrangePolynom(x) = 0; % Se inicializa en cero para que no de errores
    
    % Se usa un ciclo que recorre cada valor en los vectores de datos 
    for i = 1 : nGrade+1 
        divisor = 1;
        LagrangeFactor_(x) = 1;
        for j = 1:nGrade+1
            if xData(i) ~= xData(j) 
                % Se hace esa comprobacion para que el divisor no se vuelva
                % cero y por lo tanto invalide los factores de lagrange 
                LagrangeFactor_(x) = LagrangeFactor_(x) * (x - xData(j));
                divisor = divisor * (xData(i) - xData(j));
            end
        end
        
        % Al finalizar cada ciclo armamos el factor
        LagrangeFactor_(x) = (LagrangeFactor_(x)) / divisor;

        if DISPLAY % Si es verdadero muestra cada factor en orden
            display("[L_" + (i-1) + "]")
            display(LagrangeFactor_(x))
        end
        
        LagrangePolynom(x) = LagrangePolynom(x) + LagrangeFactor_(x)*yData(i); 
    end
    LagrangePoly = LagrangePolynom(x);
end

% UTILIDADES

function maxGrade = Lg_MaxPolyGrade(xData, yData)
    % Funcion que retorna el grado maximo del polinomio de Lagrange datos
    % un conjunto de datos correlacionados, si la funcion retorna nan es
    % porque la cantidad de datos no es la misma para los conjuntos dados
    if length(xData) == length(yData)
        maxGrade = length(xData) - 1;
    else
        maxGrade = nan;
    end
end