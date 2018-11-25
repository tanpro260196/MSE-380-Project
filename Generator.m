function [current_array] = Generator(velocity, maxcurrent)
%All the constant.
dt = 0.005;
final_t = 10;
t = 0:dt:final_t;
n=final_t/dt;
J = 0.01;
b = 0.01;
K = 0.01;
R = 1;
L = 0.5;

%System Matrices
A = [-b/J   0
     K/L   -R/L];
B = [0
     0];
C = [1   0];
C_prime = [0 1];
D = 0;

%Setup State Space Sys
alpha_ss = ss(A,B,C,D);
current_ss = ss(A,B,C_prime,D);

%Since the input is part of the state var. This system does not need any
%input.
u(1:1,1:n+1) = 0;
%Set Initial Condition
IC = [velocity maxcurrent];

%Solve the state space system
alpha = lsim(alpha_ss,u,t,IC);
current_array = lsim(current_ss,u,t,IC);
%Plot
figure;
plot(t,alpha,t, current_array);
title('Generator Output');
xlabel('Time (s)');
ylabel('Angular Velocity/Current');
legend('Angular Velocity','Current');

%Constant for thermal system
R = 1000;
c_copper = 385;
m = 0.5;
c_water = 4.18;
density_water = 997;
water_volume = 1;
c_t = water_volume*density_water*c_water;

%Calculate heat flow array. It will be the input.
q = (current_array.^2 * R)'.*t;
%Setup system matrices
AA=[0];
BB = [1];
CC = [1/c_t];
DD = 0;
thermal_ss = ss(AA,BB,CC,DD);
%Assume Initial temp is 0
IC2 = [0];
global thermal;
thermal = lsim(thermal_ss,q,t,IC2);

%Because initial temp is. Max_t is also delta T.
max_t = max(thermal);

% Plot. In our current state. The temp increase by about 0.6 degree.
figure;
plot(t,thermal);
title('Heater Delta T');
xlabel('Time (s)');
ylabel('Delta T');
end
