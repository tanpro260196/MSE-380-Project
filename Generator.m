function [current_array] = Generator(velocity, maxcurrent)
dt = 0.01;
final_t = 10;
t = 0:dt:final_t;
n=final_t/dt;
J = 0.01;
b = 0.01;
K = 0.01;
R = 1;
L = 0.5;
s = tf('s');
P_motor = K/((J*s+b)*(L*s+R)+K^2);

A = [-b/J   0
     K/L   -R/L];
B = [0
     0];
C = [1   0];
C_prime = [0 1];
D = 0;
alpha_ss = ss(A,B,C,D);
current_ss = ss(A,B,C_prime,D);
u(1:1,1:n+1) = 0;
IC = [velocity maxcurrent];

alpha = lsim(alpha_ss,u,t,IC);
current_array = lsim(current_ss,u,t,IC);
figure;
plot(t,alpha,t, current_array);
title('Generator Output');
xlabel('Time (s)');
ylabel('Angular Velocity/Current');
legend('Angular Velocity','Current');


R = 1000;
c_copper = 385;
m = 0.5;
c_water = 4.18;
density_water = 997;
water_volume = 1;
c_t = water_volume*density_water*c_water;
q = (current_array.^2 * R)'.*t;
AA=[0];
BB = [1];
CC = [1/c_t];
DD = 0;
thermal_ss = ss(AA,BB,CC,DD);
IC2 = [0];
global thermal;
thermal = lsim(thermal_ss,q,t,IC2);
max_t = max(thermal)
figure;
plot(t,thermal);
title('Heater Delta T');
xlabel('Time (s)');
ylabel('Delta T');
end
