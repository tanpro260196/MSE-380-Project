function [current_array] = Generator(velocity, maxcurrent)

global current_array_thermal;
%All the constant.
dt = 0.1;
final_t = 600;
t = 0:dt:final_t;
size(t)
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
current_array_thermal = current_array;
%Plot
figure;
plot(t,alpha,t, current_array);
xlim([0 35]);
title('Generator Output');
xlabel('Time (s)');
ylabel('Angular Velocity/Current');
legend('Angular Velocity','Current');
global y;
global thermal_output; 
t = [0 final_t];
IC2 = [0];
%Check solar_voltage_interp1.m for the system matrixs.
[t,y] = ode45(@heater,t,IC2);
% Plot. In our current state. The temp increase by about 8 degree.
temp_size = size(y);

thermal_output = [25];
for i = 0:temp_size(1)-2
    thermal_output = [thermal_output; 25+y(i+1)];
end
figure;
plot(t,thermal_output);
title('Heater T');
xlabel('Time (s)');
ylabel('T');
end
