function [maxvalues] = Motor(voltage_from_solar, t_final)
%MOTOR_FUNCTION Summary of this function goes here
%   Detailed explanation goes here

%voltage_from_solar = linspace(10,0,500);
array_size = size(voltage_from_solar);
%t_final = 5;
dt = t_final/(array_size(2)-1);

t = 0:dt:t_final;
n=round(t_final/dt,0);
m_fly = 2;
J = m_fly*4e-2;
b = 0.05;
K = 0.01;
R = 5;
L = 0.5;
s = tf('s');
P_motor = K/((J*s+b)*(L*s+R)+K^2);

A = [-b/J   K/J
    -K/L   -R/L];
B = [0
    1/L];
C = [1   0];
C_prime = [0 1];
D = 0;
motor_ss = ss(A,B,C,D);
generator_ss = ss(A,B,C_prime,D);
%Input is voltage from Solar.
u(1:1,1:n+1) = voltage_from_solar;
IC = [0 0];
alpha = lsim(motor_ss,u,t,IC);
current = lsim(generator_ss,u,t,IC);
maxvalues = [max(alpha(:)) max(current(:))];
figure;
plot(t,alpha,t, current);
title('Motor Output');
xlabel('Time (s)');
ylabel('Angular Velocity/Current');
legend('Angular Velocity','Current');
end
