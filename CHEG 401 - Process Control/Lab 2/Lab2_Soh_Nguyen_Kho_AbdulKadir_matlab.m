%% PART 1
%% 2.1.1 SKETCH
close all
t = 0:0.01:100;
y1 = 10.*(1 - exp(-t./5));
y2 = 5.*(1 - exp(-t./10));
y3 = 2.*t;

plot(t,y1)
hold on
plot(t,y2)
plot(t,y3)
ylim([0,20])

%% 2.1.2 System I

% Q2
close all
F = 0.5; % m^3/ksec
k = 1.5e-3; % ksec^-1
v = 20; %m^3
Caf_star = 90; % mol/m^3
out = sim('Lab2_Soh_Nguyen_Kho_AbdulKadir_simulink',300);
ca_star = F*Caf_star/(F + k*v);

t = out.tout;
ca = out.part1_sys1_2(:,2) + ca_star;
plot(t,ca,'r-','linewidth',1.5)

xlabel('Time (ksec)','fontname','times','fontweight','bold'); 
ylabel('Concentration of A (mol/m^3)','fontname','times','fontweight','bold')
% xlim([0,30]); ylim([0,6]);
set(gca,'linewidth',1.5,'fontname','times')

% Q3

t = out.tout;
ca = out.part1_sys1_3(:,2) + ca_star;

plot(t,ca,'r-','linewidth',1.5)
xlabel('Time (ksec)','fontname','times','fontweight','bold'); 
ylabel('Concentration of A (mol/m^3)','fontname','times','fontweight','bold')
% xlim([0,30]); ylim([0,6]);
ylim([84.8,85.5]);
ytickformat('%.2f')
set(gca,'linewidth',1.5,'fontname','times')

max_ca = max(ca); % 85.3926 mol/m^3

%% 2.1.3 System II
close all
out = sim('Lab2_Soh_Nguyen_Kho_AbdulKadir_simulink',10);
t = out.tout;
h_star = 0.5; % m
h = out.part1_sys2_2(:,2) + h_star;

plot(t,h,'r-','linewidth',1.5)
xlabel('Time (ksec)','fontname','times','fontweight','bold','fontsize',20); 
ylabel('Height (m)','fontname','times','fontweight','bold','fontsize',20); 
% ylim([0,1]);
hold on
plot([0.5,0.5],[0,1],'k--','linewidth',1.5)
plot([0,0.5],[1,1],'k--','linewidth',1.5)
plot(0.5,1,'ko','markersize',8,'markerfacecolor','k')
xtickformat('%.1f'); ytickformat('%.1f')
set(gca,'linewidth',1.5,'fontname','times')
hold off

close all; clear
out = sim('lab2_cheg401',3);
t = out.tout;
h_star = 0.5; % m
h = out.part1_sys2_3(:,2) + h_star;

subplot(1,2,1)
plot(t,h,'r-','linewidth',1.5)
xlabel('Time (ksec)','fontname','times','fontweight','bold','fontsize',15);  
ylabel('Height (m)','fontname','times','fontweight','bold','fontsize',15); 
set(gca,'linewidth',1.5,'fontname','times')
xtickformat('%.1f'); ytickformat('%.2f')
ylim([0,0.7]);

fr_star = 0.3; % m^3/ksec 
Kc = 1; %m^2/ksec
fr = fr_star + Kc.*(h - h_star);

subplot(1,2,2)
plot(t,fr,'r-','linewidth',1.5)
xlabel('Time (ksec)','fontname','times','fontweight','bold','fontsize',15)
ylabel('Reflux Flow Rate (m^3/ksec)','fontname','times','fontweight','bold','fontsize',15)
set(gca,'linewidth',1.5,'fontname','times'); 
xtickformat('%.1f'); ytickformat('%.2f')
ylim([0,0.7]);
set(gcf,'position',[680   521   901   457])

print -djpeg 213_part1
%%

%% PART 2

%% Part 2.2.1 Q3

close all; clear
F = 0.5; % m^3/ksec
k = 1.5e-3; % ksec^-1
v = 20; %m^3
Caf_star = 90; % mol/m^3
out = sim('Lab2_Soh_Nguyen_Kho_AbdulKadir_simulink',1000);
ca_star = F*Caf_star/(F + k*v);

t = out.tout;
ca = out.part1_sys1_2(:,2) + ca_star;
plot(t,ca,'r-','linewidth',1.5,'color','r')
hold on

plot(out.tout,out.part2_221_3+82.4327,'Linewidth',1.5,'color','b')
xlabel('Time (ksec)','fontname','times','fontweight','bold'); 
ylabel('Concentration of A (mol/m^3)','fontname','times','fontweight','bold')
set(gca,'linewidth',1.5,'fontname','times')
xlim([0 500])
ylim([82 95])
legend('step response of low order system (Section 2.1.2)','Step response of two first-order systems in series ')
hold off
%% part 2.2.1 Q4
close all; clear


F = 0.5; % m^3/ksec
k = 1.5e-3; % ksec^-1
v = 20; %m^3
Caf_star = 90; % mol/m^3
ca_star = F*Caf_star/(F + k*v);

out = sim('Lab2_Soh_Nguyen_Kho_AbdulKadir_simulink',300);

t = out.tout;
ca = out.part1_sys1_3(:,2) + ca_star;
plot(t,ca,'r','linewidth',1.5)
hold on

plot(out.tout,out.part2_221_4+82.4327,'Linewidth',1.5,'color','b')
xlabel('Time (ksec)','fontname','times','fontweight','bold'); 
ylabel('Concentration of A (mol/m^3)','fontname','times','fontweight','bold')
set(gca,'linewidth',1.5,'fontname','times')
set(gcf,'position',[587   518   801   677])
xlim([0 300])
ylim([82,85.5])
legend('Rectangular pulse response of low order system (Section 2.1.2)','Rectangular pulse response of two first-order systems in series ')
hold off

%% 2.2.2

close all; clear
out = sim('Lab2_Soh_Nguyen_Kho_AbdulKadir_simulink',1000);
t = out.tout;
col = {'k','r','b','g','m'};

F = 0.5; % m^3/ksec
k = 1.5e-3; % ksec^-1
v = 20; %m^3
Caf_star = 90; % mol/m^3
ca_star_1 = F*Caf_star/(F + k*v);
ca_star_2 = F/(F + k*v)*ca_star_1;
ca_star_3 = F/(F + k*v)*ca_star_2;
ca_star_4 = F/(F + k*v)*ca_star_3;
ca_star_5 = F/(F + k*v)*ca_star_4;
ca_star = [ca_star_1,ca_star_2,ca_star_3,ca_star_4,ca_star_5];

for i = 1:5
    ca(:,i) = out.part2_222(:,i) + ca_star(i);
    if i == 4
        plot(t,ca(:,i),'color',[0.4667    0.6745    0.1882],'linewidth',1.5)
        hold on
    else
        plot(t,ca(:,i),'color',col{i},'linewidth',1.5)
        hold on
    end
end
legend('1^{st} Reactor','2^{nd} Reactor','3^{rd} Reactor','4^{th} Reactor','5^{th} Reactor',...
    'location','southeast')
ylim([60,100])
xlabel('Time (ksec)','fontname','times','fontweight','bold'); 
ylabel('Concentration of A (mol/m^3)','fontname','times','fontweight','bold')
set(gca,'linewidth',1.5,'fontname','times')
hold off
%% 2.2.2 Q4
close all
out = sim('Lab2_Soh_Nguyen_Kho_AbdulKadir_simulink',1000);
t = out.tout;
Caf_star = 90;
F = 0.5; % m^3/ksec
k = 1.5e-3; % ksec^-1
v = 20; %m^3

ca_star_1 = F*Caf_star/(F + k*v);
ca_star_2 = F/(F + k*v)*ca_star_1;
ca_star_3 = F/(F + k*v)*ca_star_2;
ca_star_4 = F/(F + k*v)*ca_star_3;
ca_star_5 = F/(F + k*v)*ca_star_4;

ca_5 = out.part2_222_3(:,1) + ca_star_5;

plot(t,ca_5,'r-','linewidth',1.5)
hold on
plot(t,ca(:,5),'r--','linewidth',1.5)
xlabel('Time (ksec)','fontname','times','fontweight','bold'); 
ylabel('Concentration of A (mol/m^3)','fontname','times','fontweight','bold')
set(gca,'linewidth',1.5,'fontname','times')
ylim([60,80])
legend('Approximate model','Actual model')
hold off

%% 2.2.3
out = sim('Lab2_Soh_Nguyen_Kho_AbdulKadir_simulink',15)
plot(out.tout,out.part2_223,'Linewidth',1.5,'color','r')
xlabel('Time(sec)','fontname','times','fontweight','bold')
ylabel('Sway angle','fontname','times','fontweight','bold')
set(gca,'linewidth',1.5,'fontname','times')
xlim([0 15])
ylim([0 60])

%%

%% PART 3

%%

%%
close all; clear
out = sim('Lab2_Soh_Nguyen_Kho_AbdulKadir_simulink',20);
g1 = out.part3_top1(:,2);
g2 = out.part3_top2(:,2);
g3 = out.part3_top3(:,2);
t = out.tout;

plot(t,g1,'r','linewidth',1.5)
hold on
plot(t,g2,'b','linewidth',1.5)
plot(t,g3,'k','linewidth',1.5)

xlabel('Time','fontname','times','fontweight','bold'); 
ylabel('Response','fontname','times','fontweight','bold')
legend('System 1','System 2','System 3','location','southeast')
set(gca,'linewidth',1.5,'fontname','times')
ylim([-10,90])
print -djpeg part3_top

%% 10 days
close all; clear
out = sim('Lab2_Soh_Nguyen_Kho_AbdulKadir_simulink',30);

t = out.tout;
xi1 = out.x1_1;
xi2 = out.x2_1;
eta = xi2 - xi1;

plot(t,xi1,'k','linewidth',1.5)
hold on
plot(t,xi2,'r','linewidth',1.5)
plot(t,eta,'b','linewidth',1.5)

xlabel('Time (days)','fontname','times','fontweight','bold'); 
ylabel('Number of molecules per mL','fontname','times','fontweight','bold')
legend('\xi_1','\xi_2','\eta')%'location','northwest')
set(gca,'linewidth',1.5,'fontname','times')

% print -djpeg v_24000
%% 30 days
% close all; clear
out = sim('Lab2_Soh_Nguyen_Kho_AbdulKadir_simulink',30);

t = out.tout;
xi1 = out.x1_2 + out.x1_1(end);
xi2 = out.x2_2 + out.x2_1(end);
eta = xi2 - xi1;

plot(t,xi1,'k-','linewidth',1.5)
hold on
plot(t,xi2,'r-','linewidth',1.5)
plot(t,eta,'b-','linewidth',1.5)

xlabel('Time (days)','fontname','times','fontweight','bold'); 
ylabel('Number of molecules per mL','fontname','times','fontweight','bold')
legend('\xi_1','\xi_2','\eta','location','southeast')
set(gca,'linewidth',1.5,'fontname','times')
set(gcf,'position',[798   498   792   569])
print -djpeg v_54000