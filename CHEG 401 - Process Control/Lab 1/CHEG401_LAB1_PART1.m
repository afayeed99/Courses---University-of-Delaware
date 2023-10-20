%% PART 1
clc; clear; clf

out = sim('lab1_afak',30);
% The 30 means the stop time for the simulation, can be set here or in
% simulink

subplot(2,1,1)

plot(out.tout,out.Part1(:,1) + 2,'linewidth',2,'color','r')
xlabel('Time (s)','fontname','times','fontweight','bold'); 
ylabel('Flow Rate (m^3/s)','fontname','times','fontweight','bold')
xlim([0,30]); ylim([0,6]);
set(gca,'linewidth',1.5,'fontname','times')

subplot(2,1,2)

plot(out.tout,out.Part1(:,2) + 4,'linewidth',2,'color','r')
xlabel('Time (s)','fontname','times','fontweight','bold'); 
ylabel('Height (m)','fontname','times','fontweight','bold')
xlim([0,30]); ylim([0,12]);
set(gca,'linewidth',1.5,'fontname','times')

%print -djpeg -r1000 prob1_2
%%
h_95 = 0.95*10;
h_98 = 0.98*10;

n_95 = find(abs(out.Part1(:,2) + 4 - h_95) < 1e-4);
n_98 = find(abs(out.Part1(:,2) + 4 - h_98) < 1e-4);
t_95 = out.tout(n_95(1));
t_98 = out.tout(n_98(1));
%% PART 2
close all
out = sim('lab1_afak',50);
% The 30 means the stop time for the simulation, can be set here or in
% simulink

subplot(3,2,1)

plot(out.tout,out.Part2_1s(:,1) + 2,'linewidth',2,'color','r')
xlabel('Time (s)','fontname','times','fontweight','bold'); 
ylabel('Flow Rate (m^3/s)','fontname','times','fontweight','bold')
xlim([0,50]); ylim([0,6]); 
set(gca,'linewidth',1.5,'fontname','times')

subplot(3,2,2)

plot(out.tout,out.Part2_1s(:,2) + 4,'linewidth',2,'color','r')
xlabel('Time (s)','fontname','times','fontweight','bold'); 
ylabel('Height (m)','fontname','times','fontweight','bold')
xlim([0,50]); ylim([0,12]);
set(gca,'linewidth',1.5,'fontname','times')

subplot(3,2,3)

plot(out.tout,out.Part2_5s(:,1) + 2,'linewidth',2,'color','r')
xlabel('Time (s)','fontname','times','fontweight','bold'); 
ylabel('Flow Rate (m^3/s)','fontname','times','fontweight','bold')
xlim([0,50]); ylim([0,6]); 
set(gca,'linewidth',1.5,'fontname','times')

subplot(3,2,4)

plot(out.tout,out.Part2_5s(:,2) + 4,'linewidth',2,'color','r')
xlabel('Time (s)','fontname','times','fontweight','bold'); 
ylabel('Height (m)','fontname','times','fontweight','bold')
xlim([0,50]); ylim([0,12]);
set(gca,'linewidth',1.5,'fontname','times')

subplot(3,2,5)

plot(out.tout,out.Part2_25s(:,1) + 2,'linewidth',2,'color','r')
xlabel('Time (s)','fontname','times','fontweight','bold'); 
ylabel('Flow Rate (m^3/s)','fontname','times','fontweight','bold')
xlim([0,50]); ylim([0,6]); 
set(gca,'linewidth',1.5,'fontname','times')

subplot(3,2,6)

plot(out.tout,out.Part2_25s(:,2) + 4,'linewidth',2,'color','r')
xlabel('Time (s)','fontname','times','fontweight','bold'); 
ylabel('Height (m)','fontname','times','fontweight','bold')
xlim([0,50]); ylim([0,12]);
set(gca,'linewidth',1.5,'fontname','times')
set(gcf,'position',[153   201   680   537])

print -djpeg -r1000 prob1_3
%% PART 3 STEP UP
close all
out = sim('lab1_afak',50);
% The 30 means the stop time for the simulation, can be set here or in
% simulink

subplot(3,2,1)

plot(out.tout,out.Part3_1s(:,1) + 2,'linewidth',2,'color','r')
xlabel('Time (s)','fontname','times','fontweight','bold'); 
ylabel('Flow Rate (m^3/s)','fontname','times','fontweight','bold')
xlim([0,50]); ylim([0,10]); 
set(gca,'linewidth',1.5,'fontname','times')

subplot(3,2,2)

plot(out.tout,out.Part3_1s(:,2) + 4,'linewidth',2,'color','r')
xlabel('Time (s)','fontname','times','fontweight','bold'); 
ylabel('Height (m)','fontname','times','fontweight','bold')
xlim([0,50]); ylim([0,20]); 
set(gca,'linewidth',1.5,'fontname','times')

subplot(3,2,3)

plot(out.tout,out.Part3_5s(:,1) + 2,'linewidth',2,'color','r')
xlabel('Time (s)','fontname','times','fontweight','bold'); 
ylabel('Flow Rate (m^3/s)','fontname','times','fontweight','bold')
xlim([0,50]); ylim([0,10]); 
set(gca,'linewidth',1.5,'fontname','times')

subplot(3,2,4)

plot(out.tout,out.Part3_5s(:,2) + 4,'linewidth',2,'color','r')
xlabel('Time (s)','fontname','times','fontweight','bold'); 
ylabel('Height (m)','fontname','times','fontweight','bold')
xlim([0,50]); ylim([0,20]); 
set(gca,'linewidth',1.5,'fontname','times')

subplot(3,2,5)

plot(out.tout,out.Part3_25s(:,1) + 2,'linewidth',2,'color','r')
xlabel('Time (s)','fontname','times','fontweight','bold'); 
ylabel('Flow Rate (m^3/s)','fontname','times','fontweight','bold')
xlim([0,50]); ylim([0,10]); 
set(gca,'linewidth',1.5,'fontname','times')

subplot(3,2,6)

plot(out.tout,out.Part3_25s(:,2) + 4,'linewidth',2,'color','r')
xlabel('Time (s)','fontname','times','fontweight','bold'); 
ylabel('Height (m)','fontname','times','fontweight','bold')
xlim([0,50]); ylim([0,20]); 
set(gca,'linewidth',1.5,'fontname','times')
set(gcf,'position',[153   201   680   537])

print -djpeg -r1000 prob1_4
%% PART 4 SINE WAVE

close all
out = sim('lab1_afak',30);

subplot(1,2,1)

plot(out.tout,out.Part4_1rad(:,1) + 2,'linewidth',2,'color','r')
xlabel('Time (s)','fontname','times','fontweight','bold'); 
ylabel('Flow Rate (m^3/s)','fontname','times','fontweight','bold')
xlim([0,30]); ylim([0,6]); 
set(gca,'linewidth',1.5,'fontname','times')

hold on

plot(out.tout,out.Part4_1rad(:,2) + 4,'linewidth',2,'color','b')
xlabel('Time (s)','fontname','times','fontweight','bold'); 
ylabel('Height (m)','fontname','times','fontweight','bold')
xlim([0,30]); ylim([0,10]); 
set(gca,'linewidth',1.5,'fontname','times')

subplot(1,2,2)

plot(out.tout,out.Part4_3rad(:,1) + 2,'linewidth',2,'color','r')
xlabel('Time (s)','fontname','times','fontweight','bold'); 
ylabel('Flow Rate (m^3/s)','fontname','times','fontweight','bold')
xlim([0,30]); ylim([0,6]); 
set(gca,'linewidth',1.5,'fontname','times')

hold on

plot(out.tout,out.Part4_3rad(:,2) + 4,'linewidth',2,'color','b')
xlabel('Time (s)','fontname','times','fontweight','bold'); 
ylabel('Height (m)','fontname','times','fontweight','bold')
xlim([0,30]); ylim([0,10]); 
set(gca,'linewidth',1.5,'fontname','times')

set(gcf,'position',[153   269   991   469])
% print -djpeg -r1000 prob1_5

%%
close all
out = sim('lab1_afak',30);

plot(out.tout,out.Part4_1rad(:,1) + 2,'linewidth',2,'color','r')
xlabel('Time (s)','fontname','times','fontweight','bold'); 
ylabel('Flow Rate (m^3/s)','fontname','times','fontweight','bold')
xlim([0,30]); ylim([0,6]); 
set(gca,'linewidth',1.5,'fontname','times')
hold on

plot(out.tout,out.Part4_1rad(:,2) + 4,'linewidth',2,'color','b')
xlabel('Time (s)','fontname','times','fontweight','bold'); 
ylabel('Height (m)','fontname','times','fontweight','bold')
xlim([0,30]); ylim([0,10]); 
set(gca,'linewidth',1.5,'fontname','times')
%% 1 rad/s
time = find(abs(out.tout - 5) < 1e-5);

max_f = max(out.Part4_1rad(1:time,1));
n_f = find(out.Part4_1rad(1:time,1) == max_f);
t_f = out.tout(n_f)

max_h = max(out.Part4_1rad(1:time,2));
n_h = find(out.Part4_1rad(1:time,2) == max_h);
t_h = out.tout(n_h)

diff_t = t_h - t_f

%% 1 rad/s
ten = find(abs(out.tout - 10) < 1e-5);
five = find(abs(out.tout - 5) < 1e-5);

max_05 = max(out.Part4_1rad(1:five,1));
max_510 = max(out.Part4_1rad(five:ten,1));

n_05 = find(out.Part4_1rad(1:five,1) == max_05);
t_05 = out.tout(n_05);
n_510 = find(out.Part4_1rad(1:ten,1) == max_510);
t_510 = out.tout(n_510);

period = t_510 - t_05;

phase_lag = diff_t/period*2;

%% 3rad/s
close all
out = sim('lab1_afak',30);

plot(out.tout,out.Part4_3rad(:,1) + 2,'linewidth',2,'color','r')
xlabel('Time (s)','fontname','times','fontweight','bold'); 
ylabel('Flow Rate (m^3/s)','fontname','times','fontweight','bold')
xlim([0,30]); ylim([0,6]); 
set(gca,'linewidth',1.5,'fontname','times')
hold on

plot(out.tout,out.Part4_3rad(:,2) + 4,'linewidth',2,'color','b')
xlabel('Time (s)','fontname','times','fontweight','bold'); 
ylabel('Height (m)','fontname','times','fontweight','bold')
xlim([0,30]); ylim([0,10]); 
set(gca,'linewidth',1.5,'fontname','times')
%% 3 rad/s
time1 = find(abs(out.tout - 2.5) < 1e-3);
time2 = find(abs(out.tout - 3.5) < 1e-3);
time1 = time1(1); time2 = time2(1);

max_f = max(out.Part4_3rad(time1:time2,1));
n_f = find(out.Part4_3rad(time1:time2,1) == max_f);
t_f = out.tout(time1 + n_f);

max_h = max(out.Part4_3rad(time1:time2,2));
n_h = find(out.Part4_3rad(time1:time2,2) == max_h);
t_h = out.tout(time1 + n_h);

diff_t = t_h - t_f;
%% 3 rad/s
ten = find(abs(out.tout - 2.7) < 1e-3);
five = find(abs(out.tout - 1.5) < 1e-3);
ten = ten(1); five = five(1);

max_05 = max(out.Part4_3rad(1:five,1));
max_510 = max(out.Part4_3rad(five:ten,1));

n_05 = find(out.Part4_3rad(1:five,1) == max_05);
t_05 = out.tout(n_05);
n_510 = find(out.Part4_3rad(1:ten,1) == max_510);
t_510 = out.tout(n_510);

period = t_510 - t_05;

phase_lag = diff_t/period*2/3
