ant_ace = [4.42448,1312.253,-32.445]; % 259.16K - 507.6K
ant_met = [5.20409,1581.341,-33.50]; % 288.1 - 356.83K
ant_eth = [5.24677,1598.673,-46.424]; % 292.77 - 366.63K

%%
pres = 1; % antoine should be in bar

bp_ace = ant_ace(2)/(ant_ace(1) - log10(pres)) - ant_ace(3); % 329.0342 K
bp_met = ant_met(2)/(ant_met(1) - log10(pres)) - ant_met(3); % 337.3650 K
bp_eth = ant_eth(2)/(ant_eth(1) - log10(pres)) - ant_eth(3); % 351.1206 K 

%% gamma infinity vs P/T

t_range = 293:0.01:373; %20 - 100 C
pvap_a = 10.^(ant_ace(1) - ant_ace(2)./(t_range + ant_ace(3)));
pvap_m = 10.^(ant_met(1) - ant_met(2)./(t_range + ant_met(3)));
pvap_e = 10.^(ant_eth(1) - ant_eth(2)./(t_range + ant_eth(3)));

dpvap_dt_a = log(10).*ant_ace(2).*pvap_a./((t_range + ant_ace(3)).^2);
dpvap_dt_m = log(10).*ant_met(2).*pvap_m./((t_range + ant_met(3)).^2);
dpvap_dt_e = log(10).*ant_eth(2).*pvap_e./((t_range + ant_eth(3)).^2);

% for x1 -> 0

t1 = bp_eth;
p1vap = 10.^(ant_met(1) - ant_met(2)./(t1 + ant_met(3)));
p2vap = 10.^(ant_eth(1) - ant_eth(2)./(t1 + ant_eth(3)));
dtdx1 = (p2vap - gamma_inf_metME*p1vap)*(t1 + ant_eth(3))^2/...
    (log(10)*ant_eth(2)*p2vap);

% for x2 -> 0
t2 = bp_met;
p1vap = 10.^(ant_met(1) - ant_met(2)./(t2 + ant_met(3)));
p2vap = 10.^(ant_eth(1) - ant_eth(2)./(t2 + ant_eth(3)));
dtdx2 = (p1vap - gamma_inf_ethME*p2vap)*(t2 + ant_met(3))^2/...
    (log(10)*ant_met(2)*p1vap);

%% gamma inf vs T

gammainf_m_me = (pvap_e - dpvap_dt_e.*dtdx1)./pvap_m;
gammainf_e_me = (pvap_m - dpvap_dt_m.*dtdx2)./pvap_e;

plot(t_range,gammainf_m_me,'b','linewidth',1.5)
hold on
plot(t_range,gammainf_e_me,'r','linewidth',1.5)
plot([330,355],[1.1,1.1],'k-','linewidth',1)
plot([330,355],[1.3,1.3],'k-','linewidth',1)
plot([330,330],[1.1,1.3],'k-','linewidth',1)
plot([355,355],[1.1,1.3],'k-','linewidth',1)
hold off
xtickformat('%.2f'); ytickformat('%.2f');
xlabel('T (K)','fontsize',12)
ylabel('\bf\gamma^{\infty}','fontsize',12)
legend('\bf\gamma^{\infty}_{Methanol}','\bf\gamma^{\infty}_{Ethanol}')
set(gca,'xcolor',[0 0 0],'ycolor',[0 0 0],'fontname','times',...
    'xminortick','on','yminortick','on')
axes('position',[0.2 0.4 0.25 0.25])
plot(t_range,gammainf_m_me,'b','linewidth',1.5)
hold on
plot(t_range,gammainf_e_me,'r','linewidth',1.5)
xtickformat('%.1f'); ytickformat('%.2f');
xlim([330,355])
set(gca,'xcolor',[0 0 0],'ycolor',[0 0 0],'fontname','times',...
    'xminortick','on','yminortick','on')
hold off

print -djpeg gammainf_me_T

%% gamma inf vs P
plot(pvap_e,gammainf_m_me,'b','linewidth',1.5)
hold on
plot(pvap_m,gammainf_e_me,'r','linewidth',1.5)
plot([0.95,1.05],[1.1,1.1],'k-','linewidth',1)
plot([0.95,1.05],[1.3,1.3],'k-','linewidth',1)
plot([0.95,0.95],[1.1,1.3],'k-','linewidth',1)
plot([1.05,1.05],[1.1,1.3],'k-','linewidth',1)
hold off
xtickformat('%.1f'); ytickformat('%.2f');
xlabel('P (bar)','fontsize',12)
ylabel('\bf\gamma^{\infty}','fontsize',12)
legend('\bf\gamma^{\infty}_{Methanol}','\bf\gamma^{\infty}_{Ethanol}')
set(gca,'xcolor',[0 0 0],'ycolor',[0 0 0],'fontname','times',...
    'xminortick','on','yminortick','on')
axes('position',[0.45 0.65 0.25 0.25])
plot(pvap_e,gammainf_m_me,'b','linewidth',1.5)
hold on
plot(pvap_a,gammainf_e_me,'r','linewidth',1.5)
xtickformat('%.2f'); ytickformat('%.2f');
xlim([0.95,1.05])
set(gca,'xcolor',[0 0 0],'ycolor',[0 0 0],'fontname','times',...
    'xminortick','on','yminortick','on')

print -djpeg gammainf_me_P
%%
pres = 1; % antoine should be in bar

bp_ace = ant_ace(2)/(ant_ace(1) - log10(pres)) - ant_ace(3); % 329.0342 K
bp_met = ant_met(2)/(ant_met(1) - log10(pres)) - ant_met(3); % 337.3650 K
bp_eth = ant_eth(2)/(ant_eth(1) - log10(pres)) - ant_eth(3); % 351.1206 K 

%% METHANOL:ETHANOL (ME)
binary_metEth = dlmread('binary_met_eth.txt','',2,0);
x_met = binary_metEth(:,2);
gamma_met = binary_metEth(:,6);
gamma_eth = binary_metEth(:,7);

%figure('name','Activity Coefficient vs. x_met ME (UNIFAC)')
plot(x_met,gamma_met,'k','linewidth',1.5);
hold on
plot(x_met,gamma_eth,'r','linewidth',1.5);
%hold off
xtickformat('%.2f'); ytickformat('%.2f');
xlabel('x_{Methanol}','fontsize',12)
ylabel('\bf\gamma','fontsize',12)
legend('\bf\gamma_{Methanol}','\bf\gamma_{Ethanol}','location','north')
set(gca,'xcolor',[0 0 0],'ycolor',[0 0 0],'fontname','times',...
    'xminortick','on','yminortick','on','linewidth',1.5)
%%
gamma_inf_metME = gamma_met(1); gamma_inf_ethME = gamma_eth(end);

% VanLaar Parameters (1 - acetone, 2 - methanol)
A12_ME = log(gamma_inf_metME);  A21_ME = log(gamma_inf_ethME);

x1 = 0:0.001:1; x2 = 1 - x1;

gamma1_ME = exp(A12_ME.*((A21_ME.*x2)./(A12_ME.*x1 + A21_ME.*x2)).^2);
gamma2_ME = exp(A21_ME.*((A12_ME.*x1)./(A12_ME.*x1 + A21_ME.*x2)).^2);

%figure('name','Activity Coefficient vs. x_ace ME (VanLaar)')
plot(x1,gamma1_ME,'k','linewidth',1.5)
hold on
plot(x1,gamma2_ME,'r','linewidth',1.5)
hold off
xtickformat('%.2f'); ytickformat('%.2f');
xlabel('x_{Methanol}','fontsize',12)
ylabel('\bf\gamma','fontsize',12)
legend('\bf\gamma_{Methanol}','\bf\gamma_{Ethanol}','location','north')
set(gca,'xcolor',[0 0 0],'ycolor',[0 0 0],'fontname','times',...
    'xminortick','on','yminortick','on','linewidth',1.5)

%% T vs. x VANLAAR
%figure('name','T vs. x_ace AM (VanLaar)')
T = linspace(bp_met,bp_eth,length(x1));
opt = optimset('Display','notify');
t_solve = fsolve(@optimizer,T,opt,ant_met,ant_eth,x1,x2,gamma1_ME,gamma2_ME,pres);

pvap1 = 10.^(ant_met(1) - ant_met(2)./(t_solve + ant_met(3)));
y1 = gamma1_ME.*pvap1.*x1;
plot(x1,t_solve,'k','linewidth',1.5)
hold on
plot(y1,t_solve,'b','linewidth',1.5)
legend('Liquid Composition','Vapor Composition')
xtickformat('%.2f'); ytickformat('%.2f');
xlabel('x_{Methanol}','fontsize',12)
ylabel('T (K)','fontsize',12)
set(gca,'xcolor',[0 0 0],'ycolor',[0 0 0],'fontname','times',...
    'xminortick','on','yminortick','on','linewidth',1.5)
xlim([0,1])
hold off
save T_unifac_avgp t_solve 
% print -djpeg '/Users/fayeed/Desktop/SPRING 2021/CHEG 345 -JLab/VLE/Methanol Ethanol/T_xME.jpeg'
%% y vs x curve
plot(x1,y1,'k','linewidth',1.5)
hold on
real_eq = plot([0,1],[0,1],'k--');
xtickformat('%.2f'); ytickformat('%.2f');
xlabel('x_{Methanol}','fontsize',12)
ylabel('y_{Methanol}','fontsize',12)
set(gca,'xcolor',[0 0 0],'ycolor',[0 0 0],'fontname','times',...
    'xminortick','on','yminortick','on')
legend(real_eq,'y_{Methanol} = x_{Methanol}','location','northwest')
axis([0,1,0,1])
print -djpeg '/Users/fayeed/Desktop/SPRING 2021/CHEG 345 -JLab/VLE/Methanol Ethanol/y_xME.jpeg'

%% 0 limit 
n0 = find(x1 == 0.2); % max temp = 0.005 K
x_0lim = x1(1:n0);
temp_0lim = t_solve(1:n0);
p0 = polyfit(x_0lim,temp_0lim,2);
temp0_fit = polyval(p0,x_0lim);
delta_temp0 = temp_0lim - temp0_fit;

%figure('name','T vs x_met @ zero limit')
plot(x_0lim,temp_0lim,'k-','linewidth',1.5);
hold on
xlabel('x_{Methanol}','fontsize',12)
ylabel('T (K)','fontsize',12) 
xtickformat('%.2f'); ytickformat('%.2f')
set(gca,'xcolor',[0 0 0],'ycolor',[0 0 0],'fontname','times',...
    'xminortick','on','yminortick','on','linewidth',1.5)
plot(x_0lim,temp0_fit,'r--','linewidth',3)
legend('VanLaar Equation','Quadratic Fitting')

%% Injection size
m = 0:0.01:0.2;
k = 0:0.05:0.2;
y = p0(1).*m.^2 + p0(2).*m + p0(3);
z = p0(1).*k.^2 + p0(2).*k + p0(3);
a = plot(x_0lim,temp_0lim,'k','linewidth',1);
hold on
b = plot(m,y,'bo--','linewidth',1.5);
c = plot(k,z,'r*--','linewidth',1.5);
xlim([0 0.05])

plot([0.023,0.027],[350.5,350.5],'k','linewidth',1.5)
plot([0.023,0.027],[350.6,350.6],'k','linewidth',1.5)
plot([0.023,0.023],[350.5,350.6],'k','linewidth',1.5)
plot([0.027,0.027],[350.5,350.6],'k','linewidth',1.5)
legend([a,b,c],'Quadratic Fitting','Injection of x_{Methanol} = 0.01','Injection of x_{Methanol} = 0.05')
xtickformat('%.3f'); ytickformat('%.2f')
xlabel('x_{Methanol}','fontsize',12)
ylabel('T (K)','fontsize',12) 
set(gca,'xcolor',[0 0 0],'ycolor',[0 0 0],'xminortick','on',...
    'yminortick','on','fontname','times')
axes('position',[0.25 0.25 0.2 0.2])
plot(x_0lim,temp_0lim,'k','linewidth',1);
hold on
plot(m,y,'bo--','linewidth',1.5)
plot(k,z,'r*--','linewidth',1.5)
xlim([0.023,0.027])
xtickformat('%.3f'); ytickformat('%.2f')
set(gca,'xcolor',[0 0 0],'ycolor',[0 0 0],'xminortick','on',...
    'yminortick','on','fontname','times')
print -djpeg ME_Injection
%% residual 0 limit
%figure('name','Temperature Residual met:eth zero limit')
meth_eth0 = plot(x_0lim,delta_temp0,'k','linewidth',1.5);
ax0 = ancestor(meth_eth0,'axes'); ax0.YAxis.Exponent = 0; % To remove the exponents
xtickformat('%.2f'); ytickformat('%.3f')
set(gca,'ytick',-0.006:0.001:0.006,'yminortick','on','xminortick','on',...
    'xcolor',[0 0 0],'ycolor',[0 0 0],'fontname','times','linewidth',1.5)%'xgrid','on','ygrid','on')
xlabel('x_{Methanol}','fontsize',12); 
ylabel('T_{VanLaar} - T_{Quadratic} (K)','fontsize',12)

%% 1 limit
n1 = find(x1 == 0.80); % max temp = 0.005 K
x_1lim = x1(n1:end);
temp_1lim = t_solve(n1:end);
p1 = polyfit(x_1lim,temp_1lim,2);
temp1_fit = polyval(p1,x_1lim);
delta_temp1 = temp_1lim - temp1_fit;

%figure('name','T vs x_met @ one limit')
plot(x_1lim,temp_1lim,'k-','linewidth',1.5);
hold on
xlabel('x_{Methanol}','fontsize',12)
ylabel('T (K)','fontsize',12) 
xtickformat('%.2f'); ytickformat('%.2f')
set(gca,'xcolor',[0 0 0],'ycolor',[0 0 0],'fontname','times',...
    'xminortick','on','yminortick','on','linewidth',1.5)
plot(x_1lim,temp1_fit,'r--','linewidth',3)
legend('VanLaar Equation','Quadratic Fitting')

%% residual 1 limit
%figure('name','Temperature Residual met:ace one limit')
meth_eth1 = plot(x_1lim,delta_temp1,'k','linewidth',1.5);
ax1 = ancestor(meth_eth1,'axes'); ax1.YAxis.Exponent = 0; % To remove the exponents
xtickformat('%.2f'); ytickformat('%.4f')
set(gca,'xcolor',[0 0 0],'ycolor',[0 0 0],'fontname','times',...
    'xminortick','on','yminortick','on','linewidth',1.5)%'xgrid','on','ygrid','on')
xlabel('x_{Methanol}','fontsize',12); 
ylabel('T_{VanLaar} - T_{Quadratic} (K)','fontsize',12)