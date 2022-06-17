% Programa para aproximar ecuaciones diferenciales 
% ------------------------------------------------------------------------- 
% 
% Angel Gonzalez (github.com/Pukiretsu/UltimateMatlabXperience) [13-06-2022] 
%  
% 

% ------------------------------------------------------------------------- 
% Primer punto
% ------------------------------------------------------------------------- 

N = 5; 

% PVI 
X_0 = 0; 
X_1 = 1; 
Y_0 = 2; 

% Utilizamos la funcion para calcular una EDO sencilla
[x_val, y_val] = EDO_dX(N, X_0, X_1, Y_0);

headers = ["x" "y"];
data = table(x_val', y_val');
data.Properties.VariableNames = headers;
display("EDO sencilla")
display(data)

% ------------------------------------------------------------------------- 
% Segundo punto
% ------------------------------------------------------------------------- 


% Definimos las condiciones iniciales
x_0 = 0;
x_n = 1;
y_0 = 0;
z_0 = 1;

% Encontramos h para el sistema
h = abs(x_0-x_n)/4;

x_val = (x_0:h:x_n); 

y_val = (y_0);
z_val = (z_0);

% Calculamos las iteraciones intercalando los resultados
for i = (2:length(x_val))
    Fy = dydx(0,0,z_val(i-1));
    y_val(i) = AproxEDO(h,y_val(i-1),Fy);
    
    Fz = dzdx(0,y_val(i-1),z_val(i-1));
    z_val(i) = AproxEDO(h,z_val(i-1),Fz);
end

% Muestra de resultados
headers = ["x" "y" "z"];
data = table(x_val', y_val', z_val');
data.Properties.VariableNames = headers;
display("Sistema")
display(data)

% ------------------------------------------------------------------------
% Funciones
% ------------------------------------------------------------------------

function ans = AproxEDO(h, xn, Fx)
    ans = xn + h*Fx;
end

function [x_val, y_val] = EDO_dX(n, x_0, x_1, y_0) 
     % Calculo de H 
     h = abs(x_1-x_0)/n; 
      
     % Vectores respuesta 
     x_val = (x_0:h:x_1); 
     y_val = [y_0]; 
      
    for i = (2:length(x_val)) 
         y_val(i) = y_val(i-1) + h*dy_dx(x_val(i-1),y_val(i-1)); 
    end 
end 

function val = dy_dx(x,y) 
     val = x-y; 
end

function val = dydx(x,y,z)
    val = z;
end

function val = dzdx(x,y,z)
    val = -125*y-20*z;
end