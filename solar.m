%(*) for changeable values
function V = solar(T_amb_discrete)
%% Assume solar panels run 8am-6pm
% T_amb_discrete = [10 13 16 19 23 24 22 20 17 14 10]; %discrete ambient temp 8am-6pm (*)
T_nominal(1:length(T_amb_discrete)) = 25;
hours = 8:18;
%% Parameters of PV module
Ns = 6; %number of panels in series (*)
Np = 5; %number of parallel panels (*)
Isc = 0.45*Np; %Short-circuit current 
Voc = 6*Ns; %Open-circuit voltage
dT = T_amb_discrete-T_nominal; %nominal and acutal temp difference
Ki = 0.0032; %current coefficient 
Kv = -0.1230; %voltage coefficient
a = 1; %diode ideality constant
Vt = Ns*0.026; %thermal voltage for N cells in series
Rs = 0.012*Ns; %series internal resistance
% Rp = ((1/22.769)*Np)^(-1); %parallel internal resistance
Io = (Isc+Ki*dT)./(exp((Voc+Kv*dT)/(a*Vt))-1); %diode saturation current
% Id = Io*(exp((I*Rs+V)/0.026)-1);
%% calculate Ipv, Vpv
Ipvn = 2.8; %light-generated current at nominal condition (Go = 1000 W/m^2)
g = 0.4539; %g = G/Gn (ratio of actual irradiation and nominal irradiation)(*)
Ipv = Np*((Ipvn + Ki*dT)*g);
Vpv = Ipv*Rs;
%% Output
I = Ipv-Io.*(exp(Vpv/(a*Vt))-1); %solar panel output current
R_fly = 1; %flywheel resistance
V = I*R_fly; %solar panel output voltage
figure(1);
plot(hours,V);
title('Solar panel output voltage from 8am-6pm');
xlabel('Time (hrs)');
ylabel('Output Voltage (V)');
end