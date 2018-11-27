function dx = heater(t,x)
%Constant for thermal system
global current_array_thermal;
global water_volume;
dt = 0.1;
final_t = 600;
t1 = 0:dt:final_t;
R = 150;
c_water = 4.18;
density_water = 997;
water_volume = 0.0651;
c_t = water_volume*density_water*c_water;
k = 0.011;
area = 0.36;
thickness = 0.002;
R_k = thickness/(k*area);

%Calculate heat flow array. It will be the input.
q = (current_array_thermal.^2 * R)'.*t;
u = interp1 (t1,q,t,'spline');
%Setup system matrices
AA=[(-0.25/c_t)-(1/(c_t*R_k))];
BB = [1/c_t];

dx = AA*x + BB*u;
end

