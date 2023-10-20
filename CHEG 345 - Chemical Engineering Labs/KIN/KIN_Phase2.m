%% Phase 2 CI

%% Fitting raw data
inv_t = [0.00324517280545,0.00329869701468,0.00326637269312,0.00319335781574,0.00321388397879];
lnk = [-7.01212039929674,-7.61642275302846,-7.22192103859191,-6.52814698170620,-6.77207402710722];
p = polyfit(inv_t,lnk,1);
lnkfit = polyval(p,inv_t);
plot(inv_t,lnk,'ko')
hold on
plot(inv_t,lnkfit,'k-')

%% CI
t = [30:0.001:40] + 273.15; % K
x = 1./t;
y = polyval(p,x);
n = 5; alpha = 0.05;

devsq = sum((inv_t - mean(inv_t)).^2);
sumx = sum(inv_t); sumy = sum(lnk);
sumxsq = sum(inv_t.^2); sumysq = sum(lnk.^2);
sumxy = sum(inv_t.*lnk);

sy = sqrt(1/n/(n-2).*(n.*sumysq - sumy.^2 - (n.*sumxy - sumx.*sumy).^2./(n*sumxsq - sumx.^2)));
ci = sy.*sqrt((1/n + (x - mean(inv_t)).^2))./devsq;
tcrit = 3.182446305;
lowci = y - tcrit.*ci;
highci = y + tcrit.*ci;

plot(x,y,'k-');
hold on
plot(x,lowci,'b--')
%%
plot(x,lowci,'b--')
plot(x,highci,'b--')

%% NEW
close all
x = [0.00324517280545,0.00329869701468,0.00326637269312,0.00319335781574,0.00321388397879];
y = [-7.01212039929674,-7.61642275302846,-7.22192103859191,-6.52814698170620,-6.77207402710722];

invt = [0.003298697	0.003293265	0.003287851	0.003282455	0.003277077	0.003271716...
    0.003266373	0.003261047	0.003255738	0.003250447	0.003245173	0.003239916...
    0.003234676	0.003229453	0.003224246	0.003219057	0.003213884	0.003208728...
    0.003203588	0.003198465	0.003193358];
lnk	= [-7.581276296	-7.527043723	-7.472989459	-7.419112625	-7.36541235	...
    -7.311887767	-7.258538015	-7.205362239	-7.15235959	-7.099529223	...
    -7.046870299	-6.994381986	-6.942063456	-6.889913886	-6.837932459	...
    -6.786118363	-6.734470792	-6.682988943	-6.631672021	-6.580519235    -6.529529798];
lowci = [-7.687064682	-7.625806179	-7.565019839	-7.504765456	-7.445118107...
    -7.386170609	-7.32803456	-7.270837978	-7.214716945	-7.159799255	...
    -7.10618136	-7.053905487	-7.002947423	-6.953221793	-6.904601936	...
    -6.856944389	-6.810108797	-6.763969646	-6.718420779	-6.673375359	-6.628763658];
hici = [-7.47548791	-7.428281267	-7.380959079	-7.333459794	-7.285706593...
    -7.237604925	-7.18904147	-7.1398865	-7.090002235	-7.03925919	...
    -6.987559238	-6.934858485	-6.881179489	-6.826605979	-6.771262981...
    -6.715292337	-6.658832786	-6.60200824	-6.544923264	-6.487663111	-6.430295938];

error = [0.021255195	0.009395383	0.01179503	0.011057589	0.009605479];

fitting = plot(invt,lnk,'k-','linewidth',1.5);
hold on
experiment = errorbar(x,y,error,'ko','markersize',5,'markerfacecolor','k','linewidth',1);
ci = fill([invt,fliplr(invt)],[hici,fliplr(lowci)],[0.9100 0.4100 0.1700],'facealpha', 0.4,...
    'linewidth',1.5,'linestyle','--','edgecolor',[0.9100 0.4100 0.1700]);

xtickformat('%.2f'); ytickformat('%.2f');
xlabel('1/T (K^{-1})','fontsize',12,'fontweight','bold')
ylabel('ln \itk','fontsize',12,'fontweight','bold')
legend([experiment,fitting,ci],'Experimental Data','Linear Fitting','95% C.I.')
set(gca,'xcolor',[0 0 0],'ycolor',[0 0 0],'fontname','times',...
    'xminortick','on','yminortick','on','fontsize',12,'linewidth',1.5)

print -djpeg CI_arrhenius

%% Plotting the absorbance data
close all
% col = rand(14,3); % fixed, dont run!!!!
% save colour_plots col
load colour_plots

[num,txt,raw] = xlsread('CHEG345_KIN_Excel Calculations.xlsx','Absorbance Data Matlab','A3:O39');
time = num(:,1);
absorbance = num(:,[2:end]);
figure
for i = 1:14
    plot(time,absorbance(:,i),'o','linewidth',1.5,'markersize',5,'color',col(i,:))
    hold on
end
runnum = 1:14;
legend(strcat('Run  ', num2str(runnum')))
xtickformat('%.1f'); ytickformat('%.2f');
xlabel('Time (s)','fontsize',12,'fontweight','bold')
ylabel('Absorbance (M^{-1}cm^{-1})','fontsize',12,'fontweight','bold')
set(gca,'xcolor',[0 0 0],'ycolor',[0 0 0],'fontname','times',...
    'xminortick','on','yminortick','on','fontsize',12,'linewidth',1.5)

print -djpeg absorbance_plot

[num,txt,raw] = xlsread('CHEG345_KIN_Excel Calculations.xlsx','Absorbance Data Matlab','Q3:AE39');
time = num(:,1);
conc_i2 = num(:,[2:end]);
figure
for i = 1:14
    plot(time,conc_i2(:,i),'o','linewidth',1.5,'markersize',5,'color',col(i,:))
    hold on
end
runnum = 1:14;
legend(strcat('Run  ', num2str(runnum')))
xtickformat('%.1f'); ytickformat('%.2f'); ylim([0,inf])
xlabel('Time (s)','fontsize',12,'fontweight','bold')
ylabel('Concentration of I_2 (M)','fontsize',12,'fontweight','bold')
set(gca,'xcolor',[0 0 0],'ycolor',[0 0 0],'fontname','times',...
    'xminortick','on','yminortick','on','fontsize',12,'linewidth',1.5)

print -djpeg i2conc_plot
%%
n = [13,4,3,3,13,6,6,7,9,9,13,13,8,11];
time = num(:,1);
conc_i2 = num(:,[2:end]);
figure
for i = 1:14
    plot(time,conc_i2(:,i),'o','linewidth',1.5,'markersize',5,'color',col(i,:))
    hold on
end

for i = 1:length(n)
    i2_molar = conc_i2(:,i);
    p = polyfit(time(1:n(i)),i2_molar(1:n(i)),1);
    yfit = polyval(p,time(1:n(i)));
    fitting(i) = plot(time(1:n(i)),yfit,'linestyle','-','linewidth',1.5,'color',col(i,:));
    hold on
end
legend(fitting,strcat('Run  ', num2str(runnum')))
xtickformat('%.1f'); ytickformat('%.2f'); ylim([0,inf])
xlabel('Time (s)','fontsize',12,'fontweight','bold')
ylabel('Concentration of I_2 (M)','fontsize',12,'fontweight','bold')
set(gca,'xcolor',[0 0 0],'ycolor',[0 0 0],'fontname','times',...
    'xminortick','on','yminortick','on','fontsize',12,'linewidth',1.5)

print -djpeg i2concfitting_plot
