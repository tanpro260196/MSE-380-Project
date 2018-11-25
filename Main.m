workspace;
global thermal;
clear;
clc;
%Assuming solar output a constant voltage.
T_amb_discrete = [10 13 16 19 23 24 22 20 17 14 10];
voltage_from_solar = solar(T_amb_discrete); %output voltage from solar panel circuit
%voltage_from_solar = [11 10 9 8 7 6 5 4 3 2 1];
Motor_output = Motor(voltage_from_solar,50);
Flywheel_current = Generator(Motor_output(1),Motor_output(2));