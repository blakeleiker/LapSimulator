function [ ] = update_car(varargin)

global car;

fig = guidata(gcf);

%% update properties from edit box inputs
car.W = str2double(fig.ed(1).String);

%% update dependent properties

Krr = car.spring_rate_rear*car.MR^2;
Krf = car.spring_rate_front*car.MR^2;

%car.tf = 48; %[in] defined front track

syms tr_sym

kf = 12*Krf*car.tf^2/2;
kr = 12*Krr*tr_sym^2/2;

H = car.h + (car.rc_front-car.rc_rear)*0.53 - car.rc_front;

eq = car.tf/tr_sym == 0.53/0.47 * (H*kf/(kf+kr) + 0.47*car.rc_front) / (H*kr/(kf+kr) + 0.53*car.rc_rear);

tr = vpa(solve(eq, tr_sym));
if length(tr) ~= 1
    tr = tr(2);
end
tftr_ratio = car.tf/tr;
car.tr = double(tr);

kr = subs(kr, tr_sym, tr);

WfAy = car.W/car.tf * ( H*kf/(kf+kr) + 0.47 * car.rc_front ); %[lb/g]
WrAy = car.W/car.tr * ( H*kr/(kf+kr) + 0.53 * car.rc_rear ); %[lb/g]

car.g_max = g_calc(car, WfAy, WrAy, 44); % Calculate maximum possible lateral acceleration (4th parameter is car speed)

%% Reset text box colors

set(fig.ed(:),'BackgroundColor','white');

%% Output to message box

fig.message.String = ['Car Updated';fig.message.String];

end

