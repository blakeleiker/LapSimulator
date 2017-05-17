function [ car ] = car_struct()
%CAR_STRUCT
%   function which defines the structure "car" for use in other scripts.
%   This function acts as a centralized location in which to change car
%   parameters across multiple scripts. 
%   Values based upon 2017 TAMU FSAE car. 

car = struct('l',[], 'W',[], 'W1',[], 'W2',[], 'k1',[], 'spring_rate',[], ...
    'spring_rate_front',[], 'spring_rate_rear',[], 'MR',[], 'C1',[], ...
    'damper_rate',[], 'rc_front',[], 'rc_rear',[], 'h', [], 'tf',[], ...
    'tr',[], 'g_max', [], 'P_W',[]);

car.l = 60.25; %[in] wheelbase
car.h = 10; %[in] center of gravity height
car.rc_front = 0; %[in] front roll center height
car.rc_rear = 1.00; %[in] rear roll center height

car.W = 560; %[lb] (car weight, accounting for 150 lb driver)
car.W1 = 20; %[lb] (unsprung weight)
car.W2 = (car.W-car.W1*4)/4; %[lb] (sprung weight of quarter car?)

car.k1 = 600; %[lb/in] (tire spring rate)
car.spring_rate = 500; %[lb/in]
car.MR = 0.7; %motion ratio [spring travel / wheel travel]

car.C1 = 0; %[lb/in/s] (tire damping rate)
car.damper_rate = 6.6; %[lb/in/s] (damping rate @damper)

car.P_W = 0.7*60/car.W; %[HP/lb] power to weight ratio (weight should be full static weight of car + equiv weight of rotating components)


%% Define front and rear spring rates based upon desired natural frequencies
w_front_desired = 3.75; %[Hz] (desired natural frequency at front of car)
w_rear_desired = 4; %[Hz] (desired natural frequency at rear of car)

car.spring_rate = 300;  %[lb/in] initial spring rate guess before iteration
w_front = Natural_Frequency_Calc(2, car);
while min(w_front) < min(w_front_desired)
    w_front = Natural_Frequency_Calc(2, car);
    car.spring_rate = car.spring_rate+1;
    car.spring_rate_front = car.spring_rate;
end

car.spring_rate = 300;  % initial spring rate guess before iteration
w_rear = Natural_Frequency_Calc(2, car);
while min(w_rear) < min(w_rear_desired) 
    w_rear = Natural_Frequency_Calc(2, car);
    car.spring_rate = car.spring_rate+1;
    car.spring_rate_rear = car.spring_rate;
end

%% Calculate track width
Krr = car.spring_rate_rear*car.MR^2;
Krf = car.spring_rate_front*car.MR^2;

car.tf = 48; %[in] front track

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

%% Calculate front and rear lateral load transfers (per g of acceleration)
kr = subs(kr, tr_sym, tr);

WfAy = car.W/car.tf * ( H*kf/(kf+kr) + 0.47 * car.rc_front ); %[lb/g]
WrAy = car.W/car.tr * ( H*kr/(kf+kr) + 0.53 * car.rc_rear ); %[lb/g]

car.g_max = g_calc(car, WfAy, WrAy, 44); % Calculate maximum possible lateral acceleration (4th parameter is car speed)

end

