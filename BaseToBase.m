% [Intercambio de bases de numeros decimales]
%
% Programa para cambiar de base numeros decimales
% Programado por Pukiretsu [10/05/2022]
%
% Mas info en https://github.com/Pukiretsu/UltimateMatlabXperience

% Variables de configuracion

process = true; %muestra un display del proceso paso a paso

% ----- Proceso de cambio de decimal a nBase ------

% Variables preliminares

base = input("Ingrese la base de destino: ");
result = zeros(0);
integer = input("Ingrese un numero decimal: ");

while true
    residual = mod(integer,base);
    division = floor(integer/base);
    if process
        display(integer + " / " + base + " = " + division + " Residuo: " + residual)
    end
    integer = division;
    result(end+1) = residual;
    
    if (residual < base) && (integer == 0)
        result = flip(result);
        break
    end
end

display(result)