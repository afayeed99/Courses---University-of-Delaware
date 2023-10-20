%% FOLLOWING THE DESIGN STEPS

%% Single stage MC
close all
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
% plot(log(power),log(dmax),'ko')
% hold on
% plot(log(power_range),logd_range)

M = 2; % CA^Ieq = M * CA^IIeq
km = 3e-5; % m/s
q2 = 250; % L/min
caf2 = 35; % g/L
ca2_goal = 3; % g/L
caf1 = 0; % g/L

mload = -(q2*ca2_goal - q2*caf2); % g/min
% positive cuz phase I is to be enriched with A
q1min = q2*(caf2 - ca2_goal)/(M*ca2_goal - caf1); % 1333.33 L/min

% SET EFFICIENCY BETWEEN 80% TO 90%
chi = 0.5:0.0001:0.95;
q1 = q1min./chi; % L/min

[dlist,q1list] = meshgrid(d_range,q1);
[powerlist,chilist] = meshgrid(power_range,chi);

lambda = q2./q1list; % no lambda == M
% ca1 = M.*(caf1 + lambda.*caf2)./(lambda + M); % g/L
% ca1 = caf1 + lambda.*(caf2 - ca2_goal);
ca2_eq = (caf1 + lambda.*caf2)./(lambda + M);
ca1_eq = M.*ca2_eq;
ca2 = caf2 - chilist.*(caf2 - ca2_eq);
ca1 = caf1 + chilist.*(M.*ca2_eq - caf1);

% ca2 = ca1./M; % g/L

% lambda =/= M
% avgcI_II = -((ca1 - M.*caf2) - (caf1 - M.*ca2_goal))./(log((ca1 - M.*caf2)./(caf1 - M*ca2_goal)));

avgcI_II = -(ca1 - M*ca2);% g/L

area = mload./60./km./avgcI_II./1e3; % m^2

rho1 = 1.463; % g/mL or kg/L https://www.chemicalbook.com/ChemicalProductProperty_EN_CB5406573.htm
rho2 = 0.99705; % kg/L https://www.engineeringtoolbox.com/water-density-specific-weight-d_595.html

TCE_cost = 0.1; % $/kg of TCE
power_cost = 0.12; % $/kWh
vol_cost = 680; % $680/m^3, https://onlinelibrary.wiley.com/doi/pdf/10.1002/9783527611119.app4 page 50

v2 = 1./6.*area.*dlist.*1000; % L
v1 = v2.*q1list./q2; % L
vtotal = v1 + v2; % L

total_tcecost = v1.*rho1.*TCE_cost; % $
% total_tcecost = q1list.*rho1.*TCE_cost.*60.*24; % $
masstotal = rho1.*v1 + rho2.*v2; % assuming we consider both masses, kg
% masstotal = (rho1.*q1list + rho2.*q2).*60.*24; % assuming we consider both masses

total_powercost = powerlist.*masstotal.*power_cost./1000.*24; % $ .*tau./3600
total_volcost = vtotal.*vol_cost.*0.001;
totalc = total_tcecost + total_powercost + total_volcost; % correct dimensions

% chi_array = repmat(chi',1,length(d_range));
shading interp
colormap(flipud(jet))
% contourf(vtotal,totalc,chilist.*100,'edgecolor','none')
surf_set = pcolor(vtotal,totalc,chilist.*100);
set(surf_set,'edgecolor','none')

xlabel('V_{Total} (L)','fontsize',12,'fontname','times','fontweight','bold')
ylabel('Total Cost ($)','fontsize',12,'fontname','times','fontweight','bold')
h = colorbar; h.LineWidth = 1.5;

for i = 1:length(h.TickLabels)
    ticklabels = str2double(h.TickLabels{i});
    h.TickLabels{i} = sprintf('%.1f',ticklabels);
end

ylabel(h,'\bf\chi (%)','fontsize',12,'fontname','times','fontweight','bold')
set(gca,'xcolor',[0 0 0],'ycolor',[0 0 0],'fontname','times',...
    'xminortick','on','yminortick','on','fontsize',12,'linewidth',1.5,'tickdir','out')
xlim([0,300]);ylim([50,250])
print -djpeg contour_singlestage
%%
v = [90,90];
hold on
[a,b] = contour(vtotal,totalc,chilist.*100,v);
set(b,'linewidth',2,'color','w')

%% FROM HERE DOWNWARDS ARE JUST MISCELLANEOUS/TRIAL AND ERROR, NOTHING RELEVANT

close all
figure
plot(vtotal,total_tcecost,'linewidth',1.5)
hold on

interp_v = linspace(min(vtotal),max(vtotal),1000);
smooth_totalpowercost = interp1(vtotal,total_powercost,interp_v,'pchip'); %
smooth_totaltcecost = interp1(vtotal,total_tcecost,interp_v,'spline'); %

index = find(abs(smooth_totaltcecost - smooth_totalpowercost) < 1e-2);
v_operating = interp_v(index); % L

plot(interp_v,smooth_totalpowercost,'r-','linewidth',1.5)

plot([v_operating,v_operating],[0,smooth_totaltcecost(index)],'k--','linewidth',1.5)
plot([0,v_operating],[smooth_totaltcecost(index),smooth_totaltcecost(index)],'k--','linewidth',1.5)
plot(v_operating,smooth_totaltcecost(index),'ko','markersize',8,'markerfacecolor','b','linewidth',1.5)
ylim([0,25])
xtickformat('%.1f'); ytickformat('%.1f');
legend('TCE','Local Power')
xlabel('Total Volume (L)','fontsize',12,'fontweight','bold')
ylabel('Cost ($)','fontsize',12,'fontweight','bold')

text(mean([0,v_operating]),smooth_totaltcecost(index),['Cost = $' num2str(smooth_totaltcecost(index),'%.2f')],...
    'fontname','times','fontsize',12,'fontweight','bold','horizontalalignment','center',...
    'verticalalignment','bottom')
text(v_operating+2,smooth_totaltcecost(index)/3,['V_{Total} = ' num2str(v_operating,'%.2f') ' L'],...
    'fontname','times','fontsize',12,'fontweight','bold','horizontalalignment','left',...
    'verticalalignment','bottom')

set(gca,'xcolor',[0 0 0],'ycolor',[0 0 0],'fontname','times',...
    'xminortick','on','yminortick','on','fontsize',12,'linewidth',1.5)
hold off

figure

smooth_v1 = interp1(vtotal,v1,interp_v,'spline');
smooth_v2 = interp1(vtotal,v2,interp_v,'spline');
idx_v2 = find(abs(interp_v - v_operating) < 1e-4); % index when v2 is for v_operating

plot(interp_v,smooth_v1,'k-','linewidth',1.5)
hold on
plot(interp_v,smooth_v2,'r-','linewidth',1.5)

plot([v_operating,v_operating],[0,smooth_v2(idx_v2)],'k--','linewidth',1.5)
plot([0,v_operating],[smooth_v2(idx_v2),smooth_v2(idx_v2)],'k--','linewidth',1.5)
legend('Phase I','Phase II')
ylim([0,50])

text(30,smooth_v2(idx_v2),['V^{II} = ' num2str(smooth_v2(idx_v2),'%.2f') ' L'],...
    'fontname','times','fontsize',12,'fontweight','bold','horizontalalignment','center',...
    'verticalalignment','bottom')
text(60,smooth_v2(idx_v2)/4,['V_{Total} = ' num2str(v_operating,'%.2f') ' L'],...
    'fontname','times','fontsize',12,'fontweight','bold','horizontalalignment','left',...
    'verticalalignment','bottom')
xlabel('V_{Total} (L)','fontsize',12,'fontweight','bold')
ylabel('V^{I / II} (L)','fontsize',12,'fontweight','bold')
set(gca,'xcolor',[0 0 0],'ycolor',[0 0 0],'fontname','times',...
    'xminortick','on','yminortick','on','fontsize',12,'linewidth',1.5)

% solve for diameter of v^II
d_operating = smooth_v2(idx_v2)*6/area/1000/1e-6; % micro-m