global thermal;
%Assuming solar output a constant voltage.
voltage_from_solar = linspace(10,0,500);
Motor_output = Motor(voltage_from_solar,20);
Flywheel_current = Generator(Motor_output(1),Motor_output(2));