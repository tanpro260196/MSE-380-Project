workspace;
clear;
close;
clc;

%voltage_from_solar = [11 10 9 8 7 6 5 4 3 2 1];

Motor_output = Motor();
Flywheel_current = Generator(Motor_output(1),Motor_output(2));