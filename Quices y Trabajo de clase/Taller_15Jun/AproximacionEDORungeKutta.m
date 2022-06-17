% Programa para aproximar ecuaciones diferenciales por Runge Kutta
% ------------------------------------------------------------------------- 
% 
% Angel Gonzalez (github.com/Pukiretsu/UltimateMatlabXperience) [13-06-2022]   

% ------------------------------------------------------------------------
% RK2
% ------------------------------------------------------------------------

x_0 = 0;
x_n = 1;
y_0 = 2;

n = 5;
h = abs(x_0-x_n)/n;

x_val = (x_0:h:x_n); 
y_val = (y_0);
k_1 = (0);
k_2 = (0);

for i = (2:length(x_val))
    k_1(i) = k1O2(h, x_val(i-1), y_val(i-1));
    k_2(i) = k2O2(h, k_1(i), x_val(i), y_val(i-1));
    y_val(i) = y_val(i-1) + 1/2*(k_1(i)+k_2(i));
end

headers = ["x" "y" "k1" "k2"];
data = table(x_val', y_val', k_1', k_2');
data.Properties.VariableNames = headers;
%display(data)

% ------------------------------------------------------------------------
% RK3
% ------------------------------------------------------------------------

x_0 = 0;
x_n = 1;
y_0 = 2;

n = 5;
h = abs(x_0-x_n)/n;

x_val = (x_0:h:x_n);
y_val = (y_0);
k_1 = (0);
k_2 = (0);
k_3 = (0);

for i = (2:length(x_val))
    k_1(i) = k1O3(h, x_val(i-1), y_val(i-1));
    k_2(i) = k2O3(h, k_1(i), x_val(i-1), y_val(i-1));
    k_3(i) = k3O3(h, k_1(i), k_2(i), x_val(i-1), y_val(i-1));
    y_val(i) = y_val(i-1) + 1/6*(k_1(i)+4*k_2(i)+k_3(i));
end

headers = ["x" "y" "k1" "k2" "k3"];
data = table(x_val', y_val', k_1', k_2', k_3');
data.Properties.VariableNames = headers;
display("Sistema")
display(data)


% ------------------------------------------------------------------------- 
% -                          Funciones                                   -
% ------------------------------------------------------------------------- 

function val = Fx(x,y)
    val = x-y;
end

% Runge Kutta Orden 2
function val = k1O2(h,x1,y1)
    val = h*Fx(x1,y1);
end

function val = k2O2(h, k1, x2, y1)
   val = h*Fx(x2,(y1+k1));
end

% Runge Kutta Orden 3
function val = k1O3(h, x1, y1)
    val = h*Fx(x1,y1);
end

function val = k2O3(h, k1, x1, y1)
    val = h*Fx(x1+h/2, y1+(1/2*k1));
end

function val = k3O3(h, k1, k2, x1, y1)
    val = h*Fx(x1+h,y1-k1+2*k2);
end