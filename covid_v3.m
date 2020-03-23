clc;clear
% Algoritmo CoVID - MODELO DE HETHCOTE (Modelo SIR con muerte natural y por enfermedad)
% -------------------------------------------------------------------------
%   Modelo:
% --------  VARIABLES EMPLEADAS -------------------------------------------
%       N.-     población total (voy a suponerla constante limitada a España)
%       I.-     población contagiada
%       R.-     población recuperada
%       S.-     población susceptible de contagio
%       mu.-    índice de mortalidad natural
%       theta.- índice de mortalidad por enfermedad
%       beta.-  índice de transmisión =a/N
%       alpha.- tasa de recuperación
% -------- SISTEMA DE ECUACIONES DIFERENCIALES QUE VAMOS A APROXIMAR -------
%   S'=mu*N-mu*S-a/N *S*I
%   I'=-mu*I+a/N *S*I-b*I
%   R'=-mu*R+b*I
%   S+R+I=N
% -------------------------------------------------------------------------
% DATOS EXTRAIDOS DE https://datosmacro.expansion.com/otros/coronavirus/espana
% -------------------------------------------------------------------------
N= 46934632; % Población total eSPAÑOLA
I0= 1; % Población infectada inicial
R0= 0; %Pobralcion recuperada inicial
S0= N; % Población susceptible inicial
M0= 0; % Fallecidos
theta= 0.0524;%Tasa de mortalidad por enfermedad (estimado por ajuste lineal)
mu= 0.0091; %Tasa de mortalidad natural
a= 0.326; beta=a/N;%Índice de transmisión (estimado por ajuste de los datos exp.)
alpha= 0.0827; %Tasa de recuperación (estimado por ajuste lineal)
% -------------------------------------------
S=[S0];
I=[I0];
R=[R0];
M=[M0];
t=[0];
for tiempo=1:100 % índice de tiempo para ajustar los días que han pasado desde el primer contagio
    I1=I0+beta*S0*I0-mu*I0-alpha*I0; % Número de infectados
        I=[I I1];
    R1=R0-mu*R0+alpha*I0-theta*alpha*I0; % Número de Recuperados
        R=[R R1];
    S1= S0-beta*S0*I0+mu*N-mu*S0+theta*alpha*I0; % Número de perosnas susceptibles
        S=[S S1];
    M1=theta*I0; % Número de fallecidos
        M=[M M1];
    epsilon=I1-I0;
    I0=I1;
    S0=S1;
    R0=R1;
    M0=M1;
    t=[t tiempo];
end
plot(t,I)
title('Modelo SIR Endémico (22-3-2020)')
xlabel('t (días desde el primer caso)')
ylabel(' Población ')
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
    13716	17147	19980	24926	28572]; % CONTAGIOS EN ESPAÑA
dias=[1:length(esp_cont)]; % Días desde el primer contagiado en españa
plot(dias,esp_cont, 'o')