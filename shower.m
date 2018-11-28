%Shower System
function y = shower(V)
rho = 994;
g = 9.81;
alpha = 2;
r_pipe = 0.0025;
A_Pipe = 3.14 * (r_pipe)^2;
deltaX = 5;
h0 = 0.1;
A_Tank = V/h0;

Cf = A_Tank/(rho*g);
If = alpha * rho * deltaX / A_Pipe;
Rf = 20;

A = [-Rf/If, 1/If; -1/Cf, 0];
B = [];
C = [0, 1/(rho * g)];
D = [];

u = [];
t = 0:1:250;
x0 = [A_Pipe * sqrt(2 * g * h0), rho * g * h0];

sys = ss(A,B,C,D);
y = lsim (sys,u,t,x0);
figure(6);
plot (t,y);
end
