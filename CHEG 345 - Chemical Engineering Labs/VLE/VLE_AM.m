%% IMPORTANT CONSTANTS
ant_ace = [4.42448,1312.253,-32.445]; % 259.16K - 507.6K
ant_met = [5.20409,1581.341,-33.50]; % 288.1 - 356.83K
ant_eth = [5.24677,1598.673,-46.424]; % 292.77 - 366.63K

syms pres
% using syms for pres as pres varies, so bp for each may change to

bp_ace = ant_ace(2)/(ant_ace(1) - log10(pres)) - ant_ace(3); % 329.0342 K
bp_met = ant_met(2)/(ant_met(1) - log10(pres)) - ant_met(3); % 337.3650 K
bp_eth = ant_eth(2)/(ant_eth(1) - log10(pres)) - ant_eth(3); % 351.1206 K 

true_p1 = 1.0244; % bar, DEOS DATA
true_p2 = 1.0238; % bar, DEOS DATA
avgp_am = mean([true_p1,true_p2]);
avgp_am = 1.0271; % AVERAGE P OF ALL BINARY MIXTURES

tbp_met = eval(subs(bp_met,pres,avgp_am));
tbp_ace = eval(subs(bp_ace,pres,avgp_am));

syms t
pvap_ace = (10.^(ant_ace(1) - ant_ace(2)./(t + ant_ace(3)))); % bar
pvap_met = (10.^(ant_met(1) - ant_met(2)./(t + ant_met(3))));
pvap_eth = (10.^(ant_eth(1) - ant_eth(2)./(t + ant_eth(3))));

%% EXPERIMENTAL DATA - fitting and solving for gamma inf

xa_am = [0.01638,0.03114,0.04637,0.06111,0.07329]; % mol frac a in am
ta_am = [63.886,62.988,62.214,61.634,61.18] + 273.15; % deg K + 0.7936

xm_am = 1 - [0.03441,0.06648,0.09834,0.12816,0.15522]; % make x1 w.r.t ace
tm_am = [56.462+0.2463/16,56.252+0.2463/8,56.094+0.2463/4,56.04+0.2463/2,55.964+0.2463] + 273.15; % - 0.2463

load TEMP_UNIFAC_AM_ACETONE
diff_ta_am = ta_am - t1_am_unifac;
ta_am = ta_am - diff_ta_am;
load TEMP_UNIFAC_AM_METHANOL
diff_tm_am = tm_am - t2_am_unifac;
% tm_am = tm_am - diff_tm_am+ 0.7936;
% ace as solute
% p0 = polyfitB(xa_am,ta_am,2,tbp_met);
% p0 = polyfitB(xa_am,ta_am,2,338.5);

p0 = polyfit(xa_am,ta_am,2);
xrange = 0:0.001:0.2;
ta_am_fit = polyval(p0,xrange);

plot(xa_am,ta_am,'k^','markersize',10,'linewidth',1.5)
hold on
expe = plot(xrange,ta_am_fit,'b-','linewidth',1.5);

a_coeff(1) = p0(2);

% met as solute
p1 = polyfit(xm_am,tm_am,2);
% p1 = polyfix(xm_am,tm_am,2,1,tbp_ace-0.1201);
% p1 = polyfix(xm_am,tm_am,2,1,tbp_ace);

xrange = 0.8:0.001:1;
tm_am_fit = polyval(p1,xrange);

plot(xm_am,tm_am,'k^','markersize',10,'linewidth',1.5)
hold on
expe = plot(xrange,tm_am_fit,'b-','linewidth',1.5);

a_coeff(2) = -2*p1(1) - p1(2);

save coefficient_of_a_am a_coeff

%% Solving for the experimental y for AM mixture

load phicoeff
phicoeff = phi_coeff(1,:);

load gamma_infinity_am
a12 = log(gamma1_inf); a21 = log(gamma2_inf);

% a_am
xa_am = [0.01638,0.03114,0.04637,0.06111,0.07329]; % mol frac a in am
ta_am = [63.886,62.988,62.214,61.634,61.18] + 0.7936 + 273.15; % deg K
ta_am = ta_am - diff_ta_am;
x2_exp = 1 - xa_am; % essentially the methanol mole fraction
gamma_exp = exp(a12.*((a21.*x2_exp)./(a12.*xa_am + a21.*x2_exp)).^2);
pvap_exp = eval(subs(pvap_ace,t,ta_am));
phi_exp = polyval(phicoeff,ta_am);
ya_am = gamma_exp.*xa_am.*pvap_exp./phi_exp./avgp_am;
plot(ya_am,ta_am,'k^','markersize',10,'linewidth',1.5,'markerfacecolor','k')
hold on

% m_am
xm_am = [0.03441,0.06648,0.09834,0.12816,0.15522]; 
tm_am = [56.462,56.252,56.094,56.04,55.964] - 0.2463 + 273.15;
tm_am = [56.462+0.2463/16,56.252+0.2463/8,56.094+0.2463/4,56.04+0.2463/2,55.964+0.2463] + 273.15; % - 0.2463

x2_exp = 1 - xm_am; % essentially this is acetone mole fraction
gamma_exp = exp(a12.*((a21.*x2_exp)./(a12.*xm_am + a21.*x2_exp)).^2);
pvap_exp = eval(subs(pvap_met,t,tm_am));
phi_exp = polyval(phicoeff,tm_am);
ym_am = gamma_exp.*xa_am.*pvap_exp./phi_exp./avgp_am; % this is

plot(1 - ym_am,tm_am,'k^','markersize',10,'linewidth',1.5,'markerfacecolor','k')
% plot w.r.t ace
hold on

% fitting of y at a side
pnew = polyfit(ya_am,ta_am,2);
yfit = polyval(pnew,0:0.001:0.2);
plot(0:0.001:0.2,yfit,'b--','linewidth',1.5)
% xlim([0,0.1])

% fitting of y at m side 
pnew = polyfit(1-ym_am,tm_am,2);
yfit = polyval(pnew,0.8:0.001:1);
plot(0.8:0.001:1,yfit,'b--','linewidth',1.5)
% xlim([0.8,1])

save x1y1_experimental_am xa_am ya_am xm_am ym_am
%% calculating gamma inf
load coefficient_of_a_am

[dtdx1,dtdx2] = deal(a_coeff(1),a_coeff(2));

% x1 or ace -> 0, T = bp_met, 1 = ace, 2 = met
pvap1 = eval(subs(pvap_ace,t,tbp_met));
pvap2 = eval(subs(pvap_met,t,tbp_met));
dpvap2dt = log(10).*ant_met(2).*pvap2./(tbp_met - ant_met(3)).^2;
gamma1_inf = (pvap2 - dpvap2dt*dtdx1)/pvap1;

% x2 or met -> 0, T = bp_ace, 1 = ace, 2 = met
pvap1 = eval(subs(pvap_ace,t,tbp_ace));
pvap2 = eval(subs(pvap_met,t,tbp_ace));
dpvap1dt = log(10).*ant_ace(2).*pvap1./(tbp_ace - ant_ace(3)).^2;
gamma2_inf = (pvap1 - dpvap1dt*dtdx2)/pvap2;

save gamma_infinity_am gamma1_inf gamma2_inf

%% Solving using vanLaar equations - the parameters and the entire T-x curve
load phicoeff.mat

a12 = log(gamma1_inf); a21 = log(gamma2_inf);

x1 = 0:0.001:1; x2 = 1 - x1; % mol fraction
gamma1 = exp(a12.*((a21.*x2)./(a12.*x1 + a21.*x2)).^2);
gamma2 = exp(a21.*((a12.*x1)./(a12.*x1 + a21.*x2)).^2);

phicoeff1 = phi_coeff(1,:); phicoeff2 = phi_coeff(2,:);
T = linspace(tbp_ace,tbp_met,length(x1));
opt = optimset('Display','notify');
t_solve = fsolve(@optimizer,T,opt,ant_ace,ant_met,x1,x2,gamma1,gamma2,...
    phicoeff1,avgp_am);
% t_solve = fsolve(@optimizer,T,opt,ant_ace,ant_met,x1,x2,gamma1,gamma2,phicoeff1,phicoeff2,avgp_am);

pvap1 = 10.^(ant_ace(1) - ant_ace(2)./(t_solve + ant_ace(3)));

phival = polyval(phicoeff1,t_solve); % fug. coeff. correction of ace
y1 = gamma1.*pvap1.*x1./phival./avgp_am; % phi is vap/sat

van = plot(x1,t_solve,'k-','linewidth',4);
hold on
plot(y1,t_solve,'k--','linewidth',4)
xlim([0,1])
xtickformat('%.2f'); ytickformat('%.1f');
xlabel('x_{Acetone}','fontsize',12,'fontweight','bold')
ylabel('T (K)','fontsize',12,'fontweight','bold')
set(gca,'xcolor',[0 0 0],'ycolor',[0 0 0],'fontname','times',...
    'xminortick','on','yminortick','on','fontsize',12,'linewidth',1.5)

save x1y1_vanlaar_am x1 y1

%% Solving using Wilson equations - the parameters and the entire T-x curve

syms lambda1 lambda2

eqn1 = exp(-log(lambda1) + 1 - lambda2) == gamma1_inf;
eqn2 = exp(-log(lambda2) + 1 - lambda1) == gamma2_inf;

sol = solve([eqn1,eqn2],[lambda1,lambda2]);
param1 = eval(sol.lambda1); param2 = eval(sol.lambda2);

x1 = 0:0.001:1; x2 = 1 - x1; % mol fraction
gamma1 = exp(-log(x1 + x2.*param1) + x2.*(param1./(x1 + x2.*param1) - param2./(x1.*param2 + x2)));
gamma2 = exp(-log(x2 + x1.*param2) - x1.*(param1./(x1 + x2.*param1) - param2./(x1.*param2 + x2)));
phicoeff = phi_coeff(1,:);
T = linspace(tbp_ace,tbp_met,length(x1));
opt = optimset('Display','notify');
t_solve = fsolve(@optimizer,T,opt,ant_ace,ant_met,x1,x2,gamma1,gamma2,phicoeff,avgp_am);

pvap1 = 10.^(ant_ace(1) - ant_ace(2)./(t_solve + ant_ace(3)));

phival = polyval(phicoeff,t_solve); % fug. coeff. correction of ace
y1 = gamma1.*pvap1.*x1./phival./avgp_am;

wils = plot(x1,t_solve,'r-','linewidth',1.5);
hold on
plot(y1,t_solve,'r--','linewidth',1.5)
xlim([0,1])
xtickformat('%.2f'); ytickformat('%.1f');
xlabel('x_{Acetone}','fontsize',12,'fontweight','bold')
ylabel('T (K)','fontsize',12,'fontweight','bold')
set(gca,'xcolor',[0 0 0],'ycolor',[0 0 0],'fontname','times',...
    'xminortick','on','yminortick','on','fontsize',12,'linewidth',1.5)

save x1y1_wilson_am x1 y1
%% x-y plot

% x-y of vanlaar
load x1y1_vanlaar_am

van = plot(x1,y1,'k-','linewidth',4);
hold on
plot([0,1],[0,1],'k--','linewidth',1.5)

% x-y of Wilson
load x1y1_wilson_am

wilson = plot(x1,y1,'r-','linewidth',1.5);

% Literature data of x and y values
load literature_data_x1y1_am

plot(x1a,y1a,'kd','markersize',10,'linewidth',1.5)
plot(x1b,y1b,'ks','markersize',10,'linewidth',1.5,'markerfacecolor','k')

% Experimental data
load x1y1_experimental_am

plot(xa_am,ya_am,'ko','markersize',10,'linewidth',1.5)
plot(1-ym_am,1 - ym_am,'ko','markersize',10,'linewidth',1.5)

xlim([0,1]); ylim([0,1])
xtickformat('%.2f'); ytickformat('%.1f');
legend([van,wilson],'van Laar','Wilson','location','northwest')
xlabel('x_{Acetone}','fontsize',12,'fontweight','bold')
ylabel('y_{Acetone}','fontsize',12,'fontweight','bold')
set(gca,'xcolor',[0 0 0],'ycolor',[0 0 0],'fontname','times',...
    'xminortick','on','yminortick','on','fontsize',12,'linewidth',1.5)

%% Literature data

% P = 760 mmHg, https://doi.org/10.1021/ie50553a041
T1 = [64.6	63.5	62.2	60.7	59.4	58.1	56.9	56.2	55.9...
    55.8	55.8	55.8	55.8	56.1] + 273.15;
x1a = [0	0.036	0.081	0.141	0.206	0.293	0.394	0.513	0.584...
    0.683	0.742	0.823	0.861	1];
y1a = [0	0.082	0.161	0.251	0.336	0.423	0.5	0.58	0.639	0.705...
    0.745	0.806	0.843	1];

plot(x1a,T1,'kd','markersize',10,'linewidth',1.5)
plot(y1a,T1,'kd','markersize',10,'linewidth',1.5,'markerfacecolor','k')

% P = 1 atm, https://doi.org/10.1016/S0378-3812(96)03183-4
T2 = [62.9	61.7	60.8	59.9	59	58.3	57.8	57.2	56.8	56.4...
    56.2	55.7	55.5	55.4	55.3	55.3	55.2	55.3	55.5] + 273.15;
x1b = 1 - [0.959	0.911	0.87	0.825	0.77	0.724	0.676	0.624	0.577...
    0.525	0.48	0.382	0.334	0.285	0.225	0.192	0.19	0.111	0.062];
y1b = 1 - [0.915	0.83	0.768	0.71	0.648	0.601	0.558	0.515	0.479...
    0.44	0.407	0.337	0.302	0.266	0.219	0.192	0.19	0.119	0.069];

plot(x1b,T2,'ks','markersize',10,'linewidth',1.5)
plot(y1b,T2,'ks','markersize',10,'linewidth',1.5,'markerfacecolor','k')
legend([van,wils],'van Laar','Wilson','fontsize',12)
%legend([van,wils,expe],'van Laar','Wilson','Experimental','fontsize',12)
%legend([van,wils,expe],'van Laar','Wilson','Experimental','fontsize',12,'location','northwest')
% xlim([0,0.2]); xlim([0.8,1]);
save literature_data_x1y1_am x1a y1a x1b y1b