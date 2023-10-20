%% PHASE 3

%% PART 1 - SIMULATION VS. PREDICTED DATA

% conc(1) = [Acetone], conc(2) = [HCl], conc(3) = [I2]
R = 8.314; % J/mol.K
A = 1.026063e11; % M^-1.s^-1
Ea = 83010.13; % J/mol
T = 303; % K
k1 = A*exp(-Ea/R/T); % M^-1.s^-1

alpha = 0.98760;
beta = 1.00140;
gamma = -0.00032;

ac0 = 2; % M
hcl0 = 0.001; % M
i20 = 0.01; % M
init_conc = [ac0,hcl0,i20];
finaltime = 5000; % 5000 s operation

part1ode = @(t,conc) [-k1.*conc(1).^alpha.*conc(2).^beta.*conc(3).^gamma;...
    k1.*conc(1).^alpha.*conc(2).^beta.*conc(3).^gamma;...
    -k1.*conc(1).^alpha.*conc(2).^beta.*conc(3).^gamma];

time_span = 0:0.1:finaltime; % s

[time,conc_val] = ode45(part1ode,time_span',init_conc,[0,inf]);

[ace_conc,hcl_conc,i2_conc] = deal(conc_val(:,1),conc_val(:,2),conc_val(:,3));
%% PART 1 - PLOT FOR ACETONE CONCENTRATION
close all
plot(time,ace_conc,'k-','linewidth',1.5)
xtickformat('%.0f'); ytickformat('%.2f');
xlabel('Time (s)','fontsize',12,'fontweight','bold')
ylabel('Concentration of Acetone (M)','fontsize',12,'fontweight','bold')
set(gca,'xcolor',[0 0 0],'ycolor',[0 0 0],'fontname','times',...
    'xminortick','on','yminortick','on','fontsize',12,'linewidth',1.5)
print -djpeg part1_aceconc
%% PART 1 - PLOT FOR HCl CONCENTRATION
close all
plot(time,hcl_conc,'k-','linewidth',1.5)
xtickformat('%.0f'); ytickformat('%.2f');
xlabel('Time (s)','fontsize',12,'fontweight','bold')
ylabel('Concentration of H^+ (M)','fontsize',12,'fontweight','bold')
set(gca,'xcolor',[0 0 0],'ycolor',[0 0 0],'fontname','times',...
    'xminortick','on','yminortick','on','fontsize',12,'linewidth',1.5)

print -djpeg part1_hclconc
%% PART 1 - PLOT FOR I2 CONCENTRATION
close all

plot(time,i2_conc,'ko','linewidth',1.5,'markersize',3)
hold on

% [time_sim,absorb] = AcetoneIodinationPCODE(T,ac0,hcl0,i20,finaltime);
% save pcode_data_phase3part1 time_sim absorb
load pcode_data_phase3part1.mat

i2_conc_sim = (absorb - 0.0476)./96.654; % given calibration eqn.

plot(time_sim,i2_conc_sim,'ro','linewidth',1.5,'markersize',3)

legend('Predicted Data','Simulated Data')
xtickformat('%.0f'); ytickformat('%.3f');
xlim([0,3000]); ylim([0,0.012])
xlabel('Time (s)','fontsize',12,'fontweight','bold')
ylabel('Concentration of I_2 (M)','fontsize',12,'fontweight','bold')
set(gca,'xcolor',[0 0 0],'ycolor',[0 0 0],'fontname','times',...
    'xminortick','on','yminortick','on','fontsize',12,'linewidth',1.5)
print -djpeg part1_i2conc

%% PART 2 - CONSIDERATION OF ELECTROLYSIS REACTION INTO PART 1
% conc(1) = [Acetone], conc(2) = [HCl], conc(3) = [I2], conc(4) = [I-]
R = 8.314; % J/mol.K
A = 1.026063e11; % M^-1.s^-1
Ea = 83010.13; % J/mol
T = 303; % K
k1 = A*exp(-Ea/R/T); % M^-1.s^-1
k2 = 0.081; % s^-1

alpha = 0.98760;
beta = 1.00140;
gamma = -0.00032;

ac0 = 2; % M
hcl0 = 0.001; % M
i20 = 0.01; % M
i_neg = 0; % M
init_conc = [ac0,hcl0,i20,i_neg];
finaltime = 5000; % 5000 s operation

part2ode = @(t,conc) [-k1.*conc(1).^alpha.*conc(2).^beta.*conc(3).^gamma;...
    k1.*conc(1).^alpha.*conc(2).^beta.*conc(3).^gamma - 2.*k2.*conc(4);...
    -k1.*conc(1).^alpha.*conc(2).^beta.*conc(3).^gamma + k2.*conc(4);...
    k1.*conc(1).^alpha.*conc(2).^beta.*conc(3).^gamma - 2.*k2.*conc(4)];

time_span = 0:0.1:finaltime; % s

[time,conc_val] = ode45(part2ode,time_span',init_conc,[0,inf]);

[ace_conc,hcl_conc,i2_conc,ineg_conc] = deal(conc_val(:,1),conc_val(:,2),...
    conc_val(:,3),conc_val(:,4));

%% PART 2 - PLOT FOR ACETONE CONCENTRATION
close all
plot(time,ace_conc,'k-','linewidth',1.5)
xtickformat('%.0f'); ytickformat('%.3f');
ylim([1.994,2])
xlabel('Time (s)','fontsize',12,'fontweight','bold')
ylabel('Concentration of Acetone (M)','fontsize',12,'fontweight','bold')
set(gca,'xcolor',[0 0 0],'ycolor',[0 0 0],'fontname','times',...
    'xminortick','on','yminortick','on','fontsize',12,'linewidth',1.5)

print -djpeg part2_aceconc

%% PART 2 - PLOT FOR HCl CONCENTRATION

close all
plot(time,hcl_conc,'k-','linewidth',1.5,'markersize',2)
xtickformat('%.0f'); ytickformat('%.3f');
xlabel('Time (s)','fontsize',12,'fontweight','bold')
ylabel('Concentration of H^+ (M)','fontsize',12,'fontweight','bold')
set(gca,'xcolor',[0 0 0],'ycolor',[0 0 0],'fontname','times',...
    'xminortick','on','yminortick','on','fontsize',12,'linewidth',1.5)

print -djpeg part2_hclconc

%% PART 2 - PLOT FOR I2 CONCENTRATION

close all
plot(time,i2_conc,'ko','linewidth',1.5,'markersize',3)
hold on

% [time_sim,absorb] = AcetoneIodinationPCODE(T,ac0,hcl0,i20,finaltime);
% save pcode_data_phase3part1 time_sim absorb
load pcode_data_phase3part1.mat

i2_conc_sim = (absorb - 0.0476)./96.654; % given calibration eqn.

plot(time_sim,i2_conc_sim,'ro','linewidth',1.5,'markersize',3)

legend('Predicted Data','Simulated Data')
xtickformat('%.0f'); ytickformat('%.3f');
xlim([0,3000]); ylim([0,0.012])
legend('Predicted Data','Simulated Data')
xlabel('Time (s)','fontsize',12,'fontweight','bold')
ylabel('Concentration of I_2 (M)','fontsize',12,'fontweight','bold')
set(gca,'xcolor',[0 0 0],'ycolor',[0 0 0],'fontname','times',...
    'xminortick','on','yminortick','on','fontsize',12,'linewidth',1.5)

print -djpeg part2_i2conc

%% PART 3 - CSTR SIZING

syms hcl_conc i2_conc ineg_conc iodo_conc V
% V will have a unit of L, all conc will have a unit of M

R = 8.314; % J/mol.K
A = 1.026063e11; % M^-1.s^-1
Ea = 83010.13; % J/mol
T = 353; % K
k1 = A*exp(-Ea/R/T); % M^-1.s^-1
k2 = 0.53; % L/s
q = 10/60; % L/s

alpha = 0.98760;
beta = 1.00140;
gamma = -0.00032;

ac0 = 2; % M
hcl0 = 0.001; % M
i20 = 1; % M
ineg0 = 0; % M
iodo0 = 0; % M
conv = 0.8; % acetone conversion
ac = ac0*(1-conv); % M

% eqn1,2,3,4 -> mol bal. for Ac, HCl, I2 and I- respecticely
eqn1 = simplify(q.*(ac0 - ac) - k1.*(ac.^alpha).*(hcl_conc.^beta).*(i2_conc.^gamma).*V == 0);
eqn2 = simplify(q.*(hcl0 - hcl_conc) + k1.*(ac.^alpha).*(hcl_conc.^beta).*(i2_conc.^gamma).*V - 2.*k2.*ineg_conc == 0);
eqn3 = simplify(q.*(i20 - i2_conc) - k1.*(ac.^alpha).*(hcl_conc.^beta).*(i2_conc.^gamma).*V + k2.*ineg_conc == 0);
eqn4 = simplify(q.*(ineg0 - ineg_conc) + k1.*(ac.^alpha).*(hcl_conc.^beta).*(i2_conc.^gamma).*V - 2.*k2.*ineg_conc == 0);
eqn5 = simplify(q.*(iodo0 - iodo_conc) + k1.*(ac.^alpha).*(hcl_conc.^beta).*(i2_conc.^gamma).*V == 0);

init_guess = [hcl0,i20,ineg0,iodo0,100]./2;
[var1,var2,var3,var4,var5] = vpasolve([eqn1,eqn2,eqn3,eqn4,eqn5],[hcl_conc,i2_conc,ineg_conc,iodo_conc,V],init_guess);
var = eval([var1,var2,var3,var4,var5]);
[hcl_conc,i2_conc,ineg_conc,iodo_conc,V] = deal(var(1),var(2),var(3),var(4),var(5));
% eqn1 = q.*(ac0 - ac) - k1.*(ac.^alpha).*(hcl_conc.^beta).*(i2_conc.^gamma).*V
% eqn2 = q.*(hcl0 - hcl_conc) + k1.*(ac.^alpha).*(hcl_conc.^beta).*(i2_conc.^gamma).*V - 2.*k2.*ineg_conc
% eqn3 = q.*(i20 - i2_conc) - k1.*(ac.^alpha).*(hcl_conc.^beta).*(i2_conc.^gamma).*V + k2.*ineg_conc
% eqn4 = q.*(ineg0 - ineg_conc) + k1.*(ac.^alpha).*(hcl_conc.^beta).*(i2_conc.^gamma).*V - 2.*k2.*ineg_conc
