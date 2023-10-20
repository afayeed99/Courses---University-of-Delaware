function [graph] = circleplot(x_center,y_center,radius,color)
% function [graph] = circleplot(x_center,y_center,radius,color)
%
% This function will plot a circle based on the given x- and y- coordinates
% as the center with the given radius, with the input color. It will also
% plot a marker on the center of the circle.
%
% Inputs:
% x_center - x-coordinates of the circle center
% y_center - y-coordinates of the circle center
% radius - radius of the circle
% color - color to fill the circle
%
% Outputs:
% graph - figure for the circle plot

theta = linspace(0,2*pi,100);
x_coord = x_center + radius*cos(theta);
y_coord = y_center + radius*sin(theta);
% Equations of circle for polar coordinates

%graph = figure('name','Circle');
graph = fill(x_coord,y_coord,color);
alpha(0.5) % To ensure the marker visible by making the fill translucent
hold on
plot(x_center,y_center,'k*','markersize',1,'linewidth',1)
hold off
axis equal

end

