clc;clear
out=sim('lab7part2',150);
% %ques2
plot(out.tout,out.simout,'Linewidth',2,'color','b')
hold on
grid on
xlabel('Time[min]')
title("Die Pressure response")
ylabel('Die Pressure(psig)')
hold off

plot(out.tout,out.simout1,'Linewidth',2,'color','k')
hold on
grid on
xlabel('Time[min]')
ylabel('Drive Torque[Nm]')
title("Drive Torque response")
hold off

plot(out.tout,out.simout2,'Linewidth',2,'color','b')
hold on
grid on
xlabel('Time[min]')
title("Die Pressure response")
ylabel('Die Pressure(psig)')
hold off

plot(out.tout,out.simout3,'Linewidth',2,'color','k')
hold on
grid on
xlabel('Time[min]')
ylabel('Drive Torque[Nm]')
title("Drive Torque response")
hold off

%dynamic part2 q3
plot(out.tout,out.simout8,'Linewidth',2,'color','b')
hold on
grid on
xlabel('Time[min]')
title("Die Pressure response")
ylabel('Die Pressure(psig)')
hold off

plot(out.tout,out.simout9,'Linewidth',2,'color','k')
hold on
grid on
xlabel('Time[min]')
ylabel('Drive Torque[Nm]')
title("Drive Torque response")
hold off

%SS part2 q3
plot(out.tout,out.simout6,'Linewidth',2,'color','b')
hold on
grid on
xlabel('Time[min]')
title("Die Pressure response")
ylabel('Die Pressure(psig)')
hold off

plot(out.tout,out.simout7,'Linewidth',2,'color','k')
hold on
grid on
xlabel('Time[min]')
ylabel('Drive Torque[Nm]')
title("Drive Torque response")
hold off


%% PART 3

%% 1

K = [119,153,-21;0.00037,0.00076,-0.00005;930,-667,-1033];
% K_trans = K';
% newK = K_trans*K;
% eigenval = eig(newK);
% 
% singular = [sqrt(eigenval(2)),sqrt(eigenval(3))];
% conditionNum = max(singular)./min(singular);
kappa = cond(K); % 1.77 x 10^7

% finding RGA
K_inv = inv(K);
R = K_inv';
lambda = R.*K


%% 2

[W,S,V] = svd(K);
VT = V';
WT = W';

syms y1 y2 y3 u1 u2 u3
y = [y1;y2;y3]; u = [u1;u2;u3];
mu = VT*u;
LHSeta = vpa(WT*y);
RHSeta = vpa(S*mu)


%% 3
close all
K = [119,153,-21;0.00037,0.00076,-0.00005;930,-667,-1033];
[W,S,V] = svd(K);
WT = W';

Kc = 1./diag(S); 

Kc1 = Kc(1); Kc2 = Kc(2); Kc3 = Kc(3);

tau1 = mean([217,337,10]);
tau2 = mean([500,33,10]);
tau3 = mean([500,166,47]);

% define PI controller in matlab
gc1 = pid(Kc1,Kc1/tau1); % follow the format from SIMULINK
gc2 = pid(Kc2,Kc2/tau2);
gc3 = pid(Kc3,Kc3/tau3);
Gc = [gc1,0,0;0,gc2,0;0,0,gc3];

% define tranfer function
g11 = tf(119,[217 1]);
g12 = tf(153,[337 1]);
g13 = tf(-21,[10 1]);
g21 = tf(0.00037,[500 1]);
g22 = tf(0.000767,[33 1]);
g23 = tf(-0.00005,[10 1]);
g31 = tf(930,[500 1]);
g32 = tf(-667,[166 1],'InputDelay',320);
g33 = tf(-1033,[47 1]);

G = [g11,g12,g13;g21,g22,g23;g31,g32,g33];

out = sim('Lab7_Kho_Nguyen_Li_AbdulKadir_simulink',2000);

t = out.tout;
y1 = out.yout(:,1);
y2 = out.yout(:,2);
y3 = out.yout(:,3);

plot(t,y1,'k-','linewidth',1.5)
hold on
plot(t,y2,'r-','linewidth',1.5)
plot(t,y3,'b-','linewidth',1.5)
plot(t,linspace(-10,-10,length(t)),'k--','linewidth',1.5)

xlabel('Time (s)','fontweight','bold','fontsize',15)
ylabel('Responses','fontweight','bold','fontsize',15)
legend('y_1','y_2','y_3','location','east','fontsize',15)
%xlim([0,2]); 
ylim([-12,2])
% ytickformat('%.1f')
set(gca,'linewidth',1.5,'fontname','times','fontsize',15)

print -djpeg SVD
