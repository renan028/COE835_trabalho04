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

% --------------------------------------------

[numy,deny] = tfdata(y,'v');
index = find(deny);
index = index(1);
n = length(deny(index:end)) - 1;

index = find(numy);
index = index(1);
n_star = n - (length(numy(index:end)) - 1);

Nm = (s+1)^(n-n_star);
Dm = (s+2)^n;
ym = Nm/Dm; %Model
[numym,denym] = tfdata(ym,'v');

A0 = (s+1)^(n_star-1);
L = Nm*A0;
H = (s+1)^(n_star-1);
DmA0 = Dm*A0;
HD = H*D;
G = HD - DmA0;

[numG, ~] = tfdata(G,'v');
theta_n = numG(1);

[numL, ~] = tfdata(L,'v');
theta_2 = numG(2:end) - numL(2:end)*theta_n;

F = L - N*H;
[numF, ~] = tfdata(F,'v');
theta_1 = numF;

