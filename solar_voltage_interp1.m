function dx = solar_voltage_interp1(t,x)
T_amb_discrete = [10 13 16 19 23 24 22 20 17 14 10];
V = solar(T_amb_discrete); %output voltage from solar panel circuit
%All the constant
J = 0.01;
b = 0.01;
K = 0.01;
R = 4;
L = 0.5;
hours = 0:1:length(V)-1;

%Interpret V into curve?
u = interp1 (hours,V,t/3600,'spline');

%System Matrices
A = [-b/J   K/J
    -K/L   -R/L];
B = [0
    1/L];
C = [1   1];
D = 0;

%Output system
dx = A*x + B*u;
end