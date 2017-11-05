clear all
clc
s = tf('s');

% ------------- Input Parameters -------------
kp = 2;
a2 = 1;
a1 = -2;
a0 = 1;

N = kp;
D = (s^3 + a2*s^2 + a1*s +a0);
y = N/D; % Plant

km = 1;
a1m = 4;
a0m = 1;
Nm = km;
Dm = s^3 + a1m*s + a0m;
ym = Nm/Dm; %Model

A0 = (s+1)^2; % Creating A0

[theta_1, theta_n, theta_2n, theta_2] = diophantina(y,ym,A0);