% ----------------------------------------------------
% REDONDEO DE ERRORES
% ----------------------------------------------------
% Función que redondea la cifra dada según los criterios de redondeo de
% errores.
% ----------------------------------------------------
function [error,contador1,contador2]=redondeaerror(cifra)
% ----------------------------------------------------
% error:     -Valor del error redondeado
% contador1: -Nº de cifras decimales hasta la última cifra significativa
% contador2: -Nº de cifras enteras
% ----------------------------------------------------
% Variables
entero=floor(cifra);
contador1=0;
contador2=0;
% Comprobar si el número tiene parte entera y si no la tiene correr la coma
while entero==0
    cifra=cifra*10;
    entero=floor(cifra);
    contador1=contador1+1;
end
% Comprobar su la parte entera no tiene más de una cifra y correr la coma
while entero>=10
    cifra=cifra/10;
    entero=floor(cifra);
    contador2=contador2+1;
end
% Proceso de redondeo con las normas pertinentes
if entero==1
    %Redondear a la décima
    cifra=cifra*10;
    contador1=contador1+1;
    if cifra-floor(cifra)==0
        error=round(cifra);
    else
        error=ceil(cifra);
    end
elseif entero==2
    %Redondear a la décima si es menor o igual que 4
    decima=cifra-entero;
    if decima<=0.4
        cifra=cifra*10;
        contador1=contador1+1;
    if cifra-floor(cifra)==0
        error=round(cifra);
    else
        error=ceil(cifra);
    end
    else
    %Redondear al entero si es mayor que 4
    if cifra-floor(cifra)==0
        error=round(cifra);
    else
        error=ceil(cifra);
    end
    end
else
    %Redondear al entero
    if cifra-floor(cifra)==0
        error=round(cifra);
    else
        error=ceil(cifra);
    end
end
%Deshacer las multiplicaciones y divisiones
for i=1:contador1
    error=error/10;
end
for j=1:contador2
    error=error*10;
end
% Ajustar valores de los contadores
contador2=contador2+1;
if contador2>0 && error-floor(error)==0
    contador1=0;
end
    