% Aproximación polinomial por diferencias finitias hacia adelante
% ------------------------------------------------------------------------
%
%   Por ahora solo retorna una tabla de diferencias divididas
%
%
%
% Programado por Pukiretsu [13-05-2022]
%
% Mas info en https://github.com/Pukiretsu/UltimateMatlabXperience

syms finitDiffApprox(s) factors(s)

% Dclaracion de datos
xi = [140 180 220 240];
yi = [12800 7500 5000 3800];

pivot = 1; % Por que valor comenzar a realizar el ajuste

% Calculos de interpolacion
h = 10;
interpVal = 64; % Cambiar este valor para interpolar

value = (interpVal - xi(pivot))/h;

% Configuracion de matriz para almacenar las diferencias
finitDiferences = zeros(length(yi));
finitDiferences(:,1) = yi;

for i = 1 : length(yi)-1
    for j = 1:length(yi)-i
        finitDiferences(j,i+1) = finitDiferences(j+1,i) - finitDiferences(j,i);
    end
end

finitDiffApprox(s) = finitDiferences(pivot,1) + s * finitDiferences(pivot,2);

for i = 1:length(yi)-pivot
    factors(s) = s;
    
    for j = 1:i
        factors(s) = factors(s) * (s-j);
    end

    factors(s) = factors(s) * finitDiferences(pivot,i+1) / factorial(i+1);
    finitDiffApprox(s) = finitDiffApprox(s) + factors(s)
end

FD_Approximation = double(finitDiffApprox(value));

disp("La tabla de diferencias finitas es:")
disp(" ")
disp(finitDiferences)
disp(" ")
disp("La interpolacion para " + interpVal + " es: " + FD_Approximation)