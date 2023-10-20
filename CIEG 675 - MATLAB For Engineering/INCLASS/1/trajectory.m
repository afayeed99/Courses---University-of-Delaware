%% Problem 1
function [target_result,fin_dist] = trajectory(angle,init_dist,init_vel)
% function [fin_dist] = trajectory(angle,init_dist,init_vel)
% This function will plot the trajectory at various stages of the flight. A
% HIT will be shown in the plot of the mortar strikes within 10 meters of
% the target location (NO HIT if otherwise). 
%
% Inputs:
% angle - Mortar firing angle (in degrees)
% init_distance - Initial horizontal distance between the launch and target
% init_vel - Initial mortar velocity
%
% Outputs:
% target_result - HIT or NO HIT
% fin_dist - Final distance between the launch and target

g = 9.81; % gravity (m/s^2)
max_h = ceil((init_vel*sind(angle))^2/2/g); 
% Maximum height, rounded up (m) - upper limit of y-axis

t = linspace(0,100,1000); 
% time (s) - doesn't matter how long the trajectory is

x = init_vel*cosd(angle).*t; % x-coordinates (m)
y = init_vel*sind(angle).*t - g/2.*t.^2; % y-coordinates (m)
plot(x,y,'k-','linewidth',2); ylim([0,max_h+1]);
% Set ylimit in order to show only positive y-values

hold on

range = init_vel^2*sind(2*angle)/g; % Total horizontal distance travelled

fin_dist = abs(init_dist - range);

if fin_dist <= 10 && fin_dist >= 0
    target_result = 'HIT';
else
    target_result = 'NO HIT';
end

text(init_dist,0,target_result,'fontsize',20,'fontweight','bold',...
    'fontname','times','color','b','horizontalalignment','center',...
    'verticalalignment','bottom');
% Placing HIT or NO HIT in the text

plot([init_dist - 10, init_dist + 10],[0,0],'r-','linewidth',4)
legend('Trajectory Path','Target Region')

end
 