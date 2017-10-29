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

[num,den] = tfdata(y,'v');
index = find(den);
index = index(1);
n = length(den(index:end)) - 1;

index = find(num);
index = index(1);
n_star = n - (length(num(index:end)) - 1);

Nm = (s+1)^(n-n_star);
Dm = (s+2)^n;
ym = Nm/Dm; %Model

A0 = (s+1)^(n_star-1);
L = Nm*A0;
H = (s+1)^(n_star-1);
DmA0 = Dm*A0;
HD = H*D;
G = DmA0-HD;
