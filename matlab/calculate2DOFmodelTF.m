function [Pm] = calculate2DOFmodelTF(P, theta_1, theta_n, theta_2n, theta_2, L)
s = tf('s');

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
[n, n_star, N, D] = tfprop(P);
kp = N(1);
N = N/kp;

%Filter canonical state space realization
Af = zeros(n-1);
Af(1:end-1,2:end) = eye(n-2);
Af(end,:) = -flip(L(2:end));

bf = zeros(n-1,1);
bf(end) = 1;

%Filters
C1 = theta_1;
D1 = 0;
C2 = theta_2;
D2 = theta_n;

% Calculate F, G and Lambda
[F,Lambda1] = ss2tf(Af,bf,C1,D1);
[G,Lambda2] = ss2tf(Af,bf,C2,D2);

Nm = theta_2n*kp*myconv(L,N);
LmFD = myconv((L - F),D);
KpNG = kp*myconv(N,G);

l1 = length(LmFD);
l2 = length(KpNG);

if l1 > l2
    KpNG = [zeros(1,l1-l2) KpNG];
elseif l1 < l2
    LmFD = [zeros(1,l2-l1) LmFD];
end

Dm = LmFD - KpNG;
Pm = tf(Nm,Dm);
Pm = minreal(Pm);

end