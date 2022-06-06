x = [0.1 0.2 0.3 0.4 0.5 0.6 0.7] % Tiempo
y = [0.073 0.220 0.301 0.370 0.418 0.467 0.517] % Intensidad

m = length(x)
coef = [m sum(x); sum(x) sum(x.^2)]
eq = [sum(log(1.-y)) sum(x.*log(1.-y))]'

sol = inv(coef)*eq
A = exp(sol(1))
B = sol(2)

Error = A.*exp(x.*B) - y;
error_Cuadratico = sqrt((sum((Error).^2))/m)