% Problemas de Aproximacion polinomial
% -------------------------------------------------------------------------
% La densidad del carbonato neutro de potasio en solucion acusosa varia con
% la temperatura y la concentracion de acuerdo con la tabla.
%
% [Esta declarada en las variables]
%
%   a. Calcule la densidad a 40°C y 15% de concentración
%
%   b. Calcule la densidad a 50°C y 28% de concentración
%
%   c. Calcule la densidad a 90°C y 25% de concentración
%
%   d. Calcule la concentracion que tiene una solución de densidad 1.129 a
%   una temperatura de 60°C
%
%--------------------------------------------------------------------------
%       Programado por Angel Gonzalez (AKA Pukiretsu) [14/05/2022]
%
% Mas info en https://github.com/Pukiretsu/UltimateMatlabXperience


% Declaracion de datos

syms lagrangeint(x)

% Primera fila Temperaturas
% Primera columna Concentraciones
values = [ nan  0       40      80      100;
            4   1.0381  1.0276  1.0063  0.9931;
            12  1.1160  1.1013  1.0786  1.0663;
            20  1.1977  1.1801  1.1570  1.1451;
            28  1.2846  1.2652  1.2418  1.2301];

%--------------------------------------------------------------------------
% A. Densidad a 40°C y 15% de concentración

xi = values(2:end,1)';
yi = values(2:end,3)';

maxGrade = Lg_MaxPolyGrade(xi, yi);
lagrangeint(x) = LagrangeAproxPoly(xi, yi, maxGrade, false);
aprox = lagrangeint(15);

ErrorCuadratico = Lg_AvrgCuadraticError(lagrangeint,xi,yi);

disp("[Punto A]")
disp("La densidad a 40°C y 15% concentracion es: " + double(aprox) + "")
disp("Con un error cuadratico medio tal que: " + ErrorCuadratico)

%--------------------------------------------------------------------------
% B. Densidad a 50°C y 28% de concentración

xi = values(1,2:end);
yi = values(5,2:end);

maxGrade = Lg_MaxPolyGrade(xi, yi);
lagrangeint(x) = LagrangeAproxPoly(xi, yi, maxGrade, false);
aprox = lagrangeint(50);

ErrorCuadratico = Lg_AvrgCuadraticError(lagrangeint,xi,yi);

disp(" ")
disp("[Punto B]")
disp("La densidad a 50°C y 28% concentracion es: " + double(aprox) + "")
disp("Con un error cuadratico medio tal que: " + ErrorCuadratico)

%--------------------------------------------------------------------------
% C. Densidad a 90°C y 25% de concentración

xi = values(1, 2:end);

yi = values(4, 2:end);
maxGrade = Lg_MaxPolyGrade(xi, yi);
lagrangeint(x) = LagrangeAproxPoly(xi, yi, maxGrade, false);
aprox = (lagrangeint(90));

yi = values(5, 2:end);
lagrangeint(x) = LagrangeAproxPoly(xi, yi, maxGrade, false);
aprox(end+1) = lagrangeint(90);

xi = values(4:end, 1)';
yi = double(aprox);

maxGrade = Lg_MaxPolyGrade(xi, yi);
lagrangeint(x) = LagrangeAproxPoly(xi, yi, maxGrade, false);
aprox = (lagrangeint(25));

disp(" ")
disp("[Punto C]")
disp("La densidad a 90°C y 25% concentracion es: " + double(aprox) + "")

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

function AvgError2 = Lg_AvrgCuadraticError(lagrangeint,xi,yi)

    Error = zeros(0);
    
    for i = 1:length(xi)
        Error(i) = lagrangeint(xi(i)) - yi(i);
    end
    
    AvgError2 = sqrt(sum(Error.^2)/length(xi)); 

end
