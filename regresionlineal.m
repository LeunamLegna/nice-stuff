% ------------------
% FUNCIÓN: REGRESIÓN LINEAL
% ------------------
function [m,n,errorm,errorn,erroresY,r]=regresionlineal(X,Y)
% -------------------------------------------------------------------------
% Función que calcula la recta de regresión que mejor se aproxima a una
% serie de datos.
% -------------------------------------------------------------------------
% Argumentos de entrada:
%   -- X.- Vector con los valores ordenados del eje X
%   -- Y.- Vector con los valores ordenados del eje Y
% Argumentos de salida:
%   -- m.- Pendiente de la recta de regresión
%   -- n.- Ordenada en el origen de la recta de regresión
%   -- errorm.- Error de la pendiente
%   -- errorn.- Error de la ordenada
%   -- errores Y.- Valores para las barras de error de los valores Y
%   -- r.- Coeficiente de correlación.
% -------------------------------------------------------------------------
% Calcular pendiente y ordenada en el origen
p=polyfit(X,Y,1);
m=p(1);
n=p(2);
% Calcular los errores de m y n
N=length(X);
suma1=0;
suma2=0;
for i=1:N
    suma1=suma1+(Y(i)-m*X(i)-n)^2;
end
for i=1:N
    suma2=suma2+(X(i)-mean(X))^2;
end
errorm=sqrt(suma1/((N-2)*suma2));
errorn=sqrt(((1/N)+(mean(X)^2/suma2))*(suma1/(N-2)));
%Barras de error de Y
erroresY=[];
for i=1:N
    erroresY(i)=sqrt(errorn^2+(((X(i)-mean(X))^2)*errorm^2));
end
%Coeficiente de correlacion r
suma3=0;
for i=1:N
    suma3=suma3+(Y(i)-mean(Y))^2;
end
r=m*sqrt(suma2/suma3);