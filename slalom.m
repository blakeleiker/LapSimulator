function [ t_slalom, xo, vo, car_position_o ] = slalom( xi, vi, d, num, car, car_position_i )
%SLALOM
% function meant for use in lap sim which simulates a slalom.
%
% INPUTS:
% xi - [ft, ft] initial position vector
% vi - [ft/s, ft/s] initial velocity vector
% d - [ft] distance between cones
% num - number of cones
% car - struct containing car parameters
% car_position_i = [string] if the car starts the slalom above the cone -
% 'above'; if the car starts below the car - 'below'
% 
% OUTPUTS:
% xo - [ft, ft] final position vector
% vo - [ft/s, ft/s] final velocity vector
% t_slalom - [s] time elapsed during slalom
% car_position_o = [string] if the car ends the slalom above the cone -
%                  'above'; if the car ends below the car - 'below'

R = (0.5*car.tf + 0.5*4.5 + 3)/12; %[in] radius of sine wave, equal to 1/2 track + 1/2 tire + 1/2 cone

x = linspace(0, (num-1)*d, 100);
y = R*cos(pi/d*x);
dydx = -R*pi/d*sin(pi/d*x);
d2ydx2 = -R*pi^2/d^2*cos(pi/d*x);

s = cumtrapz( x, sqrt(1 + dydx.^2) ); %[in] arc length along sine wave
r = abs( (1+dydx.^2).^(3/2) ./ d2ydx2 ); %[in] radius of curvature along sine wave
r = r(1);

v = sqrt( car.g_max*32.174 * r ); %[ft/s] tangential velocity along curve

t_slalom = s(length(x))/12/v;

if strcmp(car_position_i,'above')
    car_position_o = 'below';
elseif strcmp(car_position_i,'below')
    car_position_o = 'above';
end

if mod(num,2) == 0
    if strcmp(car_position_i, 'above')
        dy = -2*R;
    elseif strcmp(car_position_i, 'below')
        dy = 2*R;
    end
elseif mod(num,2) == 1
    dy = 0;
end

car_direction = vi / abs(vi); % rank deficient?

vo = vi;
xo = xi + d*(num-1)*car_direction + dy*[-vi(2), vi(1)]/norm([-vi(2), vi(1)]);
% ROTATION OF XO TO DIRECTION OF V NEEDS TO BE IMPLEMENTED

% I HAVE NO IDEA IF THIS WORKS; NEEDS TESTING (WITH VISUALIZATION) BEFORE USING IN LAP SIM

end

