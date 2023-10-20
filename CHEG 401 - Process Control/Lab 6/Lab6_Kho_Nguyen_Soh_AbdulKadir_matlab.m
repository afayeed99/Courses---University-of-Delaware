%% CASCADE CONTROL

syms s Kc

K = -1; tauI = 2; tauD = 1;
gc1 = K.*(1 + 1/tauI/s + tauD*s);
gc2 = Kc;

g = -4/(8*s + 4);
h1 = 1/(0.1*s + 1);
h2 = 1;
gv = 0.95;

gnew = gc2*gv/(1 - gc2*gv*h2);

cltf = gc1*gnew*g/(1 + gc1*gnew*g*h1);

charac = (1 + gc1*gnew*g*h1);
simplifyFraction(charac,'expand',true)

syms s Kc

charac = 2*s*(1 - 0.95*Kc)*(2*s + 1)*(s + 10) + 3*10*(2*s^2 + 2*s + 1)*(0.95*Kc);
simplifyFraction(charac,'expand',true)

eqn = ((42 - 20.9*Kc)*20 - (4 - 3.8*Kc)*9.5*Kc) / (42 - 20.9*Kc);
simplify(eqn);
vpasolve(eqn == 0,Kc,[-inf,inf])

a = solve(eqn >= 0, Kc)

syms w Kc

eqn1 = 20*w - (w^3)*(4 - 3.8*Kc) == 0;
eqn2 = 9.5*Kc - (w^2)*(42 - 20.9*Kc) == 0;

[w_val,kc_val] = solve([eqn1,eqn2],[w,Kc])
eval(w_val)
eval(kc_val)

%% arep
syms w Kc
eqn1 = w*(20 + 38*Kc) - (w^3)*(4 - 3.8*Kc) == 0;
eqn2 = 28.5*Kc - (w^2)*(42 + 17.1*Kc) == 0;

[w_val,kc_val] = solve([eqn1,eqn2],[w,Kc]);
eval(w_val)
eval(kc_val)

%% PLOTTING PURPOSE

% PI Controller
close all
out = sim('Lab6_Kho_Nguyen_Soh_AbdulKadir_simulink',50);

t = out.tout;

lab6 = out.part411_cascade + 17;
lab4 = out.part411_nocasc + 17;

plot(t,lab6,'k-','linewidth',1.5)
hold on
plot(t,lab4,'r-','linewidth',1.5)
legend('With Cascade Control','No Cascade Control','location','southeast','fontsize',15)
ytickformat('%.2f'); %ylim([17,18])
xlabel('Time (s)','fontweight','bold','fontsize',15)
ylabel(['Temperature (' char(176) 'C)'],'fontweight','bold','fontsize',15)
set(gca,'linewidth',1.5)
print -djpeg pid_controller
%%
% P Controller

close all
out = sim('Lab6_Kho_Nguyen_Soh_AbdulKadir_simulink',50);

t = out.tout;

cas = out.part411_cascade + 17;
newcas = out.part411_newcascade + 17;

plot(t,cas,'k-','linewidth',4)
hold on
plot(t,newcas,'r--','linewidth',1.5)
legend('PI Controller','P Controller','location','southeast','fontsize',15)
ytickformat('%.2f'); %ylim([17,18])
xlabel('Time (s)','fontweight','bold','fontsize',15)
ylabel(['Temperature (' char(176) 'C)'],'fontweight','bold','fontsize',15)
set(gca,'linewidth',1.5)
print -djpeg p_controllernew

%% hormone

syms s K Kin
%Kin = 0.3;

eqn = (4*s^3 + 8.5*s + 1)*(10*s + 1 + 2*Kin) + 10*K*Kin;

simplifyFraction(eqn,'expand',true)

%% trial and error

Kin = 1;

w = sqrt((18.5 - 17*Kin)/(4 - 8*Kin))
K = (85*w^2 - 40*w^4 + 2*Kin - 1)/(10*Kin)
Pu = 2*pi/w;

Kact = 0.6*K; tauI = Pu/2; tauD = Pu/8;

P = Kact
I = Kact/tauI
D = Kact*tauD

%% plotting

close all
out = sim('Lab6_Kho_Nguyen_Soh_AbdulKadir_simulink',100);

t = out.tout;

y = out.y;
yd = out.yd;
u1_star = out.u1_star;
u2 = out.u2;
u = out.u;

% output
figure(1)

subplot(2,1,1)
plot(t,y,'r-','linewidth',1.5)
xlabel('Time (hr)','fontweight','bold','fontsize',15)
ylabel('y(t)','fontweight','bold','fontsize',15)
ytickformat('%.2f'); ylim([-0.5,2.5])
set(gca,'linewidth',1.5)

subplot(2,1,2)
plot(t,yd,'r-','linewidth',1.5)
xlabel('Time (hr)','fontweight','bold','fontsize',15)
ylabel('y_d(t)','fontweight','bold','fontsize',15)
ytickformat('%.2f'); ylim([-0.2,1.2])
set(gca,'linewidth',1.5)

% input
figure(2)
subplot(3,1,1)
plot(t,u1_star,'r-','linewidth',1.5)
xlabel('Time (hr)','fontweight','bold','fontsize',15)
ylabel('u_1^*(t)','fontweight','bold','fontsize',15)
ytickformat('%.2f'); %ylim([-0.5,2.5])
set(gca,'linewidth',1.5)

subplot(3,1,2)
plot(t,u2,'r-','linewidth',1.5)
xlabel('Time (hr)','fontweight','bold','fontsize',15)
ylabel('u_2(t)','fontweight','bold','fontsize',15)
ytickformat('%.2f'); %ylim([-0.5,2.5])
set(gca,'linewidth',1.5)

subplot(3,1,3)
plot(t,u,'r-','linewidth',1.5)
xlabel('Time (hr)','fontweight','bold','fontsize',15)
ylabel('u(t)','fontweight','bold','fontsize',15)
ytickformat('%.2f'); %ylim([-0.5,2.5])
set(gca,'linewidth',1.5)

%% new condition

close all
out = sim('Lab6_Kho_Nguyen_Soh_AbdulKadir_simulink',100);

t = out.tout;

y = out.y_new;
yd = out.yd_new;
u1_star = out.u1_star_new;
u2 = out.u2_new;
u = out.u_new;

% % output
% figure(1)
% 
subplot(2,1,1)
plot(t,y,'r-','linewidth',1.5)
xlabel('Time (hr)','fontweight','bold','fontsize',15)
ylabel('y(t)','fontweight','bold','fontsize',15)
ytickformat('%.2f'); %ylim([-1,3])
set(gca,'linewidth',1.5)

subplot(2,1,2)
plot(t,yd,'r-','linewidth',1.5)
xlabel('Time (hr)','fontweight','bold','fontsize',15)
ylabel('y_d(t)','fontweight','bold','fontsize',15)
ytickformat('%.2f'); ylim([-0.2,1.2])
set(gca,'linewidth',1.5)

print -djpeg output_new

% input
figure(2)
subplot(3,1,1)
plot(t,u1_star,'r-','linewidth',1.5)
xlabel('Time (hr)','fontweight','bold','fontsize',15)
ylabel('u_1^*(t)','fontweight','bold','fontsize',15)
ytickformat('%.2f'); %ylim([-0.5,2.5])
set(gca,'linewidth',1.5)

subplot(3,1,2)
plot(t,u2,'r-','linewidth',1.5)
xlabel('Time (hr)','fontweight','bold','fontsize',15)
ylabel('u_2(t)','fontweight','bold','fontsize',15)
ytickformat('%.2f'); %ylim([-0.5,2.5])
set(gca,'linewidth',1.5)

subplot(3,1,3)
plot(t,u,'r-','linewidth',1.5)
xlabel('Time (hr)','fontweight','bold','fontsize',15)
ylabel('u(t)','fontweight','bold','fontsize',15)
ytickformat('%.2f'); %ylim([-0.5,2.5])
set(gca,'linewidth',1.5)

print -djpeg input_new

%%

%%

%%

%%

%%

%% FEEDFORWARD CONTROL

clc;clear
out=sim('lab6_431Si',10);
% %ques2
plot(out.tout,out.simout(:,1),'Linewidth',2,'color','b')
hold on
plot(out.tout,out.simout(:,2),'Linewidth',2,'color','k')
grid on
xlabel('time[ksec]')
ylim([-.01 .11])
ylabel('Response of liquid level[m]')
legend("Set-point","Liquid level[m]",'location',"best")
hold off

plot(out.tout,out.simout(:,3),'Linewidth',2,'color','b')
hold on
grid on
xlabel('time[ksec]')
ylim([0 .11])
ylabel('response of manipulated variable(reflux flow rate)[m3/ksec]')
hold off


% %ques3
plot(out.tout,out.simout1(:,1),'Linewidth',3,'color','k')
hold on
plot(out.tout,out.simout1(:,2),'Linewidth',3,'color','r','LineStyle',"--")
grid on
xlabel('time[ksec]')
ylim([-.01 .11])
ylabel('Response of liquid level[m]')
legend("Set-point","Liquid level[m]",'location',"best")
hold off

plot(out.tout,out.simout1(:,3),'Linewidth',2,'color','b')
hold on
grid on
xlabel('time[ksec]')
ylim([0 .11])
ylabel('response of manipulated variable(reflux flow rate)[m3/ksec]')
hold off
