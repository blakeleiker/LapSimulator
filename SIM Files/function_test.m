%% Function Test
% script for testing the arc, slalom, and straight functions

if ~exist('car','var')
    car = car_struct();
end

xi = [0 0];
vi = [1 0];

test = 'straight'; % adjust tested function with this parameter ('arc' 'slalom' or 'straight')

if strcmp(test,'arc')
%% ARC

r = 1; %[ft]
theta = -90; %right turn around 45 degrees of arc

[t_arc, xo, vo] = arc(xi, vi, r, theta, car) %make sure that car.g_max has been properly defined

plot(xi(1),xi(2),'*',xo(1),xo(2),'*')

elseif strcmp(test,'slalom')
%% SLALOM

d = 10; %[ft]
num = 2;
car_position_i = 'above';

[t_slalom, xo, vo, car_position_o] = slalom(xi, vi, d, num, car, car_position_i)


elseif strcmp(test,'straight')
%% STRAIGHT 

L = 50; %[ft]

[t_straight, xo, vo] = straight(xi, vi, car, L)

end