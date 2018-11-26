function [endvalue] = Motor()
t = [0 3600*11-1];
IC = [0 0];
%Check solar_voltage_interp1.m for the system matrixs.
[t,y] = ode45(@solar_voltage_interp1,t,IC);

%Plot
figure;
subplot(1,2,1);
plot(t,y(:,1));
title('Motor Velocity Output');
xlabel('Time (s)');
ylabel('Angular Velocity');

subplot(1,2,2);
plot(t,y(:,2));
title('Motor Current Output');
xlabel('Time (s)');
ylabel('Current');
endvalue = [y(end,1) y(end,2)];
end
