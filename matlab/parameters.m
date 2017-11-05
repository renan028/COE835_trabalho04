clear all
clc
s = tf('s');

% ------------- Input Parameters -------------
bp1 = 1;
bp2 = 2;
ap1 = -2;
ap0 = 1;

N = (bp1*s+bp2);
D = (s^2 + ap1*s +ap0);
y = N/D; % Planta


Nm = (s+1);
Dm = (s+2)^2;
ym = Nm/Dm; %Model

[theta_1, theta_n, theta_2n, theta_2] = diophantina(y,ym);