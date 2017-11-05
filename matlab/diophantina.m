function [theta_1, theta_n, theta_2n, theta_2] = diophantina(y,ym)
s = tf('s');
    function [n, n_star, num, den] = tfprop(y)
        [num,den] = tfdata(y,'v');
        index = find(den);
        index = index(1);
        n = length(den(index:end)) - 1; % calculating n

        index = find(num);
        index = index(1);
        n_star = n - (length(num(index:end)) - 1); % calculating n_star
    end 


[n, n_star, numy, deny] = tfprop(y);
index = find(numy);
index = index(1);
kp = numy(index); % Calculating kp

[m, ~, ~,~] = tfprop(ym);

if n>m
    ym = ym*((s+1)^(n-m))/((s+1)^(n-m));
end
[~, ~, numym, denym] = tfprop(ym);
index = find(numym);
index = index(1);
km = numym(index); % Calculating km

A0 = (s+1)^(n_star-1); % Creating A0
[A0,~] = tfdata(A0,'v');

L = conv(numym,A0); % Creating Lambda
DmA0 = conv(denym, A0);

degH = n_star-1; 
degG = n-1;

A = convmtx(deny',degH+1);
S = zeros(n_star + n, n_star + n);
S(1:degG+1,1:degG+1) = -kp*eye(degG+1);
B = [A S];
HG = B\DmA0';
H = HG(1:degH+1);
G = HG(degH+2:end);

theta_n = G(1);
theta_2 = G(2:end) - L(2:end)*theta_n;

F = L - conv(numy,H);
theta_1 = F;
theta_2n = km/kp;
end

