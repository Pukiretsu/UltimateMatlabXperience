% Programa para aproximar sistemas de ecuaciones diferenciales por Runge 
% Kutta de segundo orden
% ------------------------------------------------------------------------- 
% 
% Angel Gonzalez (github.com/Pukiretsu/UltimateMatlabXperience) [17-06-2022] 
% 

% Valores iniciales del problema
x_0 = 0;
x_n = 1;
y_0 = 0;
z_0 = 1;

% Especificamos los intervalos
n = 4;
h = abs(x_0-x_n)/n;

% Inicializamos los vectores para almacenar las respuestas
x_val = (x_0:h:x_n); 
y_val = (y_0);
z_val = (z_0);
k_1 = (0);
l_1 = (0);
k_2 = (0);
l_2 = (0);

% Iniciamos el ciclo para iterar los calculos
for i = (2:length(x_val))
    k_1(i) = k1O2(h, x_val(i-1), y_val(i-1), z_val(i-1));
    l_1(i) = l1O2(h, x_val(i-1), y_val(i-1), z_val(i-1));
    k_2(i) = k2O2(h, k_1(i), l_1(i), x_val(i-1), y_val(i-1),z_val(i-1));
    l_2(i) = l2O2(h, k_1(i), l_1(i), x_val(i-1), y_val(i-1),z_val(i-1));
    y_val(i) = y_val(i-1) + 1/2*(k_1(i) + k_2(i));
    z_val(i) = z_val(i-1) + 1/2*(l_1(i) + l_2(i));
end

% Presentacion de resultados en una tabla

headers = ["x" "y" "z" "k1" "l1" "k2" "l2"];
data = table(x_val', y_val', z_val', k_1', l_1', k_2', l_2');
data.Properties.VariableNames = headers;
display(data)

% ------------------------------------------------------------------------- 
% -                          Funciones                                   -
% ------------------------------------------------------------------------- 

% Tenemos aqui las ecuaciones diferenciales 
function val = Fy(x,y,z)
    val = z;
end

function val = Fz(x,y,z)
    val = -125*y - 20*z;
end

% Ecuaciones de 

function val = k1O2(h,x1,y1,z1)
    val = h*Fy(x1,y1,z1);
end

function val = l1O2(h,x1,y1,z1)
    val = h*Fz(x1,y1,z1);
end

function val = k2O2(h, k1, l1, x1, y1, z1)
   val = h*Fy(x1,(y1+k1),(z1+l1));
end

function val = l2O2(h, k1, l1, x1, y1, z1)
   val = h*Fz(x1,(y1+k1),(z1+l1));
end

