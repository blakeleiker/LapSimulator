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

car.W = 520; %[lb] (car weight, accounting for 150 lb driver)
car.W1 = 20; %[lb] (unsprung weight)
car.W2 = (car.W-car.W1*4)/4; %[lb] (sprung weight of quarter car?)

car.k1 = 600; %[lb/in] (tire spring rate)
car.spring_rate = 500; %[lb/in]
car.MR = 0.7; %motion ratio [spring travel / wheel travel]

car.C1 = 0; %[lb/in/s] (tire damping rate)
car.damper_rate = 6.6; %[lb/in/s] (damping rate @damper)

car.P_W = 0.7*60/car.W; %[HP/lb] power to weight ratio (weight should be full static weight of car + equiv weight of rotating components)


%% Define front and rear spring rates based upon desired natural frequencies
w_front_desired = 4; %[Hz] (desired natural frequency at front of car)
w_rear_desired = 4.25; %[Hz] (desired natural frequency at rear of car)

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

end

