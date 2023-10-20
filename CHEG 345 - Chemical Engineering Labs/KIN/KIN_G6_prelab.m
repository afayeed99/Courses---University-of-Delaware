%% All parameters are copied from excel file, and predetermined within the standard condition
close all
clear all
temp = [308.15	308.15	308.15	308.15	308.15	308.15	308.15	308.15	...
    308.15	308.15	303.15	306.15	313.15 311.15]; % K
cace = [2	1	3	4	2	2	2	2	2	2	2	2	2 2]; % M
chcl = [0.02	0.02	0.02	0.02	0.01	0.03	0.04	0.02	...
    0.02	0.02	0.02	0.02	0.02 0.02]; % M
ci2 = [0.0020	0.0020	0.0020	0.0020	0.0020	0.0020	0.0020	0.0010	...
    0.0030	0.0040	0.0020	0.0020	0.0020 0.0020]; % M
% tfinal = [240	240	240	240	240	240	240	240	240	240	240	240	240]; % s
tfinal = linspace(180,180,length(temp)); % s
%%
for i = 1:length(tfinal)
    [time(:,i),absorb(:,i)] = AcetoneIodinationPCODE(temp(i),cace(i),chcl(i),ci2(i),tfinal(i));
    % AcetoneIodinationPCODE(temp,[ace],[HCl],[I2],tfinal) format
    % temp in K, conc. in M, tfinal in s
    % time and absorbe in vector form, vertical (Nx1)
    % Data are randomly generated, so once we have a set of data for a specific
    % condition, stick with it till the very end.
%     plot(time(:,i),absorb(:,i),'o')
%     hold on
end
% plot(time(:,1),absorb(:,1),'o')
%% don't run the above code anymore, we need to stick with the same data from now on
%save absorbance_data_matlab time absorb
load absorbance_data_matlab
%% SAMPLE PLOTS FOR PRELAB!!!
[newtime,newabsorb] = AcetoneIodinationPCODE(temp(end),cace(end),chcl(end),ci2(end),tfinal(end));
%% rerun run 10
[t10,abs10] = AcetoneIodinationPCODE(308.15,2,0.02,0.0040,180);
%% rerun run 7
[t7,abs7] = AcetoneIodinationPCODE(308.15,2,0.04,0.0020,180);

%% plotting the absorbance vs. time example
% abs_510 = 96.654*[I2] + 0.0476
plot(time(:,1),absorb(:,1),'ko','linewidth',1.5,'markersize',7)
legend('Simulated Absorbance Data')
xlabel('Time (s)','fontsize',12,'fontweight','bold')
ylabel('Absorbance (M^{-1}cm^{-1})','fontsize',12,'fontweight','bold')
set(gca,'xcolor',[0 0 0],'ycolor',[0 0 0],'fontname','times',...
    'xminortick','on','yminortick','on','fontsize',12,'linewidth',1.5)
xtickformat('%.0f'); ytickformat('%.2f'); xlim([0,100])

print -djpeg absorbancedata

%% plotting the [I2] vs. time example
i2_conc = (absorb - 0.0476)./96.654;
plot(time(:,1),i2_conc(:,1),'ro','linewidth',1.5,'markersize',7)
legend('Simulated Experimental Data')
xlabel('Time (s)','fontsize',12,'fontweight','bold')
ylabel('[I_2] (M)','fontsize',12,'fontweight','bold')
set(gca,'xcolor',[0 0 0],'ycolor',[0 0 0],'fontname','times',...
    'xminortick','on','yminortick','on','fontsize',12,'linewidth',1.5)
xtickformat('%.0f'); ytickformat('%.2f'); xlim([0,100]); ylim([0,1.6e-3])
print -djpeg i2conc_nofitting

plot(time(:,1),i2_conc(:,1),'ro','linewidth',1.5,'markersize',7)
n1 = 9; % linear fitting to only the first 9 points
[p,s] = polyfit(time(1:n1,1),i2_conc(1:n1,1),1);
yfit = polyval(p,time(1:n1,1),s);
rsq = 1 - (s.normr/norm(i2_conc(1:n1,1) - mean(i2_conc(1:n1,1))))^2;
hold on
plot(time(1:n1,1),yfit,'k-','linewidth',1.5)

text(20,1e-3,['[I_2] = ' num2str(p(1),'%.3e') 't + ' num2str(p(2),'%.3e')],...
    'horizontalalignment','left','verticalalignment','bottom','fontname','times',...
    'fontsize',15)
text(30,0.9e-3,['R^2 = ' num2str(rsq,'%.3f')],'horizontalalignment','left','verticalalignment',...
    'bottom','fontname','times','fontsize',15)

legend('Simulated Experimental Data','Linear Fitting')
xlabel('Time (s)','fontsize',12,'fontweight','bold')
ylabel('[I_2] (M)','fontsize',12,'fontweight','bold')
set(gca,'xcolor',[0 0 0],'ycolor',[0 0 0],'fontname','times',...
    'xminortick','on','yminortick','on','fontsize',12,'linewidth',1.5)
xtickformat('%.0f'); ytickformat('%.2f'); xlim([0,100]); ylim([0,1.6e-3])
print -djpeg i2conc_WITHfitting

%% ARRHENIUS PLOT EXAMPLE

lnk = [-5.654818781	-6.431363529	-5.911340634	-5.532823056];
invT = [0.003245173	0.003298697	0.003266373	0.003193358];

[p,s] = polyfit(invT,lnk,1);
yfit = polyval(p,invT,s);
rsq = 1 - (s.normr/norm(lnk - mean(lnk)))^2;

plot(invT,lnk,'ro','markersize',7,'linewidth',1.5);
xlabel('1/T (K^{-1})','fontsize',12,'fontweight','bold')
ylabel('ln k','fontsize',12,'fontweight','bold')
set(gca,'xcolor',[0 0 0],'ycolor',[0 0 0],'fontname','times',...
    'xminortick','on','yminortick','on','fontsize',12,'linewidth',1.5)
xtickformat('%.2f'); ytickformat('%.2f'); xlim([3.18e-3,3.32e-3]); ylim([-6.6,-5.2])

print -djpeg arrhenius_nofitting
%%
plot(invT,lnk,'ro','markersize',7,'linewidth',1.5);
hold on
plot(invT,yfit,'k-','linewidth',1.5)
xlabel('1/T (K^{-1})','fontsize',12,'fontweight','bold')
ylabel('ln k','fontsize',12,'fontweight','bold')
set(gca,'xcolor',[0 0 0],'ycolor',[0 0 0],'fontname','times',...
    'xminortick','on','yminortick','on','fontsize',12,'linewidth',1.5)
xtickformat('%.2f'); ytickformat('%.2f'); xlim([3.18e-3,3.32e-3]); ylim([-6.6,-5.2])
text(3.2e-3,-6.2,['ln k = $\bf\it\frac{' num2str(p(1),'%.3f') '}{T}$ + ' num2str(p(2),'%.3f')],...
    'interpreter','latex','horizontalalignment','left','verticalalignment','bottom','fontname','times',...
    'fontsize',15)
text(3.2e-3,-6.3,['R^2 = ' num2str(rsq,'%.3f')],'horizontalalignment','left','verticalalignment',...
    'bottom','fontname','times','fontsize',15)

print -djpeg arrhenius_WITHfitting

