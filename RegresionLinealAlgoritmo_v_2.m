% --------------------------------------------------
% Regresion lineal de una serie de datos
% --------------------------------------------------
% Para cada caso hay que variar parte del código
% Datos necesarios: 
%    -- Nombre de la regresión, Magnitudes y Unidades.
%    -- Valores del eje X y del eje Y;
%    -- Valor de los errores del eje X
% --------------------------------------------------
clc
clear
% --------------------------------------------------
% --------  VALORES NECESARIOS ---------------------
% --------------------------------------------------
       TITULO='Péndulo físico';
       MagnitudX=' D^2 ';
       UnidadX=' (cm^2) ';
                                                                            MagnitudUnidadX=[MagnitudX UnidadX];
       MagnitudY=' D*T^2 ';
       UnidadY=' (cm*s^2) ';
                                                                            MagnitudUnidadY=[MagnitudY UnidadY];
       X=       [25 49 100 144 225 289 400 484];
       Y=       [5.63922 7.984368 11.55625 14.414592 18.183015 22.4825 36.992 66.148632];
       erroresX=[0 0 0 0 0 0 0 0];
%---------------------------------------------------
%---------------------------------------------------
%---------------------------------------------------
% Implementación de la función:
[m,n,errorm,errorn,erroresY,r]=regresionlineal(X,Y);
% Gráfica de regresión
    %Recta de regresión
hold on
g=min(X)-min(X);
h=max(X)+max(X); % Para alargar un poco la recta tomamos un valor "h" un 10% mayor al punto máximo
xcoord=[g,h];
ycoord=[g*m+n,h*m+n];
plot(xcoord,ycoord)
grid on
    %Puntos y Barras de error
errorbar(X,Y,erroresY,erroresY,erroresX,erroresX,' .k')
title(TITULO)
xlabel(MagnitudUnidadX)
ylabel(MagnitudUnidadY)
% Redondeo de los errores
[errorm,contador1m,contador2m]=redondeaerror(errorm);
[errorn,contador1n,contador2n]=redondeaerror(errorn);
for i=1:length(erroresY)
    erroresY(i)=redondeaerror(erroresY(i));
end
% Redondeo de las magnitudes
    % Redondeo de la pendiente
if contador1m>0
    for i=1:contador1m
        m=m*10;
    end
    m=round(m);
    for i=1:contador1m
        m=m/10;
    end
else
    for i=1:(contador2m-1)
        m=m/10;
    end
    m=round(m);
    for i=1:(contador2m-1)
        m=m*10;
    end
end
    % Redondeo de la ordenada
if contador1n>0
    for i=1:contador1n
        n=n*10;
    end
    n=round(n);
    for i=1:contador1n
        n=n/10;
    end
else
    for i=1:(contador2n-1)
        n=n/10;
    end
    n=round(n);
    for i=1:(contador2n-1)
        n=n*10;
    end
end    
    % Crear leyenda. Convertir datos a variables STRING de caracteres
pend=num2str(m);
ord=num2str(n);
if n<0
    recta=[MagnitudY ' = ' pend '*' MagnitudX ord];
else
    recta=[MagnitudY ' = ' pend '*' MagnitudX '+' ord];
end
coefcorr=['r^2=' num2str(r^2)];
datosgrafica={recta, coefcorr};
annotation('textbox', [0.6, 0.06, 0.2, 0.2],'String',datosgrafica,'FitBoxToText','on','BackgroundColor','white')
hold off
% String nº de decimales
    %Pendiente
    penddec=num2str(contador1m);
    resultadopendiente=['La pendiente es m = %.' penddec 'f \n'];
    resultadoerrorpend=['El error de m es +-%.'  penddec 'f \n'];
    %Ordenada
    orddec=num2str(contador1n);
    resultadoordenada=['La ordenada es n = %.' orddec 'f \n'];
    resultadoerrorord=['El error de n es +-%.' orddec 'f \n'];
% Muestra de resultados:
disp('----------------------------------')
disp(['REGRESIÓN LINEAL: ' TITULO])
disp('LOS DATOS SE APORTAN REDONDEADOS')
disp('----------------------------------')
fprintf(resultadopendiente,m)
fprintf(resultadoordenada,n)
fprintf(resultadoerrorpend,errorm)
fprintf(resultadoerrorord,errorn)
fprintf('El coeficiente de correlación es r^2 = %f \n',r^2)
fprintf('Los errores en el eje Y son: \n')
disp(erroresY)
disp('----------------------------------')
disp('----------------------------------')
% disp('DATOS PARA EXCEL')
% pendnombre=['m | %.' penddec 'f \n'];
% ordnombre=['n |%.' orddec 'f \n'];
% corrnombre=['r | %' 'f \n'];
% errorpendnombre=['Delta m  | %' penddec 'f \n'];
% errorordnombre=['Delta n  | %' orddec 'f \n'];
% fprintf(pendnombre, m)
% fprintf(errorpendnombre, errorm)
% fprintf(ordnombre, n)
% fprintf(errorordnombre, errorn)
% fprintf(corrnombre,r)
% disp('----------------------------------')
