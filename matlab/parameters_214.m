clear all
clc
s = tf('s');

% ------------- Input Parameters -------------
kp = 2;
b = 1;
a1 = -2;
a0 = 1;

N = kp*(s+b);
D = (s^2 + a1*s +a0);
y = N/D; % Plant

km = 1;
bm = 2;
a1m = 4;
a0m = 1;
Nm = km*(s+bm);
Dm = s^2+a1m*s+a0m;
ym = Nm/Dm; %Model

A0 = tf(1); % Creating A0

[theta_1, theta_n, theta_2n, theta_2, L] = diophantina(y,ym,A0);
theta_1s = bm-b; 
theta_ns = (a1-a1m)/kp;
theta_2ns = km/kp;
theta_2s = ((a0-a0m)-L(end)*(a1-a1m))/kp;