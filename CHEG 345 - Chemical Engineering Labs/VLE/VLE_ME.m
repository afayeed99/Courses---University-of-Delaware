%% IMPORTANT CONSTANTS
ant_ace = [4.42448,1312.253,-32.445]; % 259.16K - 507.6K
ant_met = [5.20409,1581.341,-33.50]; % 288.1 - 356.83K
ant_eth = [5.24677,1598.673,-46.424]; % 292.77 - 366.63K

syms pres
% using syms for pres as pres varies, so bp for each may change to

bp_ace = ant_ace(2)/(ant_ace(1) - log10(pres)) - ant_ace(3); % 329.0342 K
bp_met = ant_met(2)/(ant_met(1) - log10(pres)) - ant_met(3); % 337.3650 K
bp_eth = ant_eth(2)/(ant_eth(1) - log10(pres)) - ant_eth(3); % 351.1206 K 

%true_p1 = 1.0152; % bar actual true_p1
true_p1 = 1.02810; % bar , from E of AE
true_p2 = 1.02802; % bar
avgp_me = mean([true_p1,true_p2]);
avgp_me = 1.0271; % AVERAGE P OF ALL BINARY MIXTURES

tbp_eth = eval(subs(bp_eth,pres,avgp_me));
tbp_met = eval(subs(bp_met,pres,avgp_me));

syms t
pvap_ace = (10.^(ant_ace(1) - ant_ace(2)./(t + ant_ace(3)))); % bar
pvap_met = (10.^(ant_met(1) - ant_met(2)./(t + ant_met(3))));
pvap_eth = (10.^(ant_eth(1) - ant_eth(2)./(t + ant_eth(3))));

%% EXPERIMENTAL DATA - fitting and solving for gamma inf

xm_me = [0.02026,0.03913,0.05678,0.07573,0.09228];
tm_me = [78.078,77.592,77.230,76.830,76.452]+273.15-0.1101;%extra correction from ori data w/o offsets w true bp
% originally at + 0.4316 and -0.5126 for te_me
xe_me = 1 - [0.01221,0.02373,0.03414,0.04331,0.05174];
te_me = [65.502,65.602,65.672,65.728,65.794] - 0.5126 + 273.15;

% met as solute
% p0 = polyfit(xm_me,tm_me,2);
p0 = polyfitB(xm_me,tm_me,2,tbp_eth);
% p0 = polyfitB(xm_me,tm_me,2,351.8202); % tbp from unifac
xrange = 0:0.001:0.2;
tm_me_fit = polyval(p0,xrange);

plot(xm_me,tm_me,'k^','markersize',10,'linewidth',1.5)
hold on
expe = plot(xrange,tm_me_fit,'b-','linewidth',1.5);

a_coeff(1) = p0(2);

% eth as solute
p1 = polyfit(xe_me,te_me,2);
% p1 = polyfix(xe_me,te_me,2,1,tbp_met);

xrange = 0.9:0.001:1;
te_me_fit = polyval(p1,xrange);

plot(xe_me,te_me,'k^','markersize',10,'linewidth',1.5)
hold on
expe = plot(xrange,te_me_fit,'b-','linewidth',1.5);

a_coeff(2) = -2*p1(1) - p1(2);

save coefficient_of_a_me a_coeff

%% Solving for the experimental y for ME mixture

load phicoeff
phicoeff = phi_coeff(2,:);

load gamma_infinity_me
a12 = log(gamma1_inf); a21 = log(gamma2_inf);

% m_me
xm_me = [0.02026,0.03913,0.05678,0.07573,0.09228];
tm_me = [78.078,77.592,77.230,76.830,76.452] + 0.4316 + 273.15;

x2_exp = 1 - xm_me; % essentially the ethanol mole fraction
gamma_exp = exp(a12.*((a21.*x2_exp)./(a12.*xm_me + a21.*x2_exp)).^2);
pvap_exp = eval(subs(pvap_met,t,tm_me));
phi_exp = polyval(phicoeff,tm_me);
ym_me = gamma_exp.*xm_me.*pvap_exp./phi_exp./avgp_me;
plot(ym_me,tm_me,'k^','markersize',10,'linewidth',1.5,'markerfacecolor','k')

% e_me
xe_me = [0.01221,0.02373,0.03414,0.04331,0.05174];
te_me = [65.502,65.602,65.672,65.728,65.794] - 0.5126 + 273.15;

x2_exp = 1 - xe_me; % essentially this is methanol mole fraction
gamma_exp = exp(a12.*((a21.*x2_exp)./(a12.*xe_me + a21.*x2_exp)).^2);
pvap_exp = eval(subs(pvap_eth,t,te_me));
phi_exp = polyval(phicoeff,te_me);
p = mean([true_p1,true_p2]); % bar
ye_me = gamma_exp.*xe_me.*pvap_exp./phi_exp./avgp_me;

plot(1 - ye_me,te_me,'k^','markersize',10,'linewidth',1.5,'markerfacecolor','k')
% plot w.r.t met
hold on

% fitting of y at a side
% pnew = polyfit(ym_me,tm_me,2);
pnew = polyfitB(ym_me,tm_me,2,tbp_eth);
yfit = polyval(pnew,0:0.001:0.2);
plot(0:0.001:0.2,yfit,'b--','linewidth',1.5)
%xlim([0,0.16])

% fitting of y at m side 
pnew = polyfit(1-ye_me,te_me,2);
yfit = polyval(pnew,0.8:0.001:1);
plot(0.8:0.001:1,yfit,'b--','linewidth',1.5)
% xlim([0.9,1])

save x1y1_experimental_me xm_me ym_me xe_me ye_me
%% calculating gamma inf

load coefficient_of_a_me

[dtdx1,dtdx2] = deal(a_coeff(1),a_coeff(2));

% x1 or met -> 0, T = bp_eth, 1 = met, 2 = eth
pvap1 = eval(subs(pvap_met,t,tbp_eth));
pvap2 = eval(subs(pvap_eth,t,tbp_eth));
dpvap2dt = log(10).*ant_eth(2).*pvap2./(tbp_eth - ant_eth(3)).^2;
gamma1_inf = (pvap2 - dpvap2dt*dtdx1)/pvap1;

% x2 or eth -> 0, T = bp_met, 1 = met, 2 = eth
pvap1 = eval(subs(pvap_met,t,tbp_met));
pvap2 = eval(subs(pvap_eth,t,tbp_met));
dpvap1dt = log(10).*ant_met(2).*pvap1./(tbp_met - ant_met(3)).^2;
gamma2_inf = (pvap1 - dpvap1dt*dtdx2)/pvap2;

save gamma_infinity_me gamma1_inf gamma2_inf

%% Solving using vanLaar equations - the parameters and the entire T-x curve

load phicoeff.mat

a12 = log(gamma1_inf); a21 = log(gamma2_inf);

x1 = 0:0.001:1; x2 = 1 - x1; % mol fraction
gamma1 = exp(a12.*((a21.*x2)./(a12.*x1 + a21.*x2)).^2);
gamma2 = exp(a21.*((a12.*x1)./(a12.*x1 + a21.*x2)).^2);

phicoeff = phi_coeff(2,:);
T = linspace(tbp_met,tbp_eth,length(x1));
opt = optimset('Display','notify');
t_solve = fsolve(@optimizer,T,opt,ant_met,ant_eth,x1,x2,gamma1,gamma2,phicoeff,avgp_me);

pvap1 = 10.^(ant_met(1) - ant_met(2)./(t_solve + ant_met(3)));

phival = polyval(phicoeff,t_solve); % fug. coeff. correction
y1 = gamma1.*pvap1.*x1./phival./avgp_me;

van = plot(x1,t_solve,'k-','linewidth',4);
hold on
plot(y1,t_solve,'k--','linewidth',4)
xlim([0,1]); xtickformat('%.2f'); ytickformat('%.1f');
xlabel('x_{Methanol}','fontsize',12,'fontweight','bold')
ylabel('T (K)','fontsize',12,'fontweight','bold')
set(gca,'xcolor',[0 0 0],'ycolor',[0 0 0],'fontname','times',...
    'xminortick','on','yminortick','on','fontsize',12,'linewidth',1.5)

save x1y1_vanlaar_me x1 y1

%% Solving using Wilson equations - the parameters and the entire T-x curve

syms lambda1 lambda2

eqn1 = exp(-log(lambda1) + 1 - lambda2) == gamma1_inf;
eqn2 = exp(-log(lambda2) + 1 - lambda1) == gamma2_inf;

sol = solve([eqn1,eqn2],[lambda1,lambda2]);
param1 = eval(sol.lambda1); param2 = eval(sol.lambda2);

x1 = 0:0.001:1; x2 = 1 - x1; % mol fraction
gamma1 = exp(-log(x1 + x2.*param1) + x2.*(param1./(x1 + x2.*param1) - param2./(x1.*param2 + x2)));
gamma2 = exp(-log(x2 + x1.*param2) - x1.*(param1./(x1 + x2.*param1) - param2./(x1.*param2 + x2)));

T = linspace(tbp_met,tbp_eth,length(x1));
opt = optimset('Display','notify');
t_solve = fsolve(@optimizer,T,opt,ant_met,ant_eth,x1,x2,gamma1,gamma2,phicoeff,avgp_me);

pvap1 = 10.^(ant_met(1) - ant_met(2)./(t_solve + ant_met(3)));

phival = polyval(phicoeff,t_solve); % fug. coeff. correction of met
y1 = gamma1.*pvap1.*x1./phival./avgp_me;

wils = plot(x1,t_solve,'r-','linewidth',1.5);
hold on
plot(y1,t_solve,'r--','linewidth',1.5)
xlim([0,1]); xtickformat('%.2f'); ytickformat('%.1f');
xlabel('x_{Methanol}','fontsize',12,'fontweight','bold')
ylabel('T (K)','fontsize',12,'fontweight','bold')
set(gca,'xcolor',[0 0 0],'ycolor',[0 0 0],'fontname','times',...
    'xminortick','on','yminortick','on','fontsize',12,'linewidth',1.5)

save x1y1_wilson_me x1 y1
%% x-y plot

% x-y of vanlaar
load x1y1_vanlaar_me

van = plot(x1,y1,'k-','linewidth',4);
hold on
plot([0,1],[0,1],'k--','linewidth',1.5)

% x-y of Wilson
load x1y1_wilson_me

wilson = plot(x1,y1,'r-','linewidth',1.5);

% Literature data of x and y values
load literature_data_x1y1_me

plot(x1a,y1a,'kd','markersize',10,'linewidth',1.5)
plot(x1b,y1b,'ks','markersize',10,'linewidth',1.5,'markerfacecolor','k')

% Experimental data
load x1y1_experimental_me

plot(xm_me,ym_me,'ko','markersize',10,'linewidth',1.5)
plot(1-ye_me,1 - ye_me,'ko','markersize',10,'linewidth',1.5)

xlim([0,1]); ylim([0,1])
xtickformat('%.2f'); ytickformat('%.1f');
legend([van,wilson],'van Laar','Wilson','location','northwest')
xlabel('x_{Methanol}','fontsize',12,'fontweight','bold')
ylabel('y_{Methanol}','fontsize',12,'fontweight','bold')
set(gca,'xcolor',[0 0 0],'ycolor',[0 0 0],'fontname','times',...
    'xminortick','on','yminortick','on','fontsize',12,'linewidth',1.5)
print -djpeg xy_ME
%% Literature data

% P = 760 mmHg, https://doi.org/10.1021/ie50553a041
T1 = [78.3	76.6	75	73.6	72.3	71.7	70	68.6	67.7	66.9...
    66.6	65.8	65.6	64.6] + 273.15;
x1a = [0	0.134	0.242	0.32	0.401	0.435	0.542	0.652	0.728	0.79...
    0.814	0.873	0.91	1];
y1a = [0	0.183	0.326	0.428	0.529	0.566	0.676	0.759	0.813	0.858...
    0.875	0.919	0.937	1];

plot(x1a,T1,'kd','markersize',10,'linewidth',1.5)
plot(y1a,T1,'kd','markersize',10,'linewidth',1.5,'markerfacecolor','k')

% p = .9987 bar, vle in binary systems of diploma thesis
T2 = [65.42	66.25	67.11	69.17	70.94	72.54	73.38	74.04	74.78...
    75.28	75.79	76.39	77.15	77.39] + 273.15;
x1b = [0.8562	0.7968	0.6547	0.5413	0.4851	0.3624	0.3222	0.2502	0.2234...
    0.1799	0.1266	0.139	0.0768	0.0645];
y1b = [0.9128	0.8678	0.7559	0.6547	0.5439	0.4795	0.4035	0.3118	0.2834...
    0.2464	0.1879	0.1059	0.048	0.0645];

plot(x1b,T2,'ks','markersize',10,'linewidth',1.5)
plot(y1b,T2,'ks','markersize',10,'linewidth',1.5,'markerfacecolor','k')
legend([van,wils],'van Laar','Wilson','fontsize',12)
%legend([van,wils,expe],'van Laar','Wilson','Experimental','fontsize',12)
%legend([van,wils,expe],'van Laar','Wilson','Experimental','fontsize',12,'location','northwest')
% xlim([0,0.2]); xlim([0.8,1]);
save literature_data_x1y1_me x1a y1a x1b y1b