%% CIEG 675 - MATLAB FOR ENGINEERING ANALYSIS (Lab 2)
%% Problem 1
% * Demonstration of the function for the mortar at its intermediate
% positions
figure('name','Trajectory Path')
[results,distance] = trajectory(40,100,30)
%% Problem 2
% * Demonstration of the function with two plots of two different circles

diagram_1 = circleplot(4,3,5,'b');
diagram_2 = circleplot(0,10,4,'g');
%% Problem 3
x = 0:0.1:10; y = -0.5.*x.^2 + 4;
figure('name','Parabola')
plot(x,y,'k-','linewidth',2)
set(gcf,'position',[446 248 600 600],'color',[1 1 1])
% position: [a b c d] -> a,b are x,y coord of the figure position
% c,d are width and height length of the figure
% Default c,d - 560,420
% Change color of the background figure to white [1 1 1] RBG color

set(gca,'xtick',[0 2 4 6 8 10],'ytick',[-50 -30 -10 10],...
    'fontsize',14,'fontname','times','tickdir','out')
% Changing the values on x and y-axis, fontsize, name and tick directions

title('Graph of y = -0.5*x^2 + 4','fontweight','bold','fontsize',16)
xlabel('x-values','fontweight','bold','fontsize',16)
ylabel('y-values','fontweight','bold','fontsize',16)

set(gca,'box','off')
% Makes the top and right axis gone

print -dtiff -r600 '/Users/fayeed/Desktop/WINTER 2021/CIEG 675/LAB/Plot_Problem3.tiff' 
% * Changing the location of figures separate from the m file
% * The format is to write the directory based on pwd from command window,
% and include the file name inside the directory, with the file format i.e.
% .tiff
% * pwd - tells current directory