clc;clear
% Algoritmo CoVID - MODELO DE HETHCOTE (Modelo SIR con muerte natural y por enfermedad)
% -------------------------------------------------------------------------
%   Modelo:
% --------  VARIABLES EMPLEADAS -------------------------------------------
%       N.-     poblaci�n total (voy a suponerla constante limitada a Espa�a)
%       I.-     poblaci�n contagiada
%       R.-     poblaci�n recuperada
%       S.-     poblaci�n susceptible de contagio
%       mu.-    �ndice de mortalidad natural
%       theta.- �ndice de mortalidad por enfermedad
%       beta.-  �ndice de transmisi�n =a/N
%       alpha.- tasa de recuperaci�n
% -------- SISTEMA DE ECUACIONES DIFERENCIALES QUE VAMOS A APROXIMAR -------
%   S'=mu*N-mu*S-a/N *S*I
%   I'=-mu*I+a/N *S*I-b*I
%   R'=-mu*R+b*I
%   S+R+I=N
% -------------------------------------------------------------------------
% DATOS EXTRAIDOS DE https://datosmacro.expansion.com/otros/coronavirus/espana
% -------------------------------------------------------------------------
N= 46934632; % Poblaci�n total eSPA�OLA
I0= 1; % Poblaci�n infectada inicial
R0= 0; %Pobralcion recuperada inicial
S0= N; % Poblaci�n susceptible inicial
M0= 0; % Fallecidos
theta= 0.0524;%Tasa de mortalidad por enfermedad (estimado por ajuste lineal)
mu= 0.0091; %Tasa de mortalidad natural
a= 0.326; beta=a/N;%�ndice de transmisi�n (estimado por ajuste de los datos exp.)
alpha= 0.0827; %Tasa de recuperaci�n (estimado por ajuste lineal)
% -------------------------------------------
S=[S0];
I=[I0];
R=[R0];
M=[M0];
t=[0];
for tiempo=1:100 % �ndice de tiempo para ajustar los d�as que han pasado desde el primer contagio
    I1=I0+beta*S0*I0-mu*I0-alpha*I0; % N�mero de infectados
        I=[I I1];
    R1=R0-mu*R0+alpha*I0-theta*alpha*I0; % N�mero de Recuperados
        R=[R R1];
    S1= S0-beta*S0*I0+mu*N-mu*S0+theta*alpha*I0; % N�mero de perosnas susceptibles
        S=[S S1];
    M1=theta*I0; % N�mero de fallecidos
        M=[M M1];
    epsilon=I1-I0;
    I0=I1;
    S0=S1;
    R0=R1;
    M0=M1;
    t=[t tiempo];
end
plot(t,I)
title('Modelo SIR End�mico (22-3-2020)')
xlabel('t (d�as desde el primer caso)')
ylabel(' Poblaci�n ')
    hold on
plot(t,R)
    hold on
% plot(t,S)    %<--- Muestra los casos susceptibles pero no es interesante plotearlo
%     hold on
plot(t,M)
    hold on
esp_cont=[1	1	1	1	1	1	1	1	2	2	2	2	2	2	2	2	2 ...
    2	2	2	2	2	2	6	13	15	32	45	84	150	198	237	365	400	500	...
    999	1622	2128	2950	4209	5232	6391	9191	11178	...
    13716	17147	19980	24926	28572]; % CONTAGIOS EN ESPA�A
dias=[1:length(esp_cont)]; % D�as desde el primer contagiado en espa�a
plot(dias,esp_cont, 'o')