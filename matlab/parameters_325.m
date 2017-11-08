clear all
clc
s = tf('s');

% ------------- Input Parameters -------------
kp = 2;
b0 = 1;
a2 = 1;
a1 = -2;
a0 = 1;

N = kp*(s+b0);
D = (s^3 + a2*s^2 + a1*s +a0);
y = N/D; % Plant

km = 1;
a1m = 4;
a0m = 1;
Nm = km;
Dm = s^2 + a1m*s + a0m;
ym = Nm/Dm; %Model

A0 = (s+1)^1; % Creating A0

[theta_1, theta_n, theta_2n, theta_2, L] = find2DOFparameters(y,ym,A0);

l0 = L(end);
l1 = L(end-1);

h0 = l0 + l1 + a1m - a2;
g2 = (a1+a2*(l0 + l1 +a1m-a2)-l0*l1-a1m*(l0 + l1)-a0m)/kp;
g1 = (a0+a1*(l0 + l1 +a1m-a2)-a1m*l0*l1-a0m*(l0 + l1))/kp;
g0 = (a0*(l0 + l1+a1m-a2)-a0m*l0*l1)/kp;
G = [g2 g1 g0];

%Check result
Pm = calculate2DOFmodelTF(y, theta_1, theta_n, theta_2n, theta_2, L);