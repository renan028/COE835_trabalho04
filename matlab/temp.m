clear all
clc
s = tf('s');

% ------------- Input Parameters -------------
kp = 1;
b0 = 1;
b1 = 1;
a2 = 1;
a1 = 1;
a0 = 1;

N = kp*(b1*s+b0);
D = (s^3 + a2*s^2 + a1*s +a0);
y = N/D; % Plant

km = 1;
b1m = 1;
b0m = 2;
a2m = 1;
a1m = 1;
a0m = 2;
Nm = km*(b1m*s+b0m);
Dm = (s^3 + a2m*s^2 + a1m*s +a0m);
ym = Nm/Dm; %Model

A0 = (s+3)^1; % Creating A0

[theta_1, theta_n, theta_2n, theta_2, L] = find2DOFparameters(y,ym,A0);