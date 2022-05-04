% [Intercambio de bases de numeros decimales]
%
% Programa para cambiar de base numeros decimales
% Programado por Pukiretsu [04/05/2022]
%
% Mas info en https://github.com/Pukiretsu/UltimateMatlabXperience

% Variables preliminares
base = input("Ingrese la base de destino: ");
result = zeros(0);
integer = input("Ingrese un numero decimal: ");

while true
    residual = mod(integer,base);
    division = floor(integer/base);
    integer = division;
    result(end+1) = residual;
    if (residual < base) && (integer == 0)
        result = flip(result);
        break
    end
end

display(result)