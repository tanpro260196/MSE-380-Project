function [current_array] = Generator(acceleration, maxcurrent)
dt = 0.01;
final_t = 3.5;
t = 0:dt:final_t;
n=final_t/dt;
J = 0.01;
b = 0.1;
K = 0.01;
R = 1;
L = 0.5;
s = tf('s');
P_motor = K/((J*s+b)*(L*s+R)+K^2);

A = [-b/J   K/J
     K/L   -R/L];
B = [0
     0];
C = [1   0];
C_prime = [0 1];
D = 0;
alpha_ss = ss(A,B,C,D);
current_ss = ss(A,B,C_prime,D);
u(1:1,1:n+1) = 0;
IC = [acceleration*final_t maxcurrent];

alpha = lsim(alpha_ss,u,t,IC);
current_array = lsim(current_ss,u,t,IC);
figure;
plot(t,alpha,t, current_array);
title('Motor/Generator Output');
xlabel('Time (s)');
ylabel('Angular Acceleration/Current');
legend('Angular Acceleration','Current');
end
