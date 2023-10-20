function [target_result,fin_dist] = trajectory(angle,init_dist,init_vel)
% function [target_result,fin_dist] = trajectory(angle,init_dist,init_vel)
% 
% This function will plot the trajectory at various stages of the flight. A
% HIT will be shown in the plot of the mortar strikes within 10 meters of
% the target location (NO HIT if otherwise). 
%
% Inputs:
% angle - Mortar firing angle (in degrees)
% init_distance - Initial horizontal distance between the launch and target
% (m)
% init_vel - Initial mortar velocity (m/s^2)
%
% Outputs:
% target_result - HIT or NO HIT
% fin_dist - Final distance between the launch and target (m)

plot([init_dist - 10, init_dist + 10],[0,0],'r-','linewidth',4)
% Within 10 meters of target
hold on
text(init_dist,0,'TARGET','fontsize',15,'fontweight','bold',...
    'fontname','times','color','k','horizontalalignment','center',...
    'verticalalignment','bottom');
% Plot and naming TARGET in the figure

plot(0,0,'ksquare','markersize',10,'markerfacecolor','b')
text(0,0,'LAUNCH','fontsize',15,'fontweight','bold',...
    'fontname','times','color','k','horizontalalignment','left',...
    'verticalalignment','bottom');
% Plot and naming LAUNCH in the figure

xlabel('Horizontal Distance (m)','fontsize',14)
ylabel('Vertical Distance (m)','fontsize',14)
set(gca,'fontname','times','fontweight','bold','xcolor',[0 0 0],'ycolor',[0 0 0])

g = 9.81; % gravity (m/s^2)
t = linspace(0,100,500); 
% time (s) - doesn't matter how long the trajectory is

max_h = ceil((init_vel*sind(angle))^2/2/g); % Round up the max. height
ylim([0,max_h]) % To fix the y-axis

for i = 1:length(t) % run loop for the entire length of time
    x = init_vel*cosd(angle).*t(i); % x-coordinates (m)
    y = init_vel*sind(angle).*t(i) - g/2.*t(i).^2; % y-coordinates (m)
    
    if y >= 0 % Positive height only!
        plot(x,y,'ko','markersize',5,'markerfacecolor','k'); 
        pause(1/10); % Will pause for 1/10 s before running the loop again
    else % Negative height, which is irrelevant
        break % Break out of for loops entirely, regardless of running all loops!
    end % end of if statement
    
end % end of for loop

range = init_vel^2*sind(2*angle)/g; % Total horizontal distance travelled
fin_dist = abs(init_dist - range);

if fin_dist <= 10 && fin_dist >= 0
    target_result = 'HIT';
else
    target_result = 'NO HIT';
end

text(init_dist,5,target_result,'fontsize',20,'fontweight','bold',...
    'fontname','times','color','b','horizontalalignment','center',...
    'verticalalignment','bottom');
% Placing HIT or NO HIT in the figure

end
