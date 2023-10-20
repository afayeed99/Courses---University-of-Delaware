%% FOLLOWING THE DESIGN STEPS

%% MULTISTAGE MASS CONTACTOR
% Notation here is different than single stage
% Here 1,2 mean contactor 1 and 2; i and ii mean phase I and II

dmax = [421.6965,177.8279,74.9894,31.62278,562.3413,237.1374,100,42.1697].*1e-6; % m
power = [10,100,1000,10000,6.49382,42.16965,421.6965,3162.27766]; % W/kg
[power,sortidx] = sort(power,'ascend');
dmax = dmax(sortidx);
y = log(dmax); x = log(power); 
% log(dmax) = m*log(power) + b so that it's linear

p = polyfit(x,y,1);
power_range = linspace(min(power),max(power),1000); % W/kg, a set of power
logd_range = polyval(p,log(power_range));
d_range = exp(logd_range); % m

M = 2; % CA^Ieq = M * CA^IIeq
km = 3e-5; % m/s
q2 = 250; % L/min
caf0_ii = 35; % g/L
ca2_ii_goal = 3; % g/L
caf1 = 0; % g/L

syms lambda

ca2_ii = (lambda^2*caf0_ii/(lambda + M)^2)/(1 - lambda*M/(lambda + M)^2);
ca2_i = M*ca2_ii;
ca1_ii = (ca2_i + lambda*caf0_ii)/(lambda + M);
ca1_i = M*ca1_ii;

lambda_min = vpasolve(ca2_ii == ca2_ii_goal,lambda,[0,inf]); % 0.71326
q1min = q2/eval(lambda_min); % 350.5047 L/min

ca1_ii_min = subs(ca1_ii,lambda,lambda_min); % 11.41 g/L
mload1 = -q2*(ca1_ii_min - caf0_ii); % 5896.97 g/min
mload2 = -q2*(ca2_ii_goal - ca1_ii_min); % 2103.03 g/min
mload1 = eval(mload1); mload2 = eval(mload2);

% mload = -q2*(ca2_ii_goal - caf0_ii);

% Varying the efficiency
chi = 0.5:0.0001:0.95;
q1 = q1min./chi; % L/min

[dlist,q1list] = meshgrid(d_range,q1);
[powerlist,chilist] = meshgrid(power_range,chi);

lambda_val = q2./q1list; % lambda =/= M

ca2_ii_eq = (lambda_val.^2.*caf0_ii./(lambda_val + M).^2)./(1 - lambda_val.*M./(lambda_val + M).^2);
ca2_i_eq = M.*ca2_ii_eq; % g/L
ca1_ii_eq = (ca2_i_eq + lambda_val.*caf0_ii)./(lambda_val + M);
ca1_i_eq = M.*ca1_ii_eq; % g/L

ca1_ii = caf0_ii - chilist.*(caf0_ii - ca1_ii_eq);
ca2_i = caf1 + chilist.*(ca2_i_eq - caf1);
ca1_i = ca2_i + chilist.*(ca1_i_eq - ca2_i);
ca2_ii = ca1_ii - chilist.*(ca1_ii - ca2_ii_eq);

avgc_1_I_II = -(ca1_i - M.*ca1_ii); % g/L
avgc_2_I_II = -(ca2_i - M.*ca2_ii); % g/L

area1 = mload1./60./km./avgc_1_I_II./1e3; % m^2
area2 = mload2./60./km./avgc_2_I_II./1e3; % m^2

rho1 = 1.463; % g/mL or kg/L https://www.chemicalbook.com/ChemicalProductProperty_EN_CB5406573.htm
rho2 = 0.99705; % kg/L https://www.engineeringtoolbox.com/water-density-specific-weight-d_595.html

TCE_cost = 0.1; % $/kg of TCE
power_cost = 0.12; % $/kWh
vol_cost = 680; % $680/m^3, https://onlinelibrary.wiley.com/doi/pdf/10.1002/9783527611119.app4 page 50

v1_ii = 1./6.*area1.*dlist.*1000; 
v1_i = v1_ii.*q1list./q2; 

vtotal_1 = v1_ii + v1_i;
% tau1 = v1_ii./q2.*60;

v2_ii = 1./6.*area2.*dlist.*1000; % V2 = 60.1 L
v2_i = v2_ii.*q1list./q2; % v1 = 356.2 L

vtotal_2 = v2_ii + v2_i;
% tau2 = v2_ii./q2.*60;

v_combine = vtotal_1 + vtotal_2;

total_tcecost1 = v1_i.*rho1.*TCE_cost; % $
total_tcecost2 = v2_i.*rho1.*TCE_cost; % $

masstotal1 = rho1.*v1_i + rho2.*v1_ii;
masstotal2 = rho1.*v2_i + rho2.*v2_ii;

total_powercost1 = powerlist.*masstotal1.*power_cost./1000.*24; % $ .*tau./3600
total_powercost2 = powerlist.*masstotal2.*power_cost./1000.*24; % $ .*tau./3600

total_volcost1 = vtotal_1.*vol_cost.*0.001;
total_volcost2 = vtotal_2.*vol_cost.*0.001;

totalc1 = total_tcecost1 + total_powercost1 + total_volcost1; % correct dimensions
totalc2 = total_tcecost2 + total_powercost2 + total_volcost2; % correct dimensions

totalc = totalc1 + totalc2;

% chi_array = repmat(chi',1,length(d_range));

% contourf(vtotal,total_powercost,chi_array,'edgecolor','none')
shading interp
colormap(flipud(jet))
surf_set = pcolor(v_combine,totalc,chilist.*100);
set(surf_set,'edgecolor','none')

xlabel('V_{Total} (L)','fontsize',12,'fontname','times','fontweight','bold')
ylabel('Total Cost ($)','fontsize',12,'fontname','times','fontweight','bold')
h = colorbar; h.LineWidth = 1.5;

for i = 1:length(h.TickLabels)
    ticklabels = str2double(h.TickLabels{i});
    h.TickLabels{i} = sprintf('%.1f',ticklabels);
end
ylabel(h,'\bf\chi (%)','fontsize',12,'fontname','times','fontweight','bold')
xlim([0,200]);ylim([20,160])
set(gca,'xcolor',[0 0 0],'ycolor',[0 0 0],'fontname','times',...
    'xminortick','on','yminortick','on','fontsize',12,'linewidth',1.5,'tickdir','out')
print -djpeg contour_multistage

%%
v = [90,90];
hold on
[a,b] = contour(v_combine,totalc,chilist.*100,v);
set(b,'linewidth',2,'color','w')

%% FROM HERE DOWNWARDS ARE JUST MISCELLANEOUS/TRIAL AND ERROR, NOTHING RELEVANT

% Notation here is different than single stage
% Here 1,2 mean contactor 1 and 2; i and ii mean phase I and II

dmax = [421.6965,177.8279,74.9894,31.62278,562.3413,237.1374,100,42.1697].*1e-6; % m
power = [10,100,1000,10000,6.49382,42.16965,421.6965,3162.27766]; % W/kg
[power,sortidx] = sort(power,'ascend');
dmax = dmax(sortidx);
y = log(dmax); x = log(power); 
% log(dmax) = m*log(power) + b so that it's linear

p = polyfit(x,y,1);
power_range = linspace(min(power),max(power),1000); % W/kg, a set of power
logd_range = polyval(p,log(power_range));
d_range = exp(logd_range); % m

M = 2; % CA^Ieq = M * CA^IIeq
km = 3e-5; % m/s
q2 = 250; % L/min
caf0_ii = 35; % g/L
ca2_ii_goal = 3; % g/L
caf1 = 0; % g/L

syms lambda

ca2_ii = (lambda^2*caf0_ii/(lambda + M)^2)/(1 - lambda*M/(lambda + M)^2);
ca2_i = M*ca2_ii;
ca1_ii = (ca2_i + lambda*caf0_ii)/(lambda + M);
ca1_i = M*ca1_ii;

lambda_min = vpasolve(ca2_ii == ca2_ii_goal,lambda,[0,inf]); % 0.71326
q1min = q2/eval(lambda_min); % 350.5047 L/min

ca1_ii_min = subs(ca1_ii,lambda,lambda_min); % 11.41 g/L
mload1 = -q2*(ca1_ii_min - caf0_ii); % 5896.97 g/min
mload2 = -q2*(ca2_ii_goal - ca1_ii_min); % 2103.03 g/min
mload1 = eval(mload1); mload2 = eval(mload2);

% Varying the efficiency
chi = 0.5:0.0001:0.95;
q1 = q1min./chi; % L/min

[dlist,q1list] = meshgrid(d_range,q1);
[powerlist,q1list] = meshgrid(power_range,q1);

lambda_val = q2./q1list; % lambda =/= M
ca2_ii_val = (lambda_val.^2.*caf0_ii./(lambda_val + M).^2)./(1 - lambda_val.*M./(lambda_val + M).^2);
ca2_i_val = M.*ca2_ii_val; % g/L
ca1_ii_val = (ca2_i_val + lambda_val.*caf0_ii)./(lambda_val + M);
ca1_i_val = M.*ca1_ii_val; % g/L

% lambda =/= M
avgc_1_I_II = -((ca1_i_val - M.*caf0_ii) - (ca2_i_val - M.*ca1_ii_val))./...
    (log((ca1_i_val - M.*caf0_ii)./(ca2_i_val - M.*ca1_ii_val)));
% avgc_1_I_II = -(ca1_i_val - M*ca1_ii_val); % g/L

avgc_2_I_II = -((ca2_i_val - M.*ca1_ii_val) - (caf1 - M.*ca2_ii_val))./...
    (log((ca2_i_val - M.*ca1_ii_val)./(caf1 - M.*ca2_ii_val)));
% avgc_2_I_II = -(ca2_i_val - M*ca2_ii_val); % g/L
% avgc_1_I_II = (ca1_i_val - M.*ca2_ii_goal);
% avgc_2_I_II = (ca1_i_val - M.*ca2_ii_goal);

area1 = mload1./60./km./avgc_1_I_II./1e3; % m^2
area2 = mload2./60./km./avgc_2_I_II./1e3; % m^2

rho1 = 1.463; % g/mL or kg/L https://www.chemicalbook.com/ChemicalProductProperty_EN_CB5406573.htm
rho2 = 0.99705; % kg/L https://www.engineeringtoolbox.com/water-density-specific-weight-d_595.html

TCE_cost = 0.1; % $/kg of TCE
power_cost = 0.12; % $/kWh

v1_ii = 1./6.*area1.*dlist.*1000; 
v1_i = v1_ii.*q1list./q2; 

vtotal_1 = v1_ii + v1_i;
% tau1 = v1_ii./q2.*60;

v2_ii = 1./6.*area2.*dlist.*1000; % V2 = 60.1 L
v2_i = v2_ii.*q1list./q2; % v1 = 356.2 L

vtotal_2 = v2_ii + v2_i;
% tau2 = v2_ii./q2.*60;

v_combine = vtotal_1 + vtotal_2;

total_tcecost1 = v1_i.*rho1.*TCE_cost; % $
total_tcecost2 = v2_i.*rho1.*TCE_cost; % $

masstotal1 = rho1.*v1_i + rho2.*v1_ii;
masstotal2 = rho1.*v2_i + rho2.*v2_ii;

total_powercost1 = powerlist.*masstotal1.*power_cost./1000.*24; % $ .*tau./3600
total_powercost2 = powerlist.*masstotal2.*power_cost./1000.*24; % $ .*tau./3600

totalc1 = total_tcecost1 + total_powercost1; % correct dimensions
totalc2 = total_tcecost2 + total_powercost2; % correct dimensions

totalc = totalc1 + totalc1;

chi_array = repmat(chi',1,length(d_range));

% contourf(vtotal,total_powercost,chi_array,'edgecolor','none')
shading interp
colormap(flipud(jet))
contourf(v_combine,totalc,chi_array.*100,'edgecolor','none')

% contourf(v2,total_powercost,chi_array,'edgecolor','none')
xlabel('V_{Total} (L)','fontsize',12,'fontname','times','fontweight','bold')
ylabel('Total Cost ($)','fontsize',12,'fontname','times','fontweight','bold')
h = colorbar; h.LineWidth = 1.5;
for i = 1:length(h.TickLabels)
    ticklabels = str2double(h.TickLabels{i});
    h.TickLabels{i} = sprintf('%.1f',ticklabels);
end
ylabel(h,'\bf\chi (%)','fontsize',12,'fontname','times','fontweight','bold')
set(gca,'xcolor',[0 0 0],'ycolor',[0 0 0],'fontname','times',...
    'xminortick','on','yminortick','on','fontsize',12,'linewidth',1.5)
%%
xlim([5,40]);ylim([0,180])

%%
contourf(v_combine,ca2_ii_val,chi_array.*100,'edgecolor','none')


%%
% interp_v1 = linspace(min(vtotal_1),max(vtotal_1),1000);
% interp_v2 = linspace(min(vtotal_2),max(vtotal_2),1000);
% 
% smooth_v1_i = interp1(vtotal_1,v1_i,interp_v1,'spline');
% smooth_v1_ii = interp1(vtotal_1,v1_ii,interp_v1,'spline');
% smooth_v2_i = interp1(vtotal_2,v2_i,interp_v2,'spline');
% smooth_v2_ii = interp1(vtotal_2,v2_ii,interp_v2,'spline');
% 
% idx_v1 = find(abs(interp_v1 - v_operating) < 1e-4); % index when v2 is for v_operating

%% COST FOR MULTISTAGE

rho1 = 1.463; % g/mL or kg/L https://www.chemicalbook.com/ChemicalProductProperty_EN_CB5406573.htm
rho2 = 0.99705; % kg/L https://www.engineeringtoolbox.com/water-density-specific-weight-d_595.html

TCE_cost = 0.1; % $/kg of TCE
power_cost = 0.12; % $/kWh

tcecost_1 = v1_i.*rho1.*TCE_cost; % $
tcecost_2 = v2_i.*rho1.*TCE_cost; % $

combine_tcecost = tcecost_1 + tcecost_2; % $

masstotal_1 = rho1.*v1_i + rho2.*v1_ii;
masstotal_2 = rho1.*v2_i + rho2.*v2_ii;
combine_masstotal = masstotal_1 + masstotal_2;

powercost_1 = power.*masstotal_1.*power_cost./1000.*24; % $ .*tau./3600
powercost_2 = power.*masstotal_2.*power_cost./1000.*24; % $ .*tau./3600
% ASSUMING OPERATING 1 FULL DAY NON-STOP

combine_powercost = power.*combine_masstotal.*power_cost./1000.*24; % $/h .*tau./3600

%% LET'S PLOT CONTACTOR 1 IN ON PLOT, CONTACTOR 2 IN ONE PLOT, OVERALL
% CONTACTOR IN ONE PLOT

close all
% MC 1
% figure
subplot(1,3,1)
% yyaxis left
plot(vtotal_1,tcecost_1,'k-','linewidth',1.5)
% ytickformat('%.1f');
% ylabel('TCE Cost ($)','fontsize',12,'fontweight','bold')
% set(gca,'xcolor',[0 0 0],'ycolor',[0 0 0],'fontname','times',...
%     'xminortick','on','yminortick','on','fontsize',12,'linewidth',1.5)
hold on
% yyaxis right
interp_v = linspace(min(vtotal_1),max(vtotal_1),100);
smooth_totalpowercost = interp1(vtotal_1,powercost_1,interp_v,'pchip'); %
plot(interp_v,smooth_totalpowercost,'k--','linewidth',1.5)
% annotation('arrow',[0.2,0.3],[0.6,0.6],'linewidth',1.5,'linestyle','--')
% annotation('arrow',[0.63,0.53],[0.7,0.7],'linewidth',1.5)
legend('TCE','Power','location','north')
title('Mass Contactor 1')
xtickformat('%.1f'); ytickformat('%.1f');
ylim([0,10])
xlabel('Total Volume (L)','fontsize',12,'fontweight','bold')
ylabel('Cost ($)','fontsize',12,'fontweight','bold')
set(gca,'xcolor',[0 0 0],'ycolor',[0 0 0],'fontname','times',...
    'xminortick','on','yminortick','on','fontsize',12,'linewidth',1.5)
hold off

% MC 2
% figure
subplot(1,3,2)
% yyaxis left
plot(vtotal_2,tcecost_2,'k-','linewidth',1.5)
% ytickformat('%.1f');
% ylabel('TCE Cost ($)','fontsize',12,'fontweight','bold')
% set(gca,'xcolor',[0 0 0],'ycolor',[0 0 0],'fontname','times',...
%     'xminortick','on','yminortick','on','fontsize',12,'linewidth',1.5)
hold on
% yyaxis right
interp_v = linspace(min(vtotal_2),max(vtotal_2),100);
smooth_totalpowercost = interp1(vtotal_2,powercost_2,interp_v,'pchip'); %
plot(interp_v,smooth_totalpowercost,'k--','linewidth',1.5)
% annotation('arrow',[0.2,0.3],[0.6,0.6],'linewidth',1.5,'linestyle','--')
% annotation('arrow',[0.73,0.63],[0.7,0.7],'linewidth',1.5)
legend('TCE','Power','location','north')
title('Mass Contactor 2')
xtickformat('%.1f'); ytickformat('%.1f');
ylim([0,10])
xlabel('Total Volume (L)','fontsize',12,'fontweight','bold')
ylabel('Cost ($)','fontsize',12,'fontweight','bold')
set(gca,'xcolor',[0 0 0],'ycolor',[0 0 0],'fontname','times',...
    'xminortick','on','yminortick','on','fontsize',12,'linewidth',1.5)
hold off

% COMBINE MC
% figure
subplot(1,3,3)

% yyaxis left
plot(v_combine,combine_tcecost,'k-','linewidth',1.5)
% ytickformat('%.1f');
% ylabel('TCE Cost ($)','fontsize',12,'fontweight','bold')
% set(gca,'xcolor',[0 0 0],'ycolor',[0 0 0],'fontname','times',...
%     'xminortick','on','yminortick','on','fontsize',12,'linewidth',1.5)
hold on
% yyaxis right
interp_v = linspace(min(v_combine),max(v_combine),100);
smooth_totalpowercost = interp1(v_combine,combine_powercost,interp_v,'pchip'); %
plot(interp_v,smooth_totalpowercost,'k--','linewidth',1.5)
% annotation('arrow',[0.2,0.3],[0.6,0.6],'linewidth',1.5,'linestyle','--')
% annotation('arrow',[0.73,0.63],[0.7,0.7],'linewidth',1.5)
legend('TCE','Power','location','north')
title('Overall Mass Contactor')
xtickformat('%.1f'); ytickformat('%.1f');
ylim([0,10])
xlabel('Total Volume (L)','fontsize',12,'fontweight','bold')
ylabel('Cost ($)','fontsize',12,'fontweight','bold')
set(gca,'xcolor',[0 0 0],'ycolor',[0 0 0],'fontname','times',...
    'xminortick','on','yminortick','on','fontsize',12,'linewidth',1.5)
hold off

