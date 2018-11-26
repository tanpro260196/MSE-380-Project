function [current_array] = Generator(velocity, maxcurrent)
%All the constant.
dt = 0.005;
final_t = 35;
t = 0:dt:final_t;
n=final_t/dt;
J = 0.01;
b = 0.001;
K = 0.01;
R = 0.1;
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
R = 150;
c_copper = 385;
m = 0.5;
c_water = 4.18;
density_water = 997;
water_volume = 0.0651;
c_t = water_volume*density_water*c_water;

%Calculate heat flow array. It will be the input.
q = (current_array.^2 * R)'.*t;
%Setup system matrices
AA=[0];
BB = [1/c_t];
CC = [1];
DD = 0;
thermal_ss = ss(AA,BB,CC,DD);
%Assume Initial temp is 25
IC2 = [25];
global thermal;
thermal = lsim(thermal_ss,q,t,IC2);


max_t = max(thermal);

% Plot. In our current state. The temp increase by about 0.6 degree.
figure;
plot(t,thermal);
title('Heater T');
xlabel('Time (s)');
ylabel('T');
end
