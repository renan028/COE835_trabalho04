function [Pm] = calculate2DOFmodelTF(P, theta_1, theta_n, theta_2, theta_2n, L)

    %Extract transfer function properties
    function [n, n_star, num, den] = tfprop(y)
        [num,den] = tfdata(y,'v');
        num = num(find(num,1):end);
        den = den(find(den,1):end);
        n = length(den) - 1;
        n_star = n - (length(num) - 1);
    end
    %Customized convolution (removes first zero entries)
    function A = myconv(n,m)
        A = conv(n,m);
        A = A(find(A,1):end);
    end

%Get plant TF properties
[n, ~, N, D] = tfprop(P);
kp = N(1);
N = N/kp;

%Filters state space realization in controllable canonical form
Af = zeros(n-1);
Af(1:end-1,2:end) = eye(n-2);
Af(end,:) = -flip(L(2:end));
bf = zeros(n-1,1);
bf(end) = 1;
C1 = flip(theta_1);
C2 = flip(theta_2);
D1 = 0;
D2 = theta_n;

%Calculate F and G
[F,~] = ss2tf(Af,bf,C1,D1);
[G,~] = ss2tf(Af,bf,C2,D2);

%Calculate the num. and the two terms of the den. in the closed loop TF
Numerator = theta_2n*kp*myconv(L,N);
LmFD = myconv((L - F),D);
KpNG = kp*myconv(N,G);

%Add zero entries to make the 2 polynomials have the same order
l1 = length(LmFD);
l2 = length(KpNG);
if l1 > l2
    KpNG = [zeros(1,l1-l2) KpNG];
elseif l1 < l2
    LmFD = [zeros(1,l2-l1) LmFD];
end

%Calculate the den. in the closed loop TF
Dm = LmFD - KpNG;

%Find the model TF and cancel equal poles and zeros (with tolerance)
tol = 1e-5;
Pm = tf(Numerator,Dm);
Pm = minreal(Pm,tol);

%Eliminate infinitesimal differences
[num,den] = tfdata(Pm);
num = round(num{1},5);
den = round(den{1},5);

%Finally find the model TF
Pm = tf(num,den);

end