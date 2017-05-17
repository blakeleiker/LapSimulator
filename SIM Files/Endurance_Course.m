%2014 Endurance Course 
% Breaks the course up into a series of constant radius turns,
% slaloms, and straights

% 3 x N Matrix
%
% R  theta  1   (Radius of turn (ft), degrees, identifier)
% D  #      2   (Distance between cones (ft), number of cones, identifier)
% L  0      3   (Length (ft), placeholder, identifier)

%% Define track
% start is first straight near track entrance
% if theta is negative, left turn; positive = right turn
% 1 -> arc; 2 -> slalom; 3 -> straight

global track; 

track =[267.65  0        3;...
        53.76   -97.946  1;...
        8.47    0        3;...
        35.74   2        2;...
        38.61   2        2;...
        40.02   2        2;...
        42.70   2        2;...
        62.00   70.74    1;...
        64.60   2        2;...
        43.72   2        2;...
        18.10   0        3;...
        55.93   -92.857  1;...
        25.5    152.697  1;...
        197.23  0        3;...
        71.31   42.717   1;...
        59.00   -99.621  1;...
        59.00   119.230  1;...
        62.6    0        3;...
        33      -138.601 1;...
        33.00   166.274  1;...
        24.93   0        3;...
        50.70   2        2;...
        49.93   2        2;...
        51.15   44.098   1;...
        34.97   -76.082  1;...
        98.28   40.146   1;...
        109.33  -57.261  1;...
        108.83  90.464   1;...
        19.19   0        3;...
        33.35   107.278  1;...
        193.41  0        3;...
        69.82   60.600   1;...
        49.15   -82.658  1;...
        90.91   -73.474  1;...
        121.60  52.443   1;...
        73.48   -49.684  1;...
        57.48   30.326   1;...
        65.54   -155.356 1;...
        140.34  0        3;...
        34.18   -109.679 1;...
        29.77   147.482  1;...
        192.16  0        3;...
        106.2   31.279   1;...
        130.80  -31.186  1;...
        46.22   -96.209  1;...
        62.96   0        3;...
        50.00   2        2;...
        50.00   2        2;...
        84.69   244.241  1;...
        43.05   -84.483   1;...
        38.83   0        3;...
        35.00   2        2;...
        37.00   2        2;...
        39.00   2        2;...
        41.00   2        2;...
        35.61   0        3;...
        30.00   158.54   1;...
        55.91   -67.134  1;]; 

%% Color Change Plot
% I have no idea why this is here or what the point of this is
% clf
% x = -10:.05:10;
% y = tan(x);
% z = zeros(size(x));
% v = sin(5*x);
% col = v;  % This is the color, vary with x in this case.
% surface([x;x],[y;y],[z;z],[col;col],...
%         'facecol','no',...
%         'edgecol','interp',...
%         'linew',3);
        
        
            