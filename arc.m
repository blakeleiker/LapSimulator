function [ t_arc, xo, vo ] = arc( xi, vi, r, theta, car  )
%ARC
% function mean for use in lap sim which simulates a constant radius arc.
%
% INPUTS:
% xo - [ft, ft] intital position vector
% vo - [ft/s, ft/s] initial velocity vector
% r - [ft] arc radius
% theta - [degrees] angle of arc
% car - struct containing car parameters
%
% OUTPUTS: 
% xo - [ft, ft] final position vector
% vi - [ft/s, ft/s] final velocity vector
% t_arc - [s] time elapsed during arc

V = sqrt(car.g_max*32.174*r); %[ft/s] (tangential velocity of the center of mass)

s = pi*r*2; %[ft] (total distance traveled around circle)

t_arc = s/V; %[s]

%% Calculate final velocity and position

Rz = @(a) [cosd(a) -sind(a) 0;
           sind(a) cosd(a)  0;
           0       0        1];
       
if theta <= 0
    turn = 'left';
elseif theta > 0
    turn = 'right';
end

theta = abs(theta);

Vi = V*vi/norm(vi);  %Find initial velocity vector, based upon max cornering speed and direction coming into the arc
Vi = [Vi(1); Vi(2); 0];

Xi = [xi(1); xi(2); 0];

if strcmp(turn,'right')
    Vo = Rz(-theta)*Vi;
    Xo = r*( Rz(90)*Vo/norm(Vo) - Rz(-90)*Vi/norm(Vi) ) + Xi;
elseif strcmp(turn,'left')
    Vo = Rz(theta)*Vi;
    Xo = r*( Rz(-90)*Vo/norm(Vo) - Rz(90)*Vi/norm(Vi) ) + Xi;
end

vo = [double(Vo(1)) double(Vo(2))];

xo = [double(Xo(1)) double(Xo(2))];

end

