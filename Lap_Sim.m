%% LAP_SIM
% This script creates a rudimentary lap sim by accounting for the losses in
% lateral acceleration due to lateral load transfer. All the actual work is
% done inside of the function "Lap_Sim_fun.m". This script varies car
% parameters and analyzes their effect on slalom and skidpad times.

%% Define Car Parameters

car = car_struct();

Krr = car.spring_rate_rear*car.MR^2;
Krf = car.spring_rate_front*car.MR^2;


%% Calculate track width ratio 

tf = 48;

syms tr_sym

kf = 12*Krf*tf^2/2;
kr = 12*Krr*tr_sym^2/2;

H = car.h + (car.rc_front-car.rc_rear)*0.53 - car.rc_front;

eq = tf/tr_sym == 0.53/0.47 * (H*kf/(kf+kr) + 0.47*car.rc_front) / (H*kr/(kf+kr) + 0.53*car.rc_rear);

tr = vpa(solve(eq, tr_sym));
if length(tr) ~= 1
    tr = tr(2);
end
tftr_ratio = tf/tr;

kr = subs(kr, tr_sym, tr);
%% Calculate front and rear lateral load transfers (per g of acceleration)

WfAy = car.W/tf * ( H*kf/(kf+kr) + 0.47 * car.rc_front ); %[lb/g]
WrAy = car.W/tr * ( H*kr/(kf+kr) + 0.53 * car.rc_rear ); %[lb/g]

%% Calculate maximum lateral acceleration

g_max = g_calc(car, WfAy, WrAy, 44);

car.tf = tf;
car.tr = tr;
car.g_max = g_max;