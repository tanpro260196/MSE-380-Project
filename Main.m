clear;
close all;
clc;
global water_volume;

Motor_output = Motor();
Flywheel_current = Generator(Motor_output(1),Motor_output(2));
% show_outlet();
shower(water_volume);