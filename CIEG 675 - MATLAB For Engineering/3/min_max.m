function [index_min,index_max] = min_max(vector)
% function [index_min,index_max] = min_max(vector)
%
% This function will get an input of data vector and locate the local
% maxima and minima of the curve plotted between equation y = vector.^1.01 
% + 4*cos(3*pi.*vector./4) - 2*sin(2*pi.*vector./3) - 0.25 vs. vector. This
% function will output the plot altogether with the local maxima and minima
% marked on the same plot.
%
% Input:
% vector - a vector of data for equation y for the plot's x-axis
%
% Output:
% index_min - vector of indices where the local minima occurs
% index_max - vector of indices where the local maxima occurs

index_min = [];index_max = []; 
% Empty array to be filled with indices later on

y = vector.^1.01 + 4*cos(3*pi.*vector./4) - 2*sin(2*pi.*vector./3) - 0.25;
% Example of equation y

for i = 1:length(vector)
    % Should place first two ifs for i = 1 and length(vector) to prevent
    % error for the other two elseifs, since MATLAB will get angry for i+1
    % or i-1 which will result in 'index exceeds number of array elements'.
    
    if i == 1
    elseif i == length(vector)
    % Do nothing to these two points (beg. and end points)
    elseif y(i) > y(i+1) && y(i) > y(i-1)
        % For y-value at position i that is greater than previous and next
        % data, it will be the local maxima
        index_max = cat(1,index_max,i); % concantenate vertically
    elseif y(i) < y(i+1) && y(i) < y(i-1)
        % For y-value at position i that is smaller than previous and next
        % data, it will be the local minima
        index_min = cat(1,index_min,i);
    end % end of first if statement
end % end of for loop
    
figure('name','Local maxima and minima')
plot(vector,y,'k-','linewidth',1)
hold on
localmin = plot(vector(index_min),y(index_min),'ro','markerfacecolor','r','markersize',7);
localmax = plot(vector(index_max),y(index_max),'bo','markerfacecolor','b','markersize',7);
legend([localmin,localmax],'Local Minimum','Local Maximum','location','north')
% Ways to label legend on certain stuff only
set(gca,'fontname','times','fontsize',12,'xcolor',[0 0 0],'ycolor',[0 0 0])
set(gcf,'color',[1 1 1])

end

