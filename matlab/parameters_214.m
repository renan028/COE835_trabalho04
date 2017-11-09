clear; clc;
s = tf('s');

%Plant TF
kp = 2;
b0 = 1;
a1 = -2;
a0 = 1;
N = kp*(s+b0);
D = (s^2 + a1*s +a0);
y = N/D;

%Model TF
km = 1;
b0m = 2;
a1m = 4;
a0m = 1;
Nm = km*(s+b0m);
Dm = s^2+a1m*s+a0m;
ym = Nm/Dm;

%Observer
A0 = tf(1);

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