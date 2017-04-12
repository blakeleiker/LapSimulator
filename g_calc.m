function [ g ] = g_calc( car, WfAy, WrAy, v )
%G_CALC
% Function which calculates the lateral acceleration in g's based upon the
% tire data and lateral load transfer data of the car.
%
% INPUTS:
% car - struct containing car parameters
% WfAy - [lbs/g] lateral load transfer per g of lateral acceleration in
% front
% WrAy - [lbs/g] lateral load transfer per g of lateral acceleration in
% rear
% v - [ft/s] car velocity
%
% OUTPUTS:
% g - [g's] maximum lateral acceleration

%% Define function which maps FZ -> FY

FZtoFY = @(FZ) 2.964655776397513*FZ - 0.002523614906832*FZ^2;   %function obtained from modeling TTC data; see LC0 analysis

%% Calculate normal load due to aero

v_mph = v * 0.681818; %[mph]

aero = 0.0623*v_mph^2 + 0.0101*v_mph; %this equation comes from 2016's wind
% tunnel data on the full car. It most likely overestimates the downforce 
% the car will feel because the data was taken in wind tunnel conditions 
% rather than on track.

%% Iteratively solve for lateral acceleration

g = 1; %[g's, mother fucker]  (initial guess of lateral acceleration)
g1 = 2; %[g's] (initialization of calculated g value)

while abs(g - g1) > 0.001
    
    FZ_fl = 0.5*car.W*0.47 + WfAy*g + aero; %These forces assume the car is turning right, so the left side is gaining normal load.
    FZ_fr = 0.5*car.W*0.47 - WfAy*g + aero;
    FZ_rl = 0.5*car.W*0.53 + WfAy*g + aero;
    FZ_rr = 0.5*car.W*0.53 - WfAy*g + aero;
    
    FY_fl = FZtoFY(FZ_fl);
    FY_fr = FZtoFY(FZ_fr);
    FY_rl = FZtoFY(FZ_rl);
    FY_rr = FZtoFY(FZ_rr);
    
    g1 = 0.7*(FY_fl+FY_fr+FY_rl+FY_rr)/car.W; %Assumes that only 70% of the forces reported by the TTC are actually achieved.
    
    g = double((g+g1)/2);
    
end

end

