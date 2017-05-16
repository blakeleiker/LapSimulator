%% Quarter Car Model Solver
% This script uses the Natural_Frequency_Calc.m function to simulate a
% quarter car model.

%% Define car struct

car = car_struct();


%% Calculate track width ratios (assuming both roll centers @ ground)

Krr = car.spring_rate_rear*car.MR^2;
Krf = car.spring_rate_front*car.MR^2;

tftr_ratio = 0.47/0.53*Krr/Krf;

tf = 50;
tr = tf/tftr_ratio;


%% Calculate track width ratios (assuming roll centers not on ground)

tf1 = 50;

syms tr1

kf = 12*Krf*tf1^2/2;
kr = 12*Krr*tr1^2/2;

H = car.h + (car.rc_front-car.rc_rear)*0.53 - car.rc_front;

eq = tf1/tr1 == 0.53/0.47 * (H*kf/(kf+kr) + 0.47*car.rc_front) / (H*kr/(kf+kr) + 0.53*car.rc_rear);

tr1 = vpa(solve(eq, tr1));
if length(tr1) ~= 1
    tr1 = tr1(2);
end
tftr_ratio1 = tf1/tr1;

%% Output values

fprintf('rear roll center of 0:\n   tf/tr: %0.4f; tf: %0.2f; tr: %0.2f \n', tftr_ratio, tf, tr)
fprintf('rear roll center of %0.1f: \n   tf/tr: %0.4f; tf: %0.2f; tr: %0.2f \n', car.rc_rear,tftr_ratio1, tf1, tr1)
