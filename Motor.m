function [endvalue] = Motor(voltage_from_solar, t_final)


%All the constant
m_fly = 1;
J = 0.01;
b = 0.01;
K = 0.01;
R = 4;
L = 0.5;

%System Matrices
A = [-b/J   K/J
    -K/L   -R/L];
B = [0
    1/L];
C = [1   0];
C_prime = [0 1];
D = 0;

%Setup State Space
alpha_ss = ss(A,B,C,D);
current_ss = ss(A,B,C_prime,D);


%Since the input is an array with 11 value of voltage during the time of 11
%hours. I will run the state space system with each value for 1 hours and
%combine them all in a big array.
dt = 0.005;
%Get the size of the input array
array_size = size(voltage_from_solar);
%Initializing all vars.
alpha = [0];
current = [0];

for i= 1:array_size(2)
    n = 3600/dt;
    %Input is voltage from Solar.
    u(1:1,1:n+1) = voltage_from_solar(i);
    IC = [alpha(end) current(end)];
    alpha = [alpha; lsim(alpha_ss,u,0:dt:3600,IC)];
    current = [current; lsim(current_ss,u,0:dt:3600,IC)];
end
%Grab value at the end of each array and put them in the output.
endvalue = [alpha(end) current(end)];

%Calculate the time array to plot.
result_size = size(alpha);
t_final = (result_size-1) * dt;
t = 0:dt:t_final;

%Plot
figure;
title('Motor Output');
subplot(1,2,1);
plot(t,alpha);
title('Motor Output');
xlabel('Time (s)');
ylabel('Angular Velocity');

subplot(1,2,2);
plot(t, current);
title('Motor Output');
xlabel('Time (s)');
ylabel('Current');
end
