% Ajuste de curvas por Polinomios de Lagrange
% ------------------------------------------------------------------------
% El programa establece que al ser alimentada por un conjunto de datos
% correlacionados devuelve un polinomio (En forma de funcion simbolica) de 
% grado maximo n-1 siendo n la cantidad total de datos correlacionados.
%
% Tambien opcionalmente enseña paso por paso la lista de coeficientes necesarios para
% armar el polinomio.
% Programado por Pukiretsu [13-05-2022]
%
% Mas info en https://github.com/Pukiretsu/UltimateMatlabXperience

function LagrangePoly = LagrangeAproxPoly (xData, yData, nGrade, DISPLAY)
    % Declaramos las funciones simbolicas 
    %   lagrangeinterp -> Almacena la respuesta final, es decir el 
    %   polinomio entero de interpolación 
    %   temp -> Almacena temporalmente los factores de lagrange (Ln)
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
    if lenght(xData) == length(yData)
        maxGrade = length(xData);
    else
        maxGrade = nan;
    end
end