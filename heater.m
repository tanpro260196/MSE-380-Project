function dx = heater(t,x)
%Constant for thermal system
global current_array_thermal;
dt = 0.005;
final_t = 3000;
t1 = 0:dt:final_t;
R = 150;
c_water = 4.18;
density_water = 997;
water_volume = 0.0651;
c_t = water_volume*density_water*c_water;

%Calculate heat flow array. It will be the input.
q = (current_array_thermal.^2 * R)'.*t;
u = interp1 (t1,q,t,'spline');
%Setup system matrices
AA=[-0.25/c_t];
BB = [1/c_t];
CC = [1];
DD = 0;

dx = AA*x + BB*u;
end

