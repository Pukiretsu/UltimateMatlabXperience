y = [10.421 10.939 11.321 11.794 12.242 12.668]; % Resistencia
x = [10.50 29.49 42.70 60.01 75.51 91.05]; % Temperatura

% calculamos la matriz para un polinomio de grado 5


m = length(x);
coef = [m sum(x)
    sum(x) sum(x.^2)];

eq = [sum(y) sum(x.*y)]'

sol = inv(coef)*eq

s = linspace(5,100,1000);
fx = sol(1) + sol(2).*s;

hold on
plot(x,y,"go")
plot(s,fx,"b--")
hold off

err = sol(1) + sol(2).*x
errorCuadratico = sqrt((sum((err).^2))/m)