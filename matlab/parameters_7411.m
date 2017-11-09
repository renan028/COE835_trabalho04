clear; clc;
s = tf('s');

%Plant TF
kp = 3;
b2 = 4;
b1 = 2;
b0 = 1;
a6 = 3;
a5 = 1;
a4 = -2;
a3 = 0;
a2 = 6;
a1 = -2;
a0 = 4;
N = kp*(s^3 + b2*s^2 + b1*s +a0);
D = (s^7 + a6*s^6 + a5*s^5 + a4*s^4 + a3*s^3 + a2*s^2 + a1*s +a0);
y = N/D;

%Model TF
km = 1.5;
b0m = 2;
a4m = 5;
a3m = 10.75;
a2m = 12.25;
a1m = 7;
a0m = 1.5;
Nm = km*(s + b0m);
Dm = s^5 + a4m*s^4 + a3m*s^3 + a2m*s^2 + a1m*s + a0m;
ym = Nm/Dm;

%Observer
A0 = (s+1)^3;

%Find 2DOF control parameters
[theta_1, theta_n, theta_2, theta_2n, L] = find2DOFparameters(y,ym,A0);

%Check the result
Pm = calculate2DOFmodelTF(y, theta_1, theta_n, theta_2, theta_2n, L);
[num,~] = tfdata(ym - Pm);
num = num{1};
if num == 0
    fprintf('Simulation successful!\n');
else
    fprintf('Simulation unsuccessful...\n');
end