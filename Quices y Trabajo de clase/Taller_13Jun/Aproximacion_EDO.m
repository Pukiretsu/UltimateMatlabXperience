% Programa para aproximar ecuaciones diferenciales
% -------------------------------------------------------------------------
%
% Angel Gonzalez (github.com/Pukiretsu/UltimateMatlabXperience) [13-06-2022]
% 
% Si se tiene una division de 5

n = 5;

% PVI
x_0 = 0;
x_1 = 1;
y_0 = 2;


function [x_val, y_val] = EDO_dX(x_0, x_1, y_0, n)
    % Calculo de H
    h = abs(x_1-x_0)/n;
    
    % Vectores respuesta
    x_val = (x_0:h:x_1);
    y_val = [y_0];
    
    for i = (2:length(x_val))
        y_val(i) = y_val(i-1) + h*Fx(x_val(i-1),y_val(i-1));
    end
end

function val = Fx(x,y)
    val = x-y;
end
