% Quiz aproximacion por minimos Cuadrados
% -------------------------------------------------------------------------
% 
% Angel Gonzalez (github.com/Pukiretsu) [09-05-2022]
% 
% Declaracion de los datos

v = [26.43 22.4 19.08 16.32 14.04 12.12 10.12 9.15 8];
p = [14.7 17.53 20.8 24.54 28.83 33.71 39.25 45.49 52.52];


% Encontramos parametros retornados por la funcion factor

len = length(v);
[A, B] = Minexp(len, v, p);

display("Se tiene que la funcion es de la forma: " + A + "e^("+ B +"v)")

% Calcular error cuadratico medio
Error = A.*exp(v.*B) - p;
error_Cuadratico = sqrt((sum((Error).^2))/len)


% Graficamos para confirmar la aproximacion
y = linspace(5,30,100);
exfunc = A.*exp(y.*B);
hold on
plot(v,p,"gx",LineWidth=5)
plot(y,exfunc,"b--")
hold off

function [A, B] = Minexp(m, xi, yi)
    % Armamos el sistema matricial conforme a la solucion de la
    % aproximacion
    coef = [m sum(xi) ; sum(xi) sum(xi.^2)];
    eq = [sum(log(yi)) sum(xi.*log(yi))]';
    sol = inv(coef)*eq;
    
    A = exp(sol(1));
    B = sol(2);
end
