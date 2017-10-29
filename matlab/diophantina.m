s = tf('s');

% ------------- Input Parameters -------------
bp1 = 1;
bp2 = 1;
ap1 = 2;
ap0 = 1;

% --------------------------------------------

y = (b1*s+b2)/(s^2 + a1*s +a0); % Planta
[num,den] = tfdata(y);
n = length(nonzeros(den{1}));
n_star = length(nonzeros(num{1})) - n;

ym = 1/(s+1)^n_star;

A0 = (s+1)^(n_star-1);



