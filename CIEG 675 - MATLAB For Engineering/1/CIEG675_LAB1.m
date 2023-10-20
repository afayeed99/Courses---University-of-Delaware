%% CIEG 675 - Matlab For Engineering Analysis (Lab 1)
%% Problem 1
% * Vector is supressed due to long vectors
row_vec = 1:0.02:10;

%% Problem 2
mat = [1 2 3;4 5 6;7 8 9]

%% Problem 3
diagonal = diag(mat)

%% Problem 4
corners = [mat(1,1),mat(1,end),mat(end,1),mat(end,end)]

%% Problem 5
mid_row = mat(2,:)

%% Problem 6
last_col = mat(:,3)

%% Problem 7
Survey1 = [1 2; 3 4];
Survey2 = [5 6; 7 8];
Survey3 = [9 10; 11 12];
Survey1(:,:,2) = Survey2;
Survey1(:,:,3) = Survey3;
threeD_array = Survey1

%% Problem 8
new_var = [1:8,15:24]

%% Problem 9
% * Will require 401 data to evenly space 1/4 time interval
time_vec = linspace(0,100,401);

%% Problem 10
col_vec = (-30:0.2:30)';

%% Problem 11 
% * Assuming increment of 1
col_vec2 = (0:1:100)';
descending_colvec2 = sort(col_vec2,'descend');

%% Problem 12
time = linspace(0,2*pi,100);
eqn = sin(time);
figure('name','Sine Wave') %name figure bfore plot
plot(time,eqn,'k-','linewidth',1.5)
xlim([0,2*pi]); ylim([-1,1])

%% Problem 13
x = linspace(-10,10,1000);
a = [1,0.5,2];
color= ['k','r','b'];
line_type = {'-','--','-.'};
figure('name','Parabola y = ax^2')
for i = 1:length(a)
    y = a(i)*x.^2;
    plot(x,y,line_type{i},'color',color(i),'linewidth',1.5)
    hold on
end
legend('y = x^2','y = 0.5x^2','y = 2x^2','location','north')
hold off

%% Problem 14
theta = linspace(0,2*pi,100); r = 2;
x1 = -1 + r*cos(theta); y1 = 1 + r*sin(theta);
x2 = 1 + r*cos(theta); y2 = 1 + r*sin(theta);
x3 = r*cos(theta); y3 = -1 + r*sin(theta);
x_coord = [x1;x2;x3]; y_coord = [y1;y2;y3];
new_color = ['r','g','b'];
figure('name','Circles')
for i = 1:3
    fill(x_coord(i,:),y_coord(i,:),new_color(i),'linewidth',3)
    hold on
    alpha(0.5)
    axis square
end
hold off