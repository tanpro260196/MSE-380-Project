function [endvalue] = Motor()
t = [0 11-1]; %time span
IC = [0 0]; %initial condition
%Check solar_voltage_interp1.m for the system matrices.
[t,y] = ode45(@solar_voltage_interp1,t,IC);

%Plot
figure(2);
subplot(1,2,1);
plot(t,y(:,1));
title('Motor Velocity Output');
xlabel('Time (h)');
ylabel('Angular Velocity (rad/s)');

subplot(1,2,2);
plot(t,y(:,2));
title('Motor Current Output');
xlabel('Time (h)');
ylabel('Current (A)');
endvalue = [y(end,1) y(end,2)];
end