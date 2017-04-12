%% Function Test
% script for testing the arc, slalom, and straight functions

car = car_struct();

xi = [0 0];
vi = [1 0];

%% ARC

r = 1;
theta = -90; %right turn around 45 degrees of arc

[t_arc, xo, vo] = arc(xi, vi, r, theta, car)

plot(xi(1),xi(2),'*',xo(1),xo(2),'*')

%% SLALOM 




%% STRAIGHT 