%% LAP_SIM
% This script creates a rudimentary lap sim by accounting for the losses in
% lateral acceleration due to lateral load transfer. This script mostly
% lays out the user interface of the lap sim.

%% Define Car and Global Parameters

car = car_struct();
global lap_time track;

%% Create GUI Figure and all car text boxes 

SCR = get(0,'Screensize');  % Get screensize.
fig.height = 360;
fig.width = 800;
fig.fh = figure('units','pixels',...
              'position',[SCR(3)/2-400 ,SCR(4)/2-180 , fig.width, fig.height],...
              'menubar','none',...
              'name','Lap Simulator',...
              'numbertitle','off',...
              'resize','off');

% gui title
fig.title = uicontrol('style','text',...
    'unit','pix',...
    'position',[0 (fig.height-30) fig.fh.Position(3) 22],...
    'min',0,'max',2,...
    'fontsize',22,...
    'string', 'Blake Leiker''s Incredible Lap Simulator',...
    'FontWeight', 'Bold');

% car weight
fig.W = uicontrol('style','text',...
    'unit','pix',...
    'position',[10 (fig.height-90) 100 22],...
    'fontsize',18,...
    'HorizontalAlignment','left',...
    'string', 'Weight [lbs]');
fig.W_box = uicontrol('style','edit',...
    'unit','pix',...
    'position',[160 (fig.height-90) 100 22],...
    'fontsize',18,...
    'string',car.W,...
    'callback',{@input_box_callback,fig});
    %'KeyPressFcn',{@changecolor,fig},... %attempts to change box color when editing box, doesnt currently work

% car wheelbase
fig.l = uicontrol('style','text',...
    'unit','pix',...
    'position',[10 (fig.height-120) 100 22],...
    'fontsize',18,...
    'HorizontalAlignment','left',...
    'string', 'Wheelbase [in]');
fig.l_box = uicontrol('style','edit',...
    'unit','pix',...
    'position',[160 (fig.height-120) 100 22],...
    'fontsize',18,...
    'string',car.l);

% car cg height
fig.h = uicontrol('style','text',...
    'unit','pix',...
    'position',[10 (fig.height-150) 100 22],...
    'fontsize',18,...
    'HorizontalAlignment','left',...
    'string', 'CG Height [in]');
fig.h_box = uicontrol('style','edit',...
    'unit','pix',...
    'position',[160 (fig.height-150) 100 22],...
    'fontsize',18,...
    'string',car.h);

% car front roll center
fig.h = uicontrol('style','text',...
    'unit','pix',...
    'position',[10 (fig.height-180) 150 22],...
    'fontsize',18,...
    'HorizontalAlignment','left',...
    'string', 'Front Roll Center [in]');
fig.h_box = uicontrol('style','edit',...
    'unit','pix',...
    'position',[160 (fig.height-180) 100 22],...
    'fontsize',18,...
    'string',car.rc_front);

% car rear roll center
fig.h = uicontrol('style','text',...
    'unit','pix',...
    'position',[10 (fig.height-210) 150 22],...
    'fontsize',18,...
    'HorizontalAlignment','left',...
    'string', 'Rear Roll Center [in]');
fig.h_box = uicontrol('style','edit',...
    'unit','pix',...
    'position',[160 (fig.height-210) 100 22],...
    'fontsize',18,...
    'string',car.rc_rear);

%% Create Update Car button

fig.update_car = uicontrol('style','pushbutton',...
    'unit','pix',...
    'position',[170 40 150 24],...
    'fontsize',20,...
    'string', 'Update Car',...
    'callback', {@update_car,fig});

%% Create Run Lap Sim button

fig.run_sim = uicontrol('style','pushbutton',...
    'unit','pix',...
    'position',[500 40 150 24],...
    'fontsize',20,...
    'string', 'Run Lap Sim',...
    'callback', {@run_Lap_Sim,car});
