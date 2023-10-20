function [zg] = gridinterp(x,y,z,xg,yg,d,alpha)
% function [zg] = gridinterp(x,y,z,xg,yg,d,alpha)
%
% This function does an inverse distance weighting for 2D interpolation, by
% interpolating the scattered data points to a uniform grid. 
%
% Inputs:
% x - scattered horizontal locations x; a long vector
% y - scattered vertical locations y; a long vector with the same size as x
% z - measured parameter (e.g. elevation) for the scattered data points; 
% a long vector with the same size as x
% xg - uniform grid of horizontal locations x; a long vector
% yg - uniform grid of vertical locations y; a long vector of the same size
% as xg
% d - allowable radial distance from each uniform grid point; Euclidian
% distance
% alpha - order to inversely weight each point at x and y based on its
% distance from xg and yg respectively
%
% Output:
% zg - interpolated data of z on the uniform grid; a long vector of the
% same size as xg

for j = 1:length(xg)
    w = sqrt((xg(j) - x).^2 + (yg(j) - y).^2); 
    % Weights; Euclidean distance
    % Comparing each grid point to all scattered points at once
    
    idx = find(w > d); 
    % Finding the points that lie outside d
    
    w(idx) = NaN; % make it NaN, because we don't want it
    
    numerator = sum((1./(w.^alpha)).*z,'omitnan'); % omitnan in the calcualtion
    denominator = sum(1./(w.^alpha),'omitnan');
    
    zg(j) = numerator./denominator;
end