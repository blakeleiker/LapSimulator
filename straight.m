function [ t_straight, xo, vo ] = straight( xi, vi, car, L )
%STRAIGHT
% function meant for use in lap sim which simulates a straight. The premise
% behind this function is that it calculates both traction limited and
% power limited acceleration, as well as the transition point between
% traction and power limited. 
%
% INPUTS:
% xi - [ft, ft] initial position vector
% vi - [ft/s, ft/s] initial velocity vector
% car - structure containing car parameters
% L - [ft] length of the straight
%
% OUTPUTS:
% t_straight - [s] 
% xo - [ft, ft] final position vector
% vi - [ft/s, ft/s] final velocity vector

%% Define acceleration parameters

v1 = norm(vi); %[ft/s] magnitude of initial velocity
g = 32.174; %[ft/s2] 

%% Traction limited acceleration

mu = 1.8; % coefficient of friction, guesstimated from TTC data, gut instinct, and consulting with psychics
ax_TL = 0.53 * mu / (1-mu*car.h/car.l); %[g's] traction limited acceleration

%% Power limited acceleration

p_w = car.P_W*550; %[lb*ft/s/lb] Converts horsepower into correct units

a_g = @(t,v1) p_w.*(2*g*p_w.*t + v1^2).^-0.5; %[g's] power limited acceleration

%% Calculate velocity and displacement

t_t = (p_w/ax_TL^2-v1^2)/(g); %[s] time at which transition occurs between TLA and PLA

t = linspace(0,5,1000); %[s] time period over which calculations are done
v = zeros(1,length(t));
i_t = 0;
v2 = v1;
for i = 1:length(t)
   
    if t(i) < t_t  %traction limited
        t(i);
        v(i) = g * ax_TL * t(i) + v1;
        v2 = v(i);
        i_t = i;
    elseif t(i) >= t_t  %power limited
        v(i) = sqrt(2*g*p_w*t(i-i_t)+v2^2);
    end
    
end

d = cumtrapz(t,v);
figure(2)
plot(t, d)
title('displacement v time')
hold on;

%% Calculate time

x = d(1);
j = 1;
while x < L
    
    x = d(j);
    t_straight = t(j);
    j = j+1;
    
end

%% Calculate final position and velocity

direction = vi/norm(vi);

xo = xi + L*direction;
vo = v(j-1)*direction;

end
