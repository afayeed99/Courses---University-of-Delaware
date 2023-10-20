%% IMPORTANT CONSTANTS
ant_ace = [4.42448,1312.253,-32.445]; % 259.16K - 507.6K
ant_met = [5.20409,1581.341,-33.50]; % 288.1 - 356.83K
ant_eth = [5.24677,1598.673,-46.424]; % 292.77 - 366.63K

syms pres
% using syms for pres as pres varies, so bp for each may change to

bp_ace = ant_ace(2)/(ant_ace(1) - log10(pres)) - ant_ace(3); % 329.0342 K
bp_met = ant_met(2)/(ant_met(1) - log10(pres)) - ant_met(3); % 337.3650 K
bp_eth = ant_eth(2)/(ant_eth(1) - log10(pres)) - ant_eth(3); % 351.1206 K 

true_p1 = 1.02810; % bar
true_p2 = 1.0304; % bar, DEOS DATA
avgp_ae = mean([true_p1,true_p2]);
avgp_ae = 1.0271; % AVERAGE P OF ALL BINARY MIXTURES

tbp_eth = eval(subs(bp_eth,pres,avgp_ae));
tbp_ace = eval(subs(bp_ace,pres,avgp_ae));

syms t
pvap_ace = (10.^(ant_ace(1) - ant_ace(2)./(t + ant_ace(3)))); % bar
pvap_met = (10.^(ant_met(1) - ant_met(2)./(t + ant_met(3))));
pvap_eth = (10.^(ant_eth(1) - ant_eth(2)./(t + ant_eth(3))));

%% EXPERIMENTAL DATA - fitting and solving for gamma inf

xa_ae = [0.01200,0.02297,0.03204,0.04039,0.04758];
ta_ae = [77.388,76.208,75.488,74.726,74.166] + 0.1811 + 273.15;

xe_ae = 1 - [0.03073,0.05924,0.08445,0.10974,0.13330];
te_ae = [56.912,57.084,57.292,57.458,57.578] + 0.0706 + 273.15;

% ace as solute
p0 = polyfit(xa_ae,ta_ae,2);
%p0 = polyfitB(xa_ae,ta_ae,2,tbp_eth);

xrange = 0:0.001:0.2;
ta_ae_fit = polyval(p0,xrange);

plot(xa_ae,ta_ae,'k^','markersize',10,'linewidth',1.5)
hold on
expe = plot(xrange,ta_ae_fit,'b-','linewidth',1.5);

a_coeff(1) = p0(2); 

% eth as solute
p1 = polyfit(xe_ae,te_ae,2);
%p1 = polyfix(xe_ae,te_ae,2,1,tbp_ace);

xrange = 0.8:0.001:1;
te_ae_fit = polyval(p1,xrange);

plot(xe_ae,te_ae,'k^','markersize',10,'linewidth',1.5)
hold on
expe = plot(xrange,te_ae_fit,'b-','linewidth',1.5);

a_coeff(2) = -2*p1(1) - p1(2);

save coefficient_of_a_ae a_coeff
%% Solving for the experimental y for AE mixture

load phicoeff
phicoeff = phi_coeff(1,:);

load gamma_infinity_ae
a12 = log(gamma1_inf); a21 = log(gamma2_inf);

% a_ae
xa_ae = [0.01200,0.02297,0.03204,0.04039,0.04758];
ta_ae = [77.388,76.208,75.488,74.726,74.166] + 0.1811 + 273.15;

x2_exp = 1 - xa_ae; % essentially the ethanol mole fraction
gamma_exp = exp(a12.*((a21.*x2_exp)./(a12.*xa_ae + a21.*x2_exp)).^2);
pvap_exp = eval(subs(pvap_ace,t,ta_ae));
phi_exp = polyval(phicoeff,ta_ae);
ya_ae = gamma_exp.*xa_ae.*pvap_exp./phi_exp./avgp_ae;
plot(ya_ae,ta_ae,'k^','markersize',10,'linewidth',1.5,'markerfacecolor','k')
hold on

% e_ae
xe_ae = [0.03073,0.05924,0.08445,0.10974,0.13330];
te_ae = [56.912,57.084,57.292,57.458,57.578] + 0.0706 + 273.15;

x2_exp = 1 - xe_ae; % essentially this is acetone mole fraction
gamma_exp = exp(a12.*((a21.*x2_exp)./(a12.*xe_ae + a21.*x2_exp)).^2);
pvap_exp = eval(subs(pvap_eth,t,te_ae));
phi_exp = polyval(phicoeff,te_ae);
ye_ae = gamma_exp.*xe_ae.*pvap_exp./phi_exp./avgp_ae;

plot(1 - ye_ae,te_ae,'k^','markersize',10,'linewidth',1.5,'markerfacecolor','k')
% plot w.r.t ace
hold on

% fitting of y at a side
pnew = polyfit(ya_ae,ta_ae,2);
yfit = polyval(pnew,0:0.001:0.2);
plot(0:0.001:0.2,yfit,'b--','linewidth',1.5)
%xlim([0,0.16])

% fitting of y at e side 
pnew = polyfit(1-ye_ae,te_ae,2);
yfit = polyval(pnew,0.8:0.001:1);
plot(0.8:0.001:1,yfit,'b--','linewidth',1.5)
% xlim([0.8,1])

save x1y1_experimental_ae xa_ae ya_ae xe_ae ye_ae

%% calculating gamma inf
load coefficient_of_a_ae

[dtdx1,dtdx2] = deal(a_coeff(1),a_coeff(2));

% x1 or ace -> 0, T = bp_eth, 1 = ace, 2 = eth
pvap1 = eval(subs(pvap_ace,t,tbp_eth));
pvap2 = eval(subs(pvap_eth,t,tbp_eth));
dpvap2dt = log(10).*ant_eth(2).*pvap2./(tbp_eth - ant_eth(3)).^2;
gamma1_inf = (pvap2 - dpvap2dt*dtdx1)/pvap1;

% x2 or eth -> 0, T = bp_ace, 1 = ace, 2 = eth
pvap1 = eval(subs(pvap_ace,t,tbp_ace));
pvap2 = eval(subs(pvap_eth,t,tbp_ace));
dpvap1dt = log(10).*ant_ace(2).*pvap1./(tbp_ace - ant_ace(3)).^2;
gamma2_inf = (pvap1 - dpvap1dt*dtdx2)/pvap2;

save gamma_infinity_ae gamma1_inf gamma2_inf

%% Solving using vanLaar equations - the parameters and the entire T-x curve
load phicoeff.mat

a12 = log(gamma1_inf); a21 = log(gamma2_inf);

x1 = 0:0.001:1; x2 = 1 - x1; % mol fraction
gamma1 = exp(a12.*((a21.*x2)./(a12.*x1 + a21.*x2)).^2);
gamma2 = exp(a21.*((a12.*x1)./(a12.*x1 + a21.*x2)).^2);

phicoeff = phi_coeff(1,:);
T = linspace(tbp_ace,tbp_eth,length(x1));
opt = optimset('Display','notify');
t_solve = fsolve(@optimizer,T,opt,ant_ace,ant_eth,x1,x2,gamma1,gamma2,phicoeff,avgp_ae);

pvap1 = 10.^(ant_ace(1) - ant_ace(2)./(t_solve + ant_ace(3)));

phival = polyval(phicoeff,t_solve); % fug. coeff. correction
y1 = gamma1.*pvap1.*x1./phival./avgp_ae;

van = plot(x1,t_solve,'k-','linewidth',4);
hold on
plot(y1,t_solve,'k--','linewidth',4)
xlim([0,1]); xtickformat('%.2f'); ytickformat('%.1f');
xlabel('x_{Acetone}','fontsize',12,'fontweight','bold')
ylabel('T (K)','fontsize',12,'fontweight','bold')
set(gca,'xcolor',[0 0 0],'ycolor',[0 0 0],'fontname','times',...
    'xminortick','on','yminortick','on','fontsize',12,'linewidth',1.5)

save x1y1_vanlaar_ae x1 y1

%% Solving using Wilson equations - the parameters and the entire T-x curve

syms lambda1 lambda2

eqn1 = exp(-log(lambda1) + 1 - lambda2) == gamma1_inf;
eqn2 = exp(-log(lambda2) + 1 - lambda1) == gamma2_inf;

sol = solve([eqn1,eqn2],[lambda1,lambda2]);
param1 = eval(sol.lambda1); param2 = eval(sol.lambda2);

x1 = 0:0.001:1; x2 = 1 - x1; % mol fraction
gamma1 = exp(-log(x1 + x2.*param1) + x2.*(param1./(x1 + x2.*param1) - param2./(x1.*param2 + x2)));
gamma2 = exp(-log(x2 + x1.*param2) - x1.*(param1./(x1 + x2.*param1) - param2./(x1.*param2 + x2)));

T = linspace(tbp_ace,tbp_eth,length(x1));
opt = optimset('Display','notify');
t_solve = fsolve(@optimizer,T,opt,ant_ace,ant_eth,x1,x2,gamma1,gamma2,phicoeff,avgp_ae);

pvap1 = 10.^(ant_ace(1) - ant_ace(2)./(t_solve + ant_ace(3)));

phicoeff = polyval(phicoeff(1,:),t_solve); % fug. coeff. correction of ace
y1 = gamma1.*pvap1.*x1./phicoeff./avgp_ae;

wils = plot(x1,t_solve,'r-','linewidth',1.5);
hold on
plot(y1,t_solve,'r--','linewidth',1.5)
xlim([0,1]); xtickformat('%.2f'); ytickformat('%.1f');
xlabel('x_{Acetone}','fontsize',12,'fontweight','bold')
ylabel('T (K)','fontsize',12,'fontweight','bold')
set(gca,'xcolor',[0 0 0],'ycolor',[0 0 0],'fontname','times',...
    'xminortick','on','yminortick','on','fontsize',12,'linewidth',1.5)

save x1y1_wilson_ae x1 y1

%% x-y plot

% x-y of vanLaar
load x1y1_vanlaar_ae

van = plot(x1,y1,'k-','linewidth',4);
hold on
plot([0,1],[0,1],'k--','linewidth',1.5)

% x-y of Wilson
load x1y1_wilson_ae

wilson = plot(x1,y1,'r-','linewidth',1.5);

% Literature data of x and y values
load literature_data_x1y1_ae

plot(x1a,y1a,'kd','markersize',10,'linewidth',1.5)
plot(x1b,y1b,'ks','markersize',10,'linewidth',1.5,'markerfacecolor','k')

% Experimental data
load x1y1_experimental_ae

plot(xa_ae,ya_ae,'ko','markersize',10,'linewidth',1.5)
plot(1-ye_ae,1 - ye_ae,'ko','markersize',10,'linewidth',1.5)

xtickformat('%.2f'); ytickformat('%.2f');
xlim([0,1]); ylim([0,1])
xlabel('x_{Acetone}','fontsize',12,'fontweight','bold')
ylabel('y_{Acetone}','fontsize',12,'fontweight','bold')
set(gca,'xcolor',[0 0 0],'ycolor',[0 0 0],'fontname','times',...
    'xminortick','on','yminortick','on','fontsize',12,'linewidth',1.5)
legend([van,wilson],'van Laar','Wilson','fontsize',12,'location','northwest')

print -djpeg xy_AE
%% Literature data

% doi:10.1016/j.fluid.2005.01.007 AE, P = 101.3 kPa
T1 = [351.44	348.91	346.65	344.53	342.69	341.17	339.81	338.39	337.32...
    336.24	335.37	334.51	333.78	333.06	332.43	331.81	331.2	330.66	330.17	329.69	329.26];
x1a = [0	0.044	0.085	0.132	0.175	0.227	0.276	0.328	0.38	0.433...
    0.481	0.538	0.586	0.639	0.688	0.745	0.796	0.849	0.901	0.951	1];
y1a = [0	0.129	0.232	0.325	0.403	0.463	0.517	0.571	0.609	0.651...
    0.685	0.719	0.749	0.777	0.803	0.835	0.867	0.898	0.929	0.965	1];

plot(x1a,T1,'kd','markersize',10,'linewidth',1.5)
plot(y1a,T1,'kd','markersize',10,'linewidth',1.5,'markerfacecolor','k')

% P = 760 mmHg, https://doi.org/10.1021/ie50553a041
T2 = [78.3	76.4	74	70.8	69.1	65.6	63.4	61.3	59	57.3	56.1] + 273.15;
x1b = [0	0.033	0.078	0.149	0.195	0.316	0.414	0.532	0.691	0.852	1];
y1b = [0	0.111	0.216	0.345	0.41	0.534	0.614	0.697	0.796	0.896	1];

plot(x1b,T2,'ks','markersize',10,'linewidth',1.5)
plot(y1b,T2,'ks','markersize',10,'linewidth',1.5,'markerfacecolor','k')
legend([van,wils],'van Laar','Wilson','fontsize',12)
%legend([van,wils,expe],'van Laar','Wilson','Experimental','fontsize',12)
%legend([van,wils,expe],'van Laar','Wilson','Experimental','fontsize',12,'location','northwest')
% xlim([0,0.2]); xlim([0.8,1]);
save literature_data_x1y1_ae x1a y1a x1b y1b