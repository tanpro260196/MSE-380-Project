
clear;
clc;
rho = 994;
Cg = 0.075/(rho*9.81);



A = -1/Cg;
B = 0;
C = 1/(rho*9.81);
D = 0;

sys(A,B,C,D)
IC = 7800;
t = 0:100:1000;
n = 1000/100;
u(1:1,1:n+1) = 0;


figure;
plot(t,y);