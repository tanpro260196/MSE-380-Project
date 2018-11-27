function h = show_outlet()
clear;
clc;
rho = 994;
tube_diameter = 0.02;
tube_cross_section = 3.14*(tube_diameter/2)^2;
tube_length = 1;
I = (rho*tube_length)/tube_cross_section;
tank_area = 0.075;
Cg = tank_area/(rho*9.81);
R = 1;




A=[0 -1/Cg
    1/I -R/I];
B = [0 0
    0 0];
C = [1/(rho*9.81) 0];
D = [0 0];




shower = ss(A,B,C,D);
dt = 0.1;
final_t = 600;
t = 0:dt:final_t;
n=final_t/dt;
u(1:2,1:n+1) = 0;
IC = [0.8*rho*9.81 tube_cross_section*sqrt(2*9.81*0.8)]

P10 = lsim(shower,u,t,IC);

figure;
plot(t,P10);
title('Shower Outlet');
end

