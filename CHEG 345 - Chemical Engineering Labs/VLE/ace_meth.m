ant_ace = [4.42448,1312.253,-32.445]; % 259.16K - 507.6K
ant_met = [5.20409,1581.341,-33.50]; % 288.1 - 356.83K
ant_eth = [5.24677,1598.673,-46.424]; % 292.77 - 366.63K

%%
pres = 1; % antoine should be in bar

bp_ace = ant_ace(2)/(ant_ace(1) - log10(pres)) - ant_ace(3); % 329.0342 K
bp_met = ant_met(2)/(ant_met(1) - log10(pres)) - ant_met(3); % 337.3650 K
bp_eth = ant_eth(2)/(ant_eth(1) - log10(pres)) - ant_eth(3); % 351.1206 K 

mw_ace = 58.08; %g/mol
mw_met = 32.04;
mw_eth = 46.07;

rho_ace = 749.4:-0.01:721.2; %kg/m^3
rho_met = 756.6:-0.01:733.782; % weird, only reach about 63.4 C then start to drop instantly! use diff website
rho_eth = 758.1:-0.01:736.2;

mol_vol_ace = mw_ace./rho_ace./1000; %m^3/mol
mol_vol_met = mw_met./rho_met./1000;
mol_vol_eth = mw_eth./rho_eth./1000;

t_a = linspace(329,352,length(mol_vol_ace)); 
t_m = linspace(329,352,length(mol_vol_met)); % 56 C - 79 C range tmeperature
t_e = linspace(329,352,length(mol_vol_eth));
ptotal = 1e5;

    pvap_ace = (10.^(ant_ace(1) - ant_ace(2)./(t_a + ant_ace(3)))).*1e5;
    poynting_ace = exp(mol_vol_ace.*(ptotal - pvap_ace)./8.314./t_a);



    pvap_met = (10.^(ant_met(1) - ant_met(2)./(t_m + ant_met(3)))).*1e5;
    poynting_met = exp(mol_vol_met.*(ptotal - pvap_met)./8.314./t_m);



    pvap_eth = (10.^(ant_eth(1) - ant_eth(2)./(t_e + ant_eth(3)))).*1e5;
    poynting_eth = exp(mol_vol_eth.*(ptotal - pvap_eth)./8.314./t_e);

plot(t_a,poynting_ace,'k','linewidth',1.5);
hold on
plot(t_m,poynting_met,'r','linewidth',1.5);
plot(t_e,poynting_eth,'b','linewidth',1.5);
plot([325,355],[1,1],'k--','linewidth',1.5);
xtickformat('%.2f'); ytickformat('%.4f');
xlabel('Temperature (K)','fontsize',12)
ylabel('Poynting Pressure Correction','fontsize',12)
legend('Acetone','Methanol','Ethanol')
set(gca,'xcolor',[0 0 0],'ycolor',[0 0 0],'fontname','times',...
    'xminortick','on','yminortick','on','linewidth',1.5)
% print -djpeg Poynting_correction
%% ACETONE:METHANOL (AM)
% UNIFAC
pres = 1; % antoine should be in bar

bp_ace = ant_ace(2)/(ant_ace(1) - log10(pres)) - ant_ace(3); % 329.0342 K
bp_met = ant_met(2)/(ant_met(1) - log10(pres)) - ant_met(3); % 337.3650 K
bp_eth = ant_eth(2)/(ant_eth(1) - log10(pres)) - ant_eth(3); % 351.1206 K 

binary_aceMet = dlmread('binary_ace_met.txt','',2,0);
x_ace = binary_aceMet(:,2);
gamma_ace = binary_aceMet(:,6);
gamma_met = binary_aceMet(:,7);

%figure('name','Activity Coefficient vs. x_ace AM (UNIFAC)')
plot(x_ace,gamma_ace,'k','linewidth',1.5);
hold on
plot(x_ace,gamma_met,'r','linewidth',1.5);
%hold off
xtickformat('%.2f'); ytickformat('%.2f');
xlabel('x_{Acetone}','fontsize',12)
ylabel('\bf\gamma','fontsize',12)
legend('\bf\gamma_{Acetone}','\bf\gamma_{Methanol}','location','north')
set(gca,'xcolor',[0 0 0],'ycolor',[0 0 0],'fontname','times',...
    'xminortick','on','yminortick','on','linewidth',1.5)
%% vanlaar
gamma_inf_aceAM = gamma_ace(1); gamma_inf_metAM = gamma_met(end);

% VanLaar Parameters (1 - acetone, 2 - methanol)
A12_AM = log(gamma_inf_aceAM);  A21_AM = log(gamma_inf_metAM);

x1 = 0:0.001:1; x2 = 1 - x1; % mol fraction

gamma1_AM = exp(A12_AM.*((A21_AM.*x2)./(A12_AM.*x1 + A21_AM.*x2)).^2);
gamma2_AM = exp(A21_AM.*((A12_AM.*x1)./(A12_AM.*x1 + A21_AM.*x2)).^2);

%figure('name','Activity Coefficient vs. x_ace AM (VanLaar)')
plot(x1,gamma1_AM,'k','linewidth',1.5)
hold on
plot(x1,gamma2_AM,'r','linewidth',1.5)
hold off
xtickformat('%.2f'); ytickformat('%.2f');
xlabel('x_{Acetone}','fontsize',12)
ylabel('\bf\gamma','fontsize',12)
legend('\bf\gamma_{Acetone}','\bf\gamma_{Methanol}','location','north')
set(gca,'xcolor',[0 0 0],'ycolor',[0 0 0],'fontname','times',...
    'xminortick','on','yminortick','on','linewidth',1.5)

%% T vs. x VANLAAR
%figure('name','T vs. x_ace AM (VanLaar)')
load phicoeff.mat
phicoeff = phi_coeff(1,:);
T = linspace(bp_ace,bp_met,length(x1));
opt = optimset('Display','notify');
t_solve = fsolve(@optimizer,T,opt,ant_ace,ant_met,x1,x2,gamma1_AM,gamma2_AM,phicoeff,pres);

pvap1 = 10.^(ant_ace(1) - ant_ace(2)./(t_solve + ant_ace(3)));
y1 = gamma1_AM.*pvap1.*x1;
plot(x1,t_solve,'k-','linewidth',1.5)
hold on
plot(y1,t_solve,'b-','linewidth',1.5)
legend('Liquid Composition','Vapor Composition')
xtickformat('%.2f'); ytickformat('%.2f');
xlabel('x_{Acetone}','fontsize',12)
ylabel('T (K)','fontsize',12)
set(gca,'xcolor',[0 0 0],'ycolor',[0 0 0],'fontname','times',...
    'xminortick','on','yminortick','on','linewidth',1.5)
xlim([0,1])

% xa_am = [0.01638,0.03114,0.04637,0.06111,0.07329]
% xm_am = 0.9656    0.9335    0.9017    0.8718    0.8448
t1_am_unifac = [t_solve(x1 == 0.016),t_solve(x1 == 0.031),t_solve(x1 == 0.046),...
    t_solve(x1 == 0.061),t_solve(x1 == 0.073)];
t2_am_unifac = [t_solve(x1 == 0.966),t_solve(x1 == 0.933),t_solve(x1 == 0.902),...
    t_solve(x1 == 0.872),t_solve(x1 == 0.845)];

save TEMP_UNIFAC_AM_ACETONE t1_am_unifac
save TEMP_UNIFAC_AM_METHANOL t2_am_unifac
%hold off
%print -djpeg '/Users/fayeed/Desktop/SPRING 2021/CHEG 345 -JLab/VLE/Acetone Methanol/T_xAM.JPEG'
%%
xa_am = [0.01638,0.03114,0.04637,0.06111,0.07329]; % mol frac a in am
ta_am = [63.886,62.988,62.214,61.634,61.18] + 0.7936 + 273.15; % deg K

xm_am = 1 - [0.03441,0.06648,0.09834,0.12816,0.15522]; % make x1 w.r.t ace
tm_am = [56.462,56.252,56.094,56.04,55.964] + 0.0577 + 273.15;

% CONSIDER TO FIT AT FIXED INTERCEPT OR NOT LATER
% ace as solute
p0 = polyfit(xa_am,ta_am,2);
xrange = 0:0.001:0.1;
ta_am_fit = polyval(p0,xrange);
a_coeff(1) = p0(2);

plot(xa_am,ta_am,'ro','markersize',8,'linewidth',1.5)
hold on
plot(xrange,ta_am_fit,'k--','linewidth',1.5)

% met as solute
p1 = polyfit(xm_am,tm_am,2);
xrange = 0.8:0.001:1;
tm_am_fit = polyval(p1,xrange);

plot(xm_am,tm_am,'ro','markersize',8,'linewidth',1.5)
hold on
plot(xrange,tm_am_fit,'k--','linewidth',1.5)

a_coeff(2) = -2*p1(1) - p1(2);
%% y vs x curve
plot(x1,y1,'k','linewidth',1.5)
hold on
real_eq = plot([0,1],[0,1],'k--');
xtickformat('%.2f'); ytickformat('%.2f');
xlabel('x_{Acetone}','fontsize',12)
ylabel('y_{Acetone}','fontsize',12)
set(gca,'xcolor',[0 0 0],'ycolor',[0 0 0],'fontname','times',...
    'xminortick','on','yminortick','on','linewidth',1.5)
legend(real_eq,'y_{Acetone} = x_{Acetone}','location','northwest')
axis([0,1,0,1])
%print -djpeg '/Users/fayeed/Desktop/SPRING 2021/CHEG 345 -JLab/VLE/Acetone Methanol/y_xAM.jpeg'
%% 0 limit 
n0 = find(x1 == 0.112); % max temp = 0.005 K
x_0lim = x1(1:n0);
temp_0lim = t_solve(1:n0);
p0 = polyfit(x_0lim,temp_0lim,2);
temp0_fit = polyval(p0,x_0lim);
delta_temp0 = temp_0lim - temp0_fit;

%figure('name','T vs x_ace @ zero limit')
plot(x_0lim,temp_0lim,'k-','linewidth',1.5);
hold on
xlabel('x_{Acetone}','fontsize',12)
ylabel('T (K)','fontsize',12) 
xtickformat('%.2f'); ytickformat('%.2f')
set(gca,'xcolor',[0 0 0],'ycolor',[0 0 0],'fontname','times',...
    'xminortick','on','yminortick','on','linewidth',1.5)
plot(x_0lim,temp0_fit,'r--','linewidth',3)
legend('VanLaar Equation','Quadratic Fitting')

%% Injection size
m = 0:0.01:0.112;
k = 0:0.03:0.112;
y = p0(1).*m.^2 + p0(2).*m + p0(3);
z = p0(1).*k.^2 + p0(2).*k + p0(3);
a = plot(x_0lim,temp_0lim,'k','linewidth',1);
hold on
b = plot(m,y,'bo--','linewidth',1.5);
c = plot(k,z,'r*--','linewidth',1.5);

xlim([0,0.03])
plot([0.013,0.015],[336.9,336.9],'k','linewidth',1.5)
plot([0.013,0.015],[337,337],'k','linewidth',1.5)
plot([0.013,0.013],[336.9,337],'k','linewidth',1.5)
plot([0.015,0.015],[336.9,337],'k','linewidth',1.5)
legend([a,b,c],'Quadratic Fitting','Injection of x_{Acetone} = 0.01','Injection of x_{Acetone} = 0.03')
xtickformat('%.3f'); ytickformat('%.2f')
xlabel('x_{Acetone}','fontsize',12)
ylabel('T (K)','fontsize',12) 
set(gca,'xcolor',[0 0 0],'ycolor',[0 0 0],'xminortick','on',...
    'yminortick','on','fontname','times')
axes('position',[0.3 0.25 0.2 0.2])
plot(x_0lim,temp_0lim,'k','linewidth',1);
hold on
plot(m,y,'bo--','linewidth',1.5)
plot(k,z,'r*--','linewidth',1.5)
xlim([0.013,0.015])
xtickformat('%.3f'); ytickformat('%.2f')
set(gca,'xcolor',[0 0 0],'ycolor',[0 0 0],'xminortick','on',...
    'yminortick','on','fontname','times')
print -djpeg AM_Injection

%% residual 0 limit
%figure('name','Temperature Residual ace:met zero limit')
ace_meth0 = plot(x_0lim,delta_temp0,'k','linewidth',1.5);
ax0 = ancestor(ace_meth0,'axes'); ax0.YAxis.Exponent = 0; % To remove the exponents
xtickformat('%.2f'); ytickformat('%.3f')
set(gca,'xcolor',[0 0 0],'ycolor',[0 0 0],'fontname','times',...
    'xminortick','on','yminortick','on','linewidth',1.5)%'xgrid','on','ygrid','on')
xlabel('x_{Acetone}','fontsize',12); 
ylabel('T_{VanLaar} - T_{Quadratic} (K)','fontsize',12)

%% 1 limit
n1 = find(x1 == 0.846); % max temp = 0.005 K
x_1lim = x1(n1:end);
temp_1lim = t_solve(n1:end);
p1 = polyfit(x_1lim,temp_1lim,2);
temp1_fit = polyval(p1,x_1lim);
delta_temp1 = temp_1lim - temp1_fit;

%figure('name','T vs x_ace @ one limit')
plot(x_1lim,temp_1lim,'k-','linewidth',1.5);
hold on
xlabel('x_{Acetone}','fontsize',12)
ylabel('T (K)','fontsize',12) 
xtickformat('%.2f'); ytickformat('%.2f')
set(gca,'xcolor',[0 0 0],'ycolor',[0 0 0],'fontname','times',...
    'xminortick','on','yminortick','on','linewidth',1.5)
plot(x_1lim,temp1_fit,'r--','linewidth',3)
legend('VanLaar Equation','Quadratic Fitting')

%% residual 1 limit
%figure('name','Temperature Residual ace:met one limit')
ace_meth1 = plot(x_1lim,delta_temp1,'k','linewidth',1.5);
ax1 = ancestor(ace_meth1,'axes'); ax1.YAxis.Exponent = 0; % To remove the exponents
xtickformat('%.2f'); ytickformat('%.3f')
set(gca,'xcolor',[0 0 0],'ycolor',[0 0 0],'fontname','times',...
    'xminortick','on','yminortick','on','linewidth',1.5)%'xgrid','on','ygrid','on')
xlabel('x_{Acetone}','fontsize',12); 
ylabel('T_{VanLaar} - T_{Quadratic} (K)','fontsize',12)

%% gamma infinity vs P/T

t_range = 293:0.01:373; %20 - 100 C
pvap_a = 10.^(ant_ace(1) - ant_ace(2)./(t_range + ant_ace(3)));
pvap_m = 10.^(ant_met(1) - ant_met(2)./(t_range + ant_met(3)));
pvap_e = 10.^(ant_eth(1) - ant_eth(2)./(t_range + ant_eth(3)));

dpvap_dt_a = log(10).*ant_ace(2).*pvap_a./((t_range + ant_ace(3)).^2);
dpvap_dt_m = log(10).*ant_met(2).*pvap_m./((t_range + ant_met(3)).^2);
dpvap_dt_e = log(10).*ant_eth(2).*pvap_e./((t_range + ant_eth(3)).^2);

% for x1 -> 0

t1 = bp_met;
p1vap = 10.^(ant_ace(1) - ant_ace(2)./(t1 + ant_ace(3)));
p2vap = 10.^(ant_met(1) - ant_met(2)./(t1 + ant_met(3)));
dtdx1 = (p2vap - gamma_inf_aceAM*p1vap)*(t1 + ant_met(3))^2/...
    (log(10)*ant_met(2)*p2vap);

% for x2 -> 0
t2 = bp_ace;
p1vap = 10.^(ant_ace(1) - ant_ace(2)./(t2 + ant_ace(3)));
p2vap = 10.^(ant_met(1) - ant_met(2)./(t2 + ant_met(3)));
dtdx2 = (p1vap - gamma_inf_metAM*p2vap)*(t2 + ant_ace(3))^2/...
    (log(10)*ant_ace(2)*p1vap);

%% gamma inf vs T

gammainf_a_am = (pvap_m - dpvap_dt_m.*dtdx1)./pvap_a;
gammainf_m_am = (pvap_a - dpvap_dt_a.*dtdx2)./pvap_m;

plot(t_range,gammainf_a_am,'b','linewidth',1.5)
hold on
plot(t_range,gammainf_m_am,'r','linewidth',1.5)
plot([330,355],[1.4,1.4],'k-','linewidth',1)
plot([330,355],[1.9,1.9],'k-','linewidth',1)
plot([330,330],[1.4,1.9],'k-','linewidth',1)
plot([355,355],[1.4,1.9],'k-','linewidth',1)
hold off
xtickformat('%.2f'); ytickformat('%.2f');
xlabel('T (K)','fontsize',12)
ylabel('\bf\gamma^{\infty}','fontsize',12)
legend('\bf\gamma^{\infty}_{Acetone}','\bf\gamma^{\infty}_{Methanol}')
set(gca,'xcolor',[0 0 0],'ycolor',[0 0 0],'fontname','times',...
    'xminortick','on','yminortick','on')
axes('position',[0.45 0.6 0.25 0.25])
plot(t_range,gammainf_a_am,'b','linewidth',1.5)
hold on
plot(t_range,gammainf_m_am,'r','linewidth',1.5)
xtickformat('%.1f'); ytickformat('%.2f');
xlim([330,355])
set(gca,'xcolor',[0 0 0],'ycolor',[0 0 0],'fontname','times',...
    'xminortick','on','yminortick','on')
hold off

print -djpeg gammainf_am_T

%% gamma inf vs P
plot(pvap_m,gammainf_a_am,'b','linewidth',1.5)
hold on
plot(pvap_a,gammainf_m_am,'r','linewidth',1.5)
plot([0.95,1.05],[1.72,1.72],'k-','linewidth',1)
plot([0.95,1.05],[1.76,1.76],'k-','linewidth',1)
plot([0.95,0.95],[1.72,1.76],'k-','linewidth',1)
plot([1.05,1.05],[1.72,1.76],'k-','linewidth',1)
hold off
xtickformat('%.1f'); ytickformat('%.2f');
xlabel('P (bar)','fontsize',12)
ylabel('\bf\gamma^{\infty}','fontsize',12)
legend('\bf\gamma^{\infty}_{Acetone}','\bf\gamma^{\infty}_{Methanol}')
set(gca,'xcolor',[0 0 0],'ycolor',[0 0 0],'fontname','times',...
    'xminortick','on','yminortick','on')
axes('position',[0.45 0.6 0.25 0.25])
plot(pvap_m,gammainf_a_am,'b','linewidth',1.5)
hold on
plot(pvap_a,gammainf_m_am,'r','linewidth',1.5)
xtickformat('%.2f'); ytickformat('%.2f');
xlim([0.95,1.05])
set(gca,'xcolor',[0 0 0],'ycolor',[0 0 0],'fontname','times',...
    'xminortick','on','yminortick','on')

print -djpeg gammainf_am_P