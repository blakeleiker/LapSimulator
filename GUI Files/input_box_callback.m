function [ ] = input_box_callback( h,~,fig )
% The main purpose of this function is to change the color of each editbox
% after it has been edited, so the user knows that a change has been made.

color = 'yellow';

switch h
    case fig.ed(1)
        fig.ed(1).BackgroundColor = color;
    case fig.ed(2)
        fig.ed(2).BackgroundColor = color;
    case fig.ed(3)
        fig.ed(3).BackgroundColor = color;
    case fig.ed(4)
        fig.ed(4).BackgroundColor = color;
    case fig.ed(5)
        fig.ed(5).BackgroundColor = color;
    case fig.ed(6)
        fig.ed(6).BackgroundColor = color;
    case fig.ed(7)
        fig.ed(7).BackgroundColor = color;
    case fig.ed(8)
        fig.ed(8).BackgroundColor = color;
    case fig.ed(9)
        fig.ed(9).BackgroundColor = color;
    case fig.ed(10)
        fig.ed(10).BackgroundColor = color;
    case fig.ed(11)
        fig.ed(11).BackgroundColor = color;
    case fig.ed(12)
        fig.ed(12).BackgroundColor = color;
    case fig.ed(13)
        fig.ed(13).BackgroundColor = color;
    case fig.ed(14)
        fig.ed(14).BackgroundColor = color;
    case fig.ed(15)
        fig.ed(15).BackgroundColor = color;
end
        
end

