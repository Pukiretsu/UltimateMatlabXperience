% Aproximación polinomio de newton por diferencias finitias adelante y atrás
% ------------------------------------------------------------------------
% El programa retorna la funcion simbolica para evaluar cualquier valor S
% que se requiera para la aproximacion de newton con respecto a diferencias
% finitas, tambien retorna la tabla de diferencias divididas hacia adelante
% y hacia atrás
%
% Programado por Pukiretsu [13-05-2022]
%
% Mas info en https://github.com/Pukiretsu/UltimateMatlabXperience

function [fowardTable, backTable] = NW_finitDifferences(yi)
    % Configuracion de matriz para almacenar las diferencias
    fowardTable = zeros(length(yi));
    backTable = zeros(length(yi));
    
    fowardTable(:,1) = yi;
    backTable(:,1) = flip(yi);

    for i = 1 : length(yi)-1
        for j = 1:length(yi)-i
            fowardTable(j,i+1) = fowardTable(j+1,i) - fowardTable(j,i);
            backTable(j,i+1) = backTable(j+1,i) - backTable(j,i);
        end
    end
end

function h = NW_CheckEvenSpace(xi)
    h = (xi(end) - xi(1))/(length(xi)-1);

    for i = 1:lenght(xi)-1
        if x(i+1)-xi(i) ~= h
            h = nan;
        end
    end
end

function sValue = NW_SValue(x,xi,pivot,h)
    sValue = (x- xi(pivot))/h;
end

function [fowardDiff, backDiff] = NW_buildSymFinitDiff(fowardDifferences, backDifferences, pivot)
    syms fowardDiffApprox(s) backDiffApprox(s) F_factors(s) B_factors(s)
    
    fowardDiff(s) = fowardDifferences(pivot,1) + s * fowardDifferences(pivot,2);
    backDiff(s) = backDifferences(pivot,1) + s * backDifferences(pivot,2);
    
    for i = 1:length(yi)-pivot
        F_factors(s) = s;
        B_factors(s) = s;

        for j = 1:i
            F_factors(s) = F_factors(s) * (s-j);
            B_factors(s) = B_factors(s) * (s+j);
        end
    
        F_factors(s) = F_factors(s) * fowardDifferences(pivot,i+1) / factorial(i+1);
        fowardDiff(s) = fowardDiff(s) + F_factors(s);
    

        B_factors(s) = B_factors(s) * backDifferences(pivot,i+1) / factorial(i+1);
        backDiff(s) = backDiff(s) + B_factors(s);
    end
end