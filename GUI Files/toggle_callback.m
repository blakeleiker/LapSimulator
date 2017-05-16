function [ ] = toggle_callback( varargin )
% callback function used with the toggle buttons. This function switches
% between the normal lap sim view and the "about" view. 

fig = guidata(gcf);

h = varargin{1};

switch h
    case fig.toggle(1)
        fig.toggle(1).Value = 1;
        fig.toggle(2).Value = 0;
        
        fig.title.Visible = 'on';
        set(fig.tx(:),{'visible'},{'on'});
        set(fig.ed(:),{'visible'},{'on'});
        fig.update_car.Visible = 'on';
        fig.run_sim.Visible = 'on';
        fig.message.Visible = 'on';
        
        fig.about.Visible = 'off';
        
    case fig.toggle(2)
        fig.toggle(1).Value = 0;
        fig.toggle(2).Value = 1;
        
        fig.title.Visible = 'off';
        set(fig.tx(:),{'visible'},{'off'});
        set(fig.ed(:),{'visible'},{'off'});
        fig.update_car.Visible = 'off';
        fig.run_sim.Visible = 'off';
        fig.message.Visible = 'off';

        fig.about.Visible = 'on';
end

end

