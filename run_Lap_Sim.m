function [ ] = run_Lap_Sim( ~,~ )

global laptime track car;

%% Simulate 2014 Endurance Course Lap

run('Endurance_Course.m');


track_time = 0;
x = [0,0];
v = [1,0];
car_position = 'above';
for i = 1:length(track)
    
    if track(i,3) == 1  % arc
        r = track(i,1);
        theta = track(i,2);
        [ t_arc, xo, vo ] = arc(x, v, r, theta, car);
        track_time = track_time + t_arc;
        x = xo;
        v = vo;
    elseif track(i,3) == 2  % slalom
        d = track(i,1);
        num = track(i,2);
        [t_slalom,xo,vo,car_position_o] = slalom(x, v, d, num, car, car_position);
        track_time = track_time + t_slalom;
        car_position = car_position_o;
        x = xo;
        v = vo;
    elseif track(i,3) == 3  % straight
        L = track(i,1);
        [t_straight, xo, vo] = straight(x, v, car, L);
        track_time = track_time+t_straight;
        x = xo;
        v = vo;
    end
    
end

fprintf('Track Time: %0.2f seconds\n', track_time)

laptime = track_time;

end

