%% Poynting Correction
poynting = dlmread('new_poyn.txt','',2,0);
temp = poynting(:,1);
poyn_ace = poynting(:,3);
poyn_met = poynting(:,4);
poyn_eth = poynting(:,5);

plot(temp,poyn_ace,'k','linewidth',1.5)
hold on
plot(temp,poyn_met,'r','linewidth',1.5)
plot(temp,poyn_eth,'b','linewidth',1.5)
plot([320,360],[1,1],'k--','linewidth',1.5)

xtickformat('%.2f'); ytickformat('%.4f');
xlabel('Temperature, T (K)','fontsize',12)
ylabel('Poynting Pressure Correction','fontsize',12)
legend('Acetone','Methanol','Ethanol')
set(gca,'xcolor',[0 0 0],'ycolor',[0 0 0],'fontname','times',...
    'xminortick','on','yminortick','on')
hold off

%% Poynting Correction (%)
ace_poyn_err = (poyn_ace - 1).*100;
met_poyn_err = (poyn_met - 1).*100;
eth_poyn_err = (poyn_eth - 1).*100;

plot(temp,ace_poyn_err,'k','linewidth',1.5)
hold on
plot(temp,met_poyn_err,'r','linewidth',1.5)
plot(temp,eth_poyn_err,'b','linewidth',1.5)
plot([320,360],[0,0],'k--','linewidth',1.5)

xtickformat('%.2f'); ytickformat('%.2f');
xlabel('Temperature (K)','fontsize',12,'fontweight','bold')
ylabel('Poynting Pressure Correction (%)','fontsize',12,'fontweight','bold')
legend('Acetone','Methanol','Ethanol')
set(gca,'xcolor',[0 0 0],'ycolor',[0 0 0],'fontname','times',...
    'xminortick','on','yminortick','on','fontsize',12,'linewidth',1.5)
yaxis = get(gca,'ylabel'); xaxis = get(gca,'xlabel');
yaxis.Position = [yaxis.Position(1) - 0.5,yaxis.Position(2),yaxis.Position(3)];
xaxis.Position = [xaxis.Position(1),xaxis.Position(2) - 0.01,xaxis.Position(3)];
hold off

print -djpeg Poyn_corr
%% Fugacity Coefficient at Vapor State
phi_vap = dlmread('new_philiq_phivap.txt','',2,0);
temp = phi_vap(:,1);
phivap_ace = phi_vap(:,3);
phivap_met = phi_vap(:,4);
phivap_eth = phi_vap(:,5);

% phi v of i
plot(temp,phivap_ace,'k','linewidth',1.5)
hold on
plot(temp,phivap_met,'r','linewidth',1.5)
plot(temp,phivap_eth,'b','linewidth',1.5)
xtickformat('%.2f'); ytickformat('%.4f');
xlabel('Temperature, T (K)','fontsize',12)
ylabel('Vapor Fugacity Coefficient, \phi_{i}^V','fontsize',12)
legend('\phi_{Acetone}^V','\phi_{Methanol}^V','\phi_{Ethanol}^V')
set(gca,'xcolor',[0 0 0],'ycolor',[0 0 0],'fontname','times',...
    'xminortick','on','yminortick','on')
ylim([0.97,1])
hold off

%% Fugacity Coefficient at Liquid State

fug_liq = dlmread('new_fugliq.txt','',2,0);
temp = fug_liq(:,1);
fugliq_ace = fug_liq(:,3);
fugliq_met = fug_liq(:,4);
fugliq_eth = fug_liq(:,5);

ant_ace = [4.42448,1312.253,-32.445]; % 259.16K - 507.6K
ant_met = [5.20409,1581.341,-33.50]; % 288.1 - 356.83K
ant_eth = [5.24677,1598.673,-46.424]; % 292.77 - 366.63K

pvap_a = 10.^(ant_ace(1) - ant_ace(2)./(temp + ant_ace(3)));
pvap_m = 10.^(ant_met(1) - ant_met(2)./(temp + ant_met(3)));
pvap_e = 10.^(ant_eth(1) - ant_eth(2)./(temp + ant_eth(3)));

%% Fugacity Coefficient at Satuartion

% Formula from Sandler page 319
phisat_ace = fugliq_ace./pvap_a./poyn_ace;
phisat_met = fugliq_met./pvap_m./poyn_met;
phisat_eth = fugliq_eth./pvap_e./poyn_eth;

plot(temp,phisat_ace,'k','linewidth',1.5)
hold on
plot(temp,phisat_met,'r','linewidth',1.5)
plot(temp,phisat_eth,'b','linewidth',1.5)
xtickformat('%.2f'); ytickformat('%.4f');
xlabel('Temperature, T (K)','fontsize',12)
ylabel('Saturated Fugacity Coefficient, \phi_{sat,i}','fontsize',12)
legend('\phi_{sat, Acetone}','\phi_{sat, Methanol}','\phi_{sat, Ethanol}')
set(gca,'xcolor',[0 0 0],'ycolor',[0 0 0],'fontname','times',...
    'xminortick','on','yminortick','on')
hold off

%% Ratio of Fugacity Coefficient

phiratio_ace = phivap_ace./phisat_ace;
phiratio_met = phivap_met./phisat_met;
phiratio_eth = phivap_eth./phisat_eth;

plot(temp,phiratio_ace,'k','linewidth',1.5)
hold on
plot(temp,phiratio_met,'r','linewidth',1.5)
plot(temp,phiratio_eth,'b','linewidth',1.5)
plot([320,360],[1,1],'k--','linewidth',1.5)

xtickformat('%.2f'); ytickformat('%.4f');
xlabel('Temperature, T (K)','fontsize',12)
ylabel('\phi_{i}^V/\phi_{sat,i}','fontsize',12)
legend('Acetone','Methanol','Ethanol','location','north')
set(gca,'xcolor',[0 0 0],'ycolor',[0 0 0],'fontname','times',...
    'xminortick','on','yminortick','on')
hold off

%% Fugacity Ratio Errors (%)
ace_perc_error = (phiratio_ace - 1).*100;
met_perc_error = (phiratio_met - 1).*100;
eth_perc_error = (phiratio_eth - 1).*100;

plot(temp,ace_perc_error,'k','linewidth',1.5);
hold on
plot(temp,met_perc_error,'r','linewidth',1.5);
plot(temp,eth_perc_error,'b','linewidth',1.5);
plot([320,360],[0,0],'k--','linewidth',1.5)

xtickformat('%.2f'); ytickformat('%.2f');
xlabel('Temperature (K)','fontsize',12,'fontweight','bold')
ylabel('Fugacity Coefficient Correction (%)','fontsize',12,'fontweight','bold')
legend('Acetone','Methanol','Ethanol','location','northwest')
set(gca,'xcolor',[0 0 0],'ycolor',[0 0 0],'fontname','times',...
    'xminortick','on','yminortick','on','fontsize',12,'linewidth',1.5)
yaxis = get(gca,'ylabel'); xaxis = get(gca,'xlabel');
yaxis.Position = [yaxis.Position(1) - 0.5,yaxis.Position(2),yaxis.Position(3)];
xaxis.Position = [xaxis.Position(1),xaxis.Position(2) - 0.05,xaxis.Position(3)];
hold off

print -djpeg fug_corr

%% testing out quadratic equation for phiratio

phi_coeff = zeros(3,3); % each row is for each compound, col 1/2/3 = x2,x,c
phiratio = [phiratio_ace,phiratio_met,phiratio_eth];
for i = 1:3
    phi_coeff(i,:) = polyfit(temp,phiratio(:,i),2);
end

save phicoeff phi_coeff % saving phi_coeff var into phicoeff.mat file 
% load phicoeff to be used in other matlab file