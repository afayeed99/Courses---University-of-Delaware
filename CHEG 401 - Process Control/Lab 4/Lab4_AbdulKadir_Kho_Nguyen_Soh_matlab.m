%% PART 1

%%
syms Kc

a = 0.8;
b = 8.4;
c = 4-3.8*Kc;

eqn =( -b + sqrt(b^2 - 4*a*c)) / (2*a);
eqn2 =( -b - sqrt(b^2 - 4*a*c)) / (2*a);

vpasolve(eqn == 0,Kc,[-inf,inf])
vpasolve(eqn2 == 0,Kc,[-inf,inf])

%% PART 4.1.1

%% stable p-controller
close all
out = sim('Lab4_AbdulKadir_Kho_Nguyen_Soh_simulink',30);

t = out.tout;

p1 = out.part411_1 + 17;
p2 = out.part411_2 + 17;
p3 = out.part411_3 + 17;

plot(t,p1,'k-','linewidth',1.5)
hold on
plot(t,p2,'r-','linewidth',1.5)
plot(t,p3,'b-','linewidth',1.5)
legend('K_c = -0.5','K_c = -0.8','K_c = -1.0','location','northeast')
ytickformat('%.2f'); ylim([17,18])
xlabel('Time (s)','fontweight','bold','fontsize',12)
ylabel(['Temperature (' char(176) 'C)'],'fontweight','bold','fontsize',12)
set(gca,'linewidth',1.5)
print -djpeg p_controller_plots

%% unstable p controller

close all
out = sim('Lab4_AbdulKadir_Kho_Nguyen_Soh_simulink',100);

t = out.tout;

p = out.part411_b + 17;
plot(t,p,'k-','linewidth',1.5)
ytickformat('%.2f'); 
xlabel('Time (s)','fontweight','bold','fontsize',12)
ylabel(['Temperature (' char(176) 'C)'],'fontweight','bold','fontsize',12)
set(gca,'linewidth',1.5)
print -djpeg p_controller_plots_unstable

%% PI controller, Kc = -0.5

close all
out = sim('Lab4_AbdulKadir_Kho_Nguyen_Soh_simulink',80);

t = out.tout;
pi1 = out.part411_c1 + 17;
pi2 = out.part411_c2 + 17;
pi3 = out.part411_c3 + 17;

plot(t,pi1,'k-','linewidth',1.5)
hold on
plot(t,pi2,'r-','linewidth',1.5)
plot(t,pi3,'b-','linewidth',1.5)
legend('\tau_I = 1.0 s','\tau_I = 2.0 s','\tau_I = 4.0 s','location','southeast')
ytickformat('%.2f'); ylim([16.8,18.2])
xlabel('Time (s)','fontweight','bold','fontsize',12)
ylabel(['Temperature (' char(176) 'C)'],'fontweight','bold','fontsize',12)
set(gca,'linewidth',1.5)
print -djpeg pi_controller_plots


%% pid controller

close all
out = sim('Lab4_AbdulKadir_Kho_Nguyen_Soh_simulink',50);

t = out.tout;
pid1 = out.part411_d1 + 17;
pid2 = out.part411_d2 + 17;
pid3 = out.part411_d3 + 17;

plot(t,pid1,'k-','linewidth',1.5)
hold on
plot(t,pid2,'r-','linewidth',1.5)
plot(t,pid3,'b-','linewidth',1.5)
legend('\tau_D = 1.0 s','\tau_D = 2.0 s','\tau_D = 4.0 s','location','southeast')
ytickformat('%.2f'); %ylim([16.8,18.2])
xlabel('Time (s)','fontweight','bold','fontsize',12)
ylabel(['Temperature (' char(176) 'C)'],'fontweight','bold','fontsize',12)
set(gca,'linewidth',1.5)
print -djpeg pid_controller_plots

%% PI CONTROLLER KC = -1, TAU_I = 2s

close all
out = sim('Lab4_AbdulKadir_Kho_Nguyen_Soh_simulink',100);

t = out.tout;
pi = out.part411_dist + 17;
plot(t,pi,'k-','linewidth',1.5)
ytickformat('%.2f'); ylim([13.5,17.5])
xlabel('Time (s)','fontweight','bold','fontsize',12)
ylabel(['Temperature (' char(176) 'C)'],'fontweight','bold','fontsize',12)
set(gca,'linewidth',1.5)
print -djpeg pi_withdist

%% tuning controller Kc = -6, TauI = 1 s

close all
out = sim('Lab4_AbdulKadir_Kho_Nguyen_Soh_simulink',20);

t = out.tout;
pi = out.part411_dist1 + 17;
plot(t,pi,'k-','linewidth',1.5)
hold on
n = find(t == 6);
plot(t(n:end),pi(n:end),'r-','linewidth',1.5)
m = find(t ==2);
xline(t(m),'k--','linewidth',1.5)
xline(t(n),'r--','linewidth',1.5)
xline(t(8031),'r--','linewidth',1.5)

ytickformat('%.2f'); ylim([14.5,17.5])
legend('Step change in disturbances','Step change in set point','location','northeast')
xlabel('Time (s)','fontweight','bold','fontsize',12)
ylabel(['Temperature (' char(176) 'C)'],'fontweight','bold','fontsize',12)
set(gca,'linewidth',1.5)
set(gcf,'position',[1000         859         645         479])
print -djpeg pi_tuning

%%

%%

%% PART 2

%%
% code obtained from CANVAS
%%

%% PART 3

%%
clc;clear
out=sim('Lab4_1_3Si', 50);
% figure(1)
% %feedback stabilization I
% plot(out.tout,out.Lab413_2a1,'Linewidth',2,'color','b')
% hold on
% grid on
% xlabel('time[unitless]')
% ylabel('Changes in sway angle[Rad]')
% xlim([0 10])
% plot(out.tout,out.Lab413_2a2,'Linewidth',2,'color','r')
% legend("Kc=1","Kc=10")
% hold off
% 
% figure(2)
% %feedback stabilization II
% plot(out.tout,out.Lab413_3a1,'Linewidth',2,'color','b')
% hold on
% grid on
% xlabel('time[unitless]')
% ylabel('Changes in sway angle[Rad]')
% plot(out.tout,out.Lab413_3a2,'Linewidth',2,'color','r')
% legend("Tau=1","Tau=10")
% ylim([-10 10])
% xlim([0 10])
% hold off
% % 
% figure(3)
% %feedback stabilization III
% plot(out.tout,out.Lab413_4a1,'Linewidth',2,'color','b')
% hold on
% grid on
% xlabel('time[unitless]')
% ylabel('Changes in sway angle[Rad]')
% plot(out.tout,out.Lab413_4a2,'Linewidth',2,'color','r')
% plot(out.tout,out.Lab413_4a3,'Linewidth',2,'color','k')
% legend("TauD=10","TauD=1", "TauD=0.1")
% ylim([-5 5])
% xlim([0 20])
% hold off

figure(4)
% effect of sensor delay(a)
plot(out.tout,out.Lab413_5a,'Linewidth',2,'color','b')
hold on
grid on
xlabel('time[unitless]')
ylabel('Changes in sway angle[Rad]')
plot(out.tout,out.Lab413_4a2,'Linewidth',2,'color','r')
legend("with time delay of 0.11","without time delay")
xlim([0 8])
hold off

% % effect of sensor delay(b)
figure(5)
plot(out.tout,out.Lab413_5a,'Linewidth',2,'color','b')
hold on
grid on
xlabel('time[unitless]')
ylabel('Changes in sway angle[Rad]')
plot(out.tout,out.Lab413_5b,'Linewidth',2,'color','r')
legend("time delay=0.11","time delay=1")
xlim([0 10])

hold off