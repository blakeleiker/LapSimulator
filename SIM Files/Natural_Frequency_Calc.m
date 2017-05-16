function [ w ] = Natural_Frequency_Calc( method, car )
%NATURAL_FREQUENCY_CALC
% This function calculates the natural frequencies of a quarter car model
% by taking the roots of the characteristic equation of the equations of
% motion.
% Initial equation taken from Beachley and Harrison notes on quarter car
% model.
% INPUT: "method' - chooses method of solving. Options are 1, for
%                   simplified 1 DOF model, or 2, for full quarter car
%                   model. 
%        "car" - struct containing quarter car model parameters. Required 
%                parameters explained below.
%        "car.W1" - unsprung weight of quarter car [lb]
%        "car.W2" - sprung weight of quarter car [lb]
%        "car.k1" - spring rate of tire [lb/in]
%        "car.spring_rate" - spring rate @ spring [lb/in]
%        "car.MR" - motion ratio [lb/in]
%        "car.C1" - damping rate of tire [lb/in/s]
%        "car.damper_rate" - damping rate @ damper [lb/in/s]

M1 = car.W1/32.174/12; %[lb/in/s2]
M2 = car.W2/32.174/12; %[lb/in/s2]

k1 = car.k1;
k2 = car.spring_rate*car.MR^2; %[lb/in] (wheel rate)

C1 = car.C1; %[lb/in/s] (tire damping rate)
C2 = car.damper_rate*car.MR^2;

%% Calculate charac. eq. roots and find natural freq.
A = M1*M2; 
B = (C1+C2)*M2 + M1*C2;
C = M1*k2 + (C1+C2)*C2 + (k1+k2)*M2 - C2^2;
D = (C1+C2)*k2 + (k1+k2)*C2 - 2*C2*k2;
E = (k1+k2)*k2 - k2^2;

r = roots([A B C D E]);

wn1 = abs(r(1))/2/pi; %1st natural frequency [Hz]
wn2 = abs(r(2))/2/pi; %2nd natural frequency [Hz]
wn3 = abs(r(3))/2/pi; %3st natural frequency [Hz]
wn4 = abs(r(4))/2/pi; %4nd natural frequency [Hz]


w = [wn1 wn2 wn3 wn4];  

%% Simplified 1 DOF EOM Method

k = (1/k1+1/k2)^-1; %[lb/in] (equivalent stiffness of tire and spring)
wn_1dof = sqrt(k/(M1+M2))/2/pi; % [Hz]

%% Output

if method == 1
    w = wn_1dof;
elseif method == 2
    w = [wn1 wn2 wn3 wn4]; 
end


end

