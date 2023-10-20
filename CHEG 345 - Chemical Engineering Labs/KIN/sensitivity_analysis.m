%% ANALYZE VARYING ALPHA FIRST
clear
close all

syms hcl_conc i2_conc ineg_conc V
perc_vary = 0.9:0.001:1.1; % 10% smaller and greater

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

alpha = perc_vary.*alpha; 

ac0 = 2; % M
hcl0 = 0.001; % M
i20 = 1; % M
ineg0 = 0; % M
% iodo0 = 0; % M
conv = 0.8; % acetone conversion
ac = ac0*(1-conv); % M

eqn1 = q.*(ac0 - ac) - k1.*(ac.^alpha).*(hcl_conc.^beta).*(i2_conc.^gamma).*V == 0;
eqn2 = q.*(hcl0 - hcl_conc) + k1.*(ac.^alpha).*(hcl_conc.^beta).*(i2_conc.^gamma).*V - 2.*k2.*ineg_conc == 0;
eqn3 = q.*(i20 - i2_conc) - k1.*(ac.^alpha).*(hcl_conc.^beta).*(i2_conc.^gamma).*V + k2.*ineg_conc == 0;
eqn4 = q.*(ineg0 - ineg_conc) + k1.*(ac.^alpha).*(hcl_conc.^beta).*(i2_conc.^gamma).*V - 2.*k2.*ineg_conc == 0;
% eqn5 = q.*(iodo0 - iodo_conc) + k1.*(ac.^alpha).*(hcl_conc.^beta).*(i2_conc.^gamma).*V == 0;

init_guess = [hcl0,i20,ineg0,100]./2;

for i = 1:length(perc_vary)
    [var1(i),var2(i),var3(i),var4(i)] = vpasolve([eqn1(i),eqn2(i),eqn3(i),eqn4(i)],...
        [hcl_conc,i2_conc,ineg_conc,V],init_guess);
end
%%
% save vpasolvedata_alphavary var1 var2 var3 var4 
% load vpasolvedata_alphavary.mat

[hcl_conc,i2_conc,ineg_conc,V] = deal(var1,var2,var3,var4);

V_fix = 56.6108;
alpha_fix = 0.98760;

perc_V1 = (V- V_fix)./V_fix.*100;
perc_V1 = eval(perc_V1);
perc_alpha = (alpha - alpha_fix)./alpha_fix.*100;
% 
% save vol_percent perc_V1

%% ANALYZE VARYING BETA 
clear
close all

syms hcl_conc i2_conc ineg_conc V
perc_vary = 0.9:0.001:1.1; % 10% smaller and greater

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

beta = perc_vary.*beta; 

ac0 = 2; % M
hcl0 = 0.001; % M
i20 = 1; % M
ineg0 = 0; % M
% iodo0 = 0; % M
conv = 0.8; % acetone conversion
ac = ac0*(1-conv); % M

eqn1 = q.*(ac0 - ac) - k1.*(ac.^alpha).*(hcl_conc.^beta).*(i2_conc.^gamma).*V == 0;
eqn2 = q.*(hcl0 - hcl_conc) + k1.*(ac.^alpha).*(hcl_conc.^beta).*(i2_conc.^gamma).*V - 2.*k2.*ineg_conc == 0;
eqn3 = q.*(i20 - i2_conc) - k1.*(ac.^alpha).*(hcl_conc.^beta).*(i2_conc.^gamma).*V + k2.*ineg_conc == 0;
eqn4 = q.*(ineg0 - ineg_conc) + k1.*(ac.^alpha).*(hcl_conc.^beta).*(i2_conc.^gamma).*V - 2.*k2.*ineg_conc == 0;
% eqn5 = simplify(q.*(iodo0 - iodo_conc) + k1.*(ac.^alpha).*(hcl_conc.^beta).*(i2_conc.^gamma).*V == 0);

init_guess = [hcl0,i20,ineg0,100]./2;

for i = 1:length(perc_vary)
    [var1(i),var2(i),var3(i),var4(i)] = vpasolve([eqn1(i),eqn2(i),eqn3(i),eqn4(i)],...
        [hcl_conc,i2_conc,ineg_conc,V],init_guess);
end

% save vpasolvedata_betavary var1 var2 var3 var4 var5
% load vpasolvedata_betavary.mat

[hcl_conc,i2_conc,ineg_conc,V] = deal(var1,var2,var3,var4);

V_fix = 56.6108;
beta_fix = 1.00140;

perc_V2 = (V- V_fix)./V_fix.*100;
perc_V2 = eval(perc_V2);
perc_beta = (beta - beta_fix)./beta_fix.*100;

% save('vol_percent.mat','perc_V2','-append')

%% ANALYZE VARYING GAMMA
clear
close all

syms hcl_conc i2_conc ineg_conc iodo_conc V
perc_vary = 0.9:0.001:1.1; % 10% smaller and greater

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

gamma = perc_vary.*gamma; 

ac0 = 2; % M
hcl0 = 0.001; % M
i20 = 1; % M
ineg0 = 0; % M
iodo0 = 0; % M
conv = 0.8; % acetone conversion
ac = ac0*(1-conv); % M

eqn1 = simplify(q.*(ac0 - ac) - k1.*(ac.^alpha).*(hcl_conc.^beta).*(i2_conc.^gamma).*V == 0);
eqn2 = simplify(q.*(hcl0 - hcl_conc) + k1.*(ac.^alpha).*(hcl_conc.^beta).*(i2_conc.^gamma).*V - 2.*k2.*ineg_conc == 0);
eqn3 = simplify(q.*(i20 - i2_conc) - k1.*(ac.^alpha).*(hcl_conc.^beta).*(i2_conc.^gamma).*V + k2.*ineg_conc == 0);
eqn4 = simplify(q.*(ineg0 - ineg_conc) + k1.*(ac.^alpha).*(hcl_conc.^beta).*(i2_conc.^gamma).*V - 2.*k2.*ineg_conc == 0);
eqn5 = simplify(q.*(iodo0 - iodo_conc) + k1.*(ac.^alpha).*(hcl_conc.^beta).*(i2_conc.^gamma).*V == 0);

init_guess = [hcl0,i20,ineg0,iodo0,100]./2;

for i = 1:length(perc_vary)
    [var1(i),var2(i),var3(i),var4(i),var5(i)] = vpasolve([eqn1(i),eqn2(i),eqn3(i),eqn4(i),eqn5(i)],...
        [hcl_conc,i2_conc,ineg_conc,iodo_conc,V],init_guess);
end

save vpasolvedata_gammavary var1 var2 var3 var4 var5
load vpasolvedata_gammavary.mat

[hcl_conc,i2_conc,ineg_conc,iodo_conc,V] = deal(var1,var2,var3,var4,var5);

hcl_fix = 0.2184;
i2_fix = 0.0913;
ineg_fix = 0.2174;
iodo_fix = 1.6;
V_fix = 56.6108;
alpha_fix = 0.98760;
beta_fix = 1.00140;
gamma_fix = -0.00032;

perc_hcl = (hcl_conc - hcl_fix)./hcl_fix.*100;
perc_i2 = (i2_conc - i2_fix)./i2_fix.*100;
perc_ineg = (ineg_conc - ineg_fix)./ineg_fix.*100;
perc_iodo = (iodo_conc - iodo_fix)./iodo_fix.*100;
perc_V3 = (V- V_fix)./V_fix.*100;
perc_gamma = (gamma - gamma_fix)./gamma_fix.*100;

save('vol_percent.mat','perc_V3','-append')

% plot(perc_gamma,perc_hcl,'k-','linewidth',1.5)
% hold on
% plot(perc_gamma,perc_i2,'r-','linewidth',1.5)
% plot(perc_gamma,perc_ineg,'b-','linewidth',1.5)
% plot(perc_gamma,perc_iodo,'m-','linewidth',1.5)
% plot(perc_gamma,perc_V,'b--','linewidth',1.5)
% legend
% hold off

%% ANALYZE VARYING EA
clear
close all

syms hcl_conc i2_conc ineg_conc iodo_conc V
perc_vary = 0.9:0.001:1.1; % 10% smaller and greater

R = 8.314; % J/mol.K
A = 1.026063e11; % M^-1.s^-1
Ea = 83010.13; % J/mol
Ea = perc_vary.*Ea; 
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

eqn1 = simplify(q.*(ac0 - ac) - k1.*(ac.^alpha).*(hcl_conc.^beta).*(i2_conc.^gamma).*V == 0);
eqn2 = simplify(q.*(hcl0 - hcl_conc) + k1.*(ac.^alpha).*(hcl_conc.^beta).*(i2_conc.^gamma).*V - 2.*k2.*ineg_conc == 0);
eqn3 = simplify(q.*(i20 - i2_conc) - k1.*(ac.^alpha).*(hcl_conc.^beta).*(i2_conc.^gamma).*V + k2.*ineg_conc == 0);
eqn4 = simplify(q.*(ineg0 - ineg_conc) + k1.*(ac.^alpha).*(hcl_conc.^beta).*(i2_conc.^gamma).*V - 2.*k2.*ineg_conc == 0);
eqn5 = simplify(q.*(iodo0 - iodo_conc) + k1.*(ac.^alpha).*(hcl_conc.^beta).*(i2_conc.^gamma).*V == 0);

init_guess = [hcl0,i20,ineg0,iodo0,100]./2;

for i = 1:length(perc_vary)
    [var1(i),var2(i),var3(i),var4(i),var5(i)] = vpasolve([eqn1(i),eqn2(i),eqn3(i),eqn4(i),eqn5(i)],...
        [hcl_conc,i2_conc,ineg_conc,iodo_conc,V],init_guess);
end

save vpasolvedata_eavary var1 var2 var3 var4 var5
load vpasolvedata_eavary.mat

[hcl_conc,i2_conc,ineg_conc,iodo_conc,V] = deal(var1,var2,var3,var4,var5);

hcl_fix = 0.2184;
i2_fix = 0.0913;
ineg_fix = 0.2174;
iodo_fix = 1.6;
V_fix = 56.6108;
alpha_fix = 0.98760;
beta_fix = 1.00140;
gamma_fix = -0.00032;
a_fix = 1.026063e11; % M^-1.s^-1
ea_fix = 83010.13; % J/mol

perc_hcl = (hcl_conc - hcl_fix)./hcl_fix.*100;
perc_i2 = (i2_conc - i2_fix)./i2_fix.*100;
perc_ineg = (ineg_conc - ineg_fix)./ineg_fix.*100;
perc_iodo = (iodo_conc - iodo_fix)./iodo_fix.*100;
perc_V4 = (V- V_fix)./V_fix.*100;
perc_ea = (Ea - ea_fix)./ea_fix.*100;

save('vol_percent.mat','perc_V4','-append')

% plot(perc_ea,perc_hcl,'k-','linewidth',1.5)
% hold on
% plot(perc_ea,perc_i2,'r-','linewidth',1.5)
% plot(perc_ea,perc_ineg,'b-','linewidth',1.5)
% plot(perc_ea,perc_iodo,'m-','linewidth',1.5)
% plot(perc_ea,perc_V,'b--','linewidth',1.5)
% legend
% hold off

%% ANALYZE VARYING A
clear
close all

syms hcl_conc i2_conc ineg_conc iodo_conc V
perc_vary = 0.9:0.001:1.1; % 10% smaller and greater

R = 8.314; % J/mol.K
A = 1.026063e11; % M^-1.s^-1
Ea = 83010.13; % J/mol
A = perc_vary.*A; 
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

eqn1 = simplify(q.*(ac0 - ac) - k1.*(ac.^alpha).*(hcl_conc.^beta).*(i2_conc.^gamma).*V == 0);
eqn2 = simplify(q.*(hcl0 - hcl_conc) + k1.*(ac.^alpha).*(hcl_conc.^beta).*(i2_conc.^gamma).*V - 2.*k2.*ineg_conc == 0);
eqn3 = simplify(q.*(i20 - i2_conc) - k1.*(ac.^alpha).*(hcl_conc.^beta).*(i2_conc.^gamma).*V + k2.*ineg_conc == 0);
eqn4 = simplify(q.*(ineg0 - ineg_conc) + k1.*(ac.^alpha).*(hcl_conc.^beta).*(i2_conc.^gamma).*V - 2.*k2.*ineg_conc == 0);
eqn5 = simplify(q.*(iodo0 - iodo_conc) + k1.*(ac.^alpha).*(hcl_conc.^beta).*(i2_conc.^gamma).*V == 0);

init_guess = [hcl0,i20,ineg0,iodo0,100]./2;

for i = 1:length(perc_vary)
    [var1(i),var2(i),var3(i),var4(i),var5(i)] = vpasolve([eqn1(i),eqn2(i),eqn3(i),eqn4(i),eqn5(i)],...
        [hcl_conc,i2_conc,ineg_conc,iodo_conc,V],init_guess);
end

save vpasolvedata_Avary var1 var2 var3 var4 var5
load vpasolvedata_Avary.mat

[hcl_conc,i2_conc,ineg_conc,iodo_conc,V] = deal(var1,var2,var3,var4,var5);

hcl_fix = 0.2184;
i2_fix = 0.0913;
ineg_fix = 0.2174;
iodo_fix = 1.6;
V_fix = 56.6108;
alpha_fix = 0.98760;
beta_fix = 1.00140;
gamma_fix = -0.00032;
a_fix = 1.026063e11; % M^-1.s^-1
ea_fix = 83010.13; % J/mol

perc_hcl = (hcl_conc - hcl_fix)./hcl_fix.*100;
perc_i2 = (i2_conc - i2_fix)./i2_fix.*100;
perc_ineg = (ineg_conc - ineg_fix)./ineg_fix.*100;
perc_iodo = (iodo_conc - iodo_fix)./iodo_fix.*100;
perc_V5 = (V- V_fix)./V_fix.*100;
perc_A = (A - a_fix)./a_fix.*100;

save('vol_percent.mat','perc_V5','-append')

% plot(perc_A,perc_hcl,'k-','linewidth',1.5)
% hold on
% plot(perc_A,perc_i2,'r-','linewidth',1.5)
% plot(perc_A,perc_ineg,'b-','linewidth',1.5)
% plot(perc_A,perc_iodo,'m-','linewidth',1.5)
% plot(perc_A,perc_V,'b--','linewidth',1.5)
% legend
% hold off

%% ANALYZE VARYING k2
clear
close all

syms hcl_conc i2_conc ineg_conc iodo_conc V
perc_vary = 0.9:0.001:1.1; % 10% smaller and greater

R = 8.314; % J/mol.K
A = 1.026063e11; % M^-1.s^-1
Ea = 83010.13; % J/mol
T = 353; % K
k1 = A*exp(-Ea/R/T); % M^-1.s^-1
k2 = 0.53; % L/s
k2 = perc_vary.*k2; 
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

eqn1 = simplify(q.*(ac0 - ac) - k1.*(ac.^alpha).*(hcl_conc.^beta).*(i2_conc.^gamma).*V == 0);
eqn2 = simplify(q.*(hcl0 - hcl_conc) + k1.*(ac.^alpha).*(hcl_conc.^beta).*(i2_conc.^gamma).*V - 2.*k2.*ineg_conc == 0);
eqn3 = simplify(q.*(i20 - i2_conc) - k1.*(ac.^alpha).*(hcl_conc.^beta).*(i2_conc.^gamma).*V + k2.*ineg_conc == 0);
eqn4 = simplify(q.*(ineg0 - ineg_conc) + k1.*(ac.^alpha).*(hcl_conc.^beta).*(i2_conc.^gamma).*V - 2.*k2.*ineg_conc == 0);
eqn5 = simplify(q.*(iodo0 - iodo_conc) + k1.*(ac.^alpha).*(hcl_conc.^beta).*(i2_conc.^gamma).*V == 0);

init_guess = [hcl0,i20,ineg0,iodo0,100]./2;

for i = 1:length(perc_vary)
    [var1(i),var2(i),var3(i),var4(i),var5(i)] = vpasolve([eqn1,eqn2(i),eqn3(i),eqn4(i),eqn5],...
        [hcl_conc,i2_conc,ineg_conc,iodo_conc,V],init_guess);
end

save vpasolvedata_k2vary var1 var2 var3 var4 var5
load vpasolvedata_k2vary.mat

[hcl_conc,i2_conc,ineg_conc,iodo_conc,V] = deal(var1,var2,var3,var4,var5);

hcl_fix = 0.2184;
i2_fix = 0.0913;
ineg_fix = 0.2174;
iodo_fix = 1.6;
V_fix = 56.6108;
alpha_fix = 0.98760;
beta_fix = 1.00140;
gamma_fix = -0.00032;
a_fix = 1.026063e11; % M^-1.s^-1
ea_fix = 83010.13; % J/mol

perc_hcl = (hcl_conc - hcl_fix)./hcl_fix.*100;
perc_i2 = (i2_conc - i2_fix)./i2_fix.*100;
perc_ineg = (ineg_conc - ineg_fix)./ineg_fix.*100;
perc_iodo = (iodo_conc - iodo_fix)./iodo_fix.*100;
perc_V6 = (V- V_fix)./V_fix.*100;
perc_A = (A - a_fix)./a_fix.*100;

save('vol_percent.mat','perc_V6','-append')

% plot(perc_A,perc_hcl,'k-','linewidth',1.5)
% hold on
% plot(perc_A,perc_i2,'r-','linewidth',1.5)
% plot(perc_A,perc_ineg,'b-','linewidth',1.5)
% plot(perc_A,perc_iodo,'m-','linewidth',1.5)
% plot(perc_A,perc_V,'b--','linewidth',1.5)
% legend
% hold off

%% ANALYZE VARYING T
clear
close all

syms hcl_conc i2_conc ineg_conc iodo_conc V
perc_vary = 0.9:0.001:1.1; % 10% smaller and greater

R = 8.314; % J/mol.K
A = 1.026063e11; % M^-1.s^-1
Ea = 83010.13; % J/mol
T = 353; % K
T = perc_vary.*T; 
k1 = A*exp(-Ea./R./T); % M^-1.s^-1
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

eqn1 = simplify(q.*(ac0 - ac) - k1.*(ac.^alpha).*(hcl_conc.^beta).*(i2_conc.^gamma).*V == 0);
eqn2 = simplify(q.*(hcl0 - hcl_conc) + k1.*(ac.^alpha).*(hcl_conc.^beta).*(i2_conc.^gamma).*V - 2.*k2.*ineg_conc == 0);
eqn3 = simplify(q.*(i20 - i2_conc) - k1.*(ac.^alpha).*(hcl_conc.^beta).*(i2_conc.^gamma).*V + k2.*ineg_conc == 0);
eqn4 = simplify(q.*(ineg0 - ineg_conc) + k1.*(ac.^alpha).*(hcl_conc.^beta).*(i2_conc.^gamma).*V - 2.*k2.*ineg_conc == 0);
eqn5 = simplify(q.*(iodo0 - iodo_conc) + k1.*(ac.^alpha).*(hcl_conc.^beta).*(i2_conc.^gamma).*V == 0);

init_guess = [hcl0,i20,ineg0,iodo0,100]./2;

for i = 1:length(perc_vary)
    [var1(i),var2(i),var3(i),var4(i),var5(i)] = vpasolve([eqn1(i),eqn2(i),eqn3(i),eqn4(i),eqn5(i)],...
        [hcl_conc,i2_conc,ineg_conc,iodo_conc,V],init_guess);
end

save vpasolvedata_Tvary var1 var2 var3 var4 var5
load vpasolvedata_Tvary.mat

[hcl_conc,i2_conc,ineg_conc,iodo_conc,V] = deal(var1,var2,var3,var4,var5);

hcl_fix = 0.2184;
i2_fix = 0.0913;
ineg_fix = 0.2174;
iodo_fix = 1.6;
V_fix = 56.6108;
alpha_fix = 0.98760;
beta_fix = 1.00140;
gamma_fix = -0.00032;
a_fix = 1.026063e11; % M^-1.s^-1
ea_fix = 83010.13; % J/mol

perc_hcl = (hcl_conc - hcl_fix)./hcl_fix.*100;
perc_i2 = (i2_conc - i2_fix)./i2_fix.*100;
perc_ineg = (ineg_conc - ineg_fix)./ineg_fix.*100;
perc_iodo = (iodo_conc - iodo_fix)./iodo_fix.*100;
perc_V7 = (V- V_fix)./V_fix.*100;
perc_A = (A - a_fix)./a_fix.*100;

save('vol_percent.mat','perc_V7','-append')

% plot(perc_A,perc_hcl,'k-','linewidth',1.5)
% hold on
% plot(perc_A,perc_i2,'r-','linewidth',1.5)
% plot(perc_A,perc_ineg,'b-','linewidth',1.5)
% plot(perc_A,perc_iodo,'m-','linewidth',1.5)
% plot(perc_A,perc_V,'b--','linewidth',1.5)
% legend
% hold off

%% ANALYZE VARYING q
clear
close all

syms hcl_conc i2_conc ineg_conc iodo_conc V
perc_vary = 0.9:0.001:1.1; % 10% smaller and greater

R = 8.314; % J/mol.K
A = 1.026063e11; % M^-1.s^-1
Ea = 83010.13; % J/mol
T = 353; % K
T = perc_vary.*T; 
k1 = A*exp(-Ea./R./T); % M^-1.s^-1
k2 = 0.53; % L/s

q = 10/60; % L/s
q = perc_vary.*q; 

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

eqn1 = simplify(q.*(ac0 - ac) - k1.*(ac.^alpha).*(hcl_conc.^beta).*(i2_conc.^gamma).*V == 0);
eqn2 = simplify(q.*(hcl0 - hcl_conc) + k1.*(ac.^alpha).*(hcl_conc.^beta).*(i2_conc.^gamma).*V - 2.*k2.*ineg_conc == 0);
eqn3 = simplify(q.*(i20 - i2_conc) - k1.*(ac.^alpha).*(hcl_conc.^beta).*(i2_conc.^gamma).*V + k2.*ineg_conc == 0);
eqn4 = simplify(q.*(ineg0 - ineg_conc) + k1.*(ac.^alpha).*(hcl_conc.^beta).*(i2_conc.^gamma).*V - 2.*k2.*ineg_conc == 0);
eqn5 = simplify(q.*(iodo0 - iodo_conc) + k1.*(ac.^alpha).*(hcl_conc.^beta).*(i2_conc.^gamma).*V == 0);

init_guess = [hcl0,i20,ineg0,iodo0,100]./2;

for i = 1:length(perc_vary)
    [var1(i),var2(i),var3(i),var4(i),var5(i)] = vpasolve([eqn1(i),eqn2(i),eqn3(i),eqn4(i),eqn5(i)],...
        [hcl_conc,i2_conc,ineg_conc,iodo_conc,V],init_guess);
end

save vpasolvedata_qvary var1 var2 var3 var4 var5
load vpasolvedata_qvary.mat

[hcl_conc,i2_conc,ineg_conc,iodo_conc,V] = deal(var1,var2,var3,var4,var5);

hcl_fix = 0.2184;
i2_fix = 0.0913;
ineg_fix = 0.2174;
iodo_fix = 1.6;
V_fix = 56.6108;
alpha_fix = 0.98760;
beta_fix = 1.00140;
gamma_fix = -0.00032;
a_fix = 1.026063e11; % M^-1.s^-1
ea_fix = 83010.13; % J/mol

perc_hcl = (hcl_conc - hcl_fix)./hcl_fix.*100;
perc_i2 = (i2_conc - i2_fix)./i2_fix.*100;
perc_ineg = (ineg_conc - ineg_fix)./ineg_fix.*100;
perc_iodo = (iodo_conc - iodo_fix)./iodo_fix.*100;
perc_V8 = (V- V_fix)./V_fix.*100;
perc_A = (A - a_fix)./a_fix.*100;

save('vol_percent.mat','perc_V8','-append')

% plot(perc_A,perc_hcl,'k-','linewidth',1.5)
% hold on
% plot(perc_A,perc_i2,'r-','linewidth',1.5)
% plot(perc_A,perc_ineg,'b-','linewidth',1.5)
% plot(perc_A,perc_iodo,'m-','linewidth',1.5)
% plot(perc_A,perc_V,'b--','linewidth',1.5)
% legend
% hold off

%% ANALYZE VARYING [Acetone]0
clear
close all

syms hcl_conc i2_conc ineg_conc iodo_conc V
perc_vary = 0.9:0.001:1.1; % 10% smaller and greater

R = 8.314; % J/mol.K
A = 1.026063e11; % M^-1.s^-1
Ea = 83010.13; % J/mol
T = 353; % K
T = perc_vary.*T; 
k1 = A*exp(-Ea./R./T); % M^-1.s^-1
k2 = 0.53; % L/s

q = 10/60; % L/s
q = perc_vary.*q; 

alpha = 0.98760;
beta = 1.00140;
gamma = -0.00032;

ac0 = 2; % M
ac0 = perc_vary.*ac0; 
hcl0 = 0.001; % M
i20 = 1; % M
ineg0 = 0; % M
iodo0 = 0; % M
conv = 0.8; % acetone conversion
ac = ac0*(1-conv); % M

eqn1 = simplify(q.*(ac0 - ac) - k1.*(ac.^alpha).*(hcl_conc.^beta).*(i2_conc.^gamma).*V == 0);
eqn2 = simplify(q.*(hcl0 - hcl_conc) + k1.*(ac.^alpha).*(hcl_conc.^beta).*(i2_conc.^gamma).*V - 2.*k2.*ineg_conc == 0);
eqn3 = simplify(q.*(i20 - i2_conc) - k1.*(ac.^alpha).*(hcl_conc.^beta).*(i2_conc.^gamma).*V + k2.*ineg_conc == 0);
eqn4 = simplify(q.*(ineg0 - ineg_conc) + k1.*(ac.^alpha).*(hcl_conc.^beta).*(i2_conc.^gamma).*V - 2.*k2.*ineg_conc == 0);
eqn5 = simplify(q.*(iodo0 - iodo_conc) + k1.*(ac.^alpha).*(hcl_conc.^beta).*(i2_conc.^gamma).*V == 0);

init_guess = [hcl0,i20,ineg0,iodo0,100]./2;

for i = 1:length(perc_vary)
    [var1(i),var2(i),var3(i),var4(i),var5(i)] = vpasolve([eqn1(i),eqn2(i),eqn3(i),eqn4(i),eqn5(i)],...
        [hcl_conc,i2_conc,ineg_conc,iodo_conc,V],init_guess);
end

save vpasolvedata_ac0vary var1 var2 var3 var4 var5
load vpasolvedata_ac0vary.mat

[hcl_conc,i2_conc,ineg_conc,iodo_conc,V] = deal(var1,var2,var3,var4,var5);

hcl_fix = 0.2184;
i2_fix = 0.0913;
ineg_fix = 0.2174;
iodo_fix = 1.6;
V_fix = 56.6108;
alpha_fix = 0.98760;
beta_fix = 1.00140;
gamma_fix = -0.00032;
a_fix = 1.026063e11; % M^-1.s^-1
ea_fix = 83010.13; % J/mol

perc_hcl = (hcl_conc - hcl_fix)./hcl_fix.*100;
perc_i2 = (i2_conc - i2_fix)./i2_fix.*100;
perc_ineg = (ineg_conc - ineg_fix)./ineg_fix.*100;
perc_iodo = (iodo_conc - iodo_fix)./iodo_fix.*100;
perc_V9 = (V- V_fix)./V_fix.*100;
perc_A = (A - a_fix)./a_fix.*100;

save('vol_percent.mat','perc_V9','-append')

% plot(perc_A,perc_hcl,'k-','linewidth',1.5)
% hold on
% plot(perc_A,perc_i2,'r-','linewidth',1.5)
% plot(perc_A,perc_ineg,'b-','linewidth',1.5)
% plot(perc_A,perc_iodo,'m-','linewidth',1.5)
% plot(perc_A,perc_V,'b--','linewidth',1.5)
% legend
% hold off

%% ANALYZE VARYING [HCl]0
clear
close all

syms hcl_conc i2_conc ineg_conc iodo_conc V
perc_vary = 0.9:0.001:1.1; % 10% smaller and greater

R = 8.314; % J/mol.K
A = 1.026063e11; % M^-1.s^-1
Ea = 83010.13; % J/mol
T = 353; % K
T = perc_vary.*T; 
k1 = A*exp(-Ea./R./T); % M^-1.s^-1
k2 = 0.53; % L/s

q = 10/60; % L/s
q = perc_vary.*q; 

alpha = 0.98760;
beta = 1.00140;
gamma = -0.00032;

ac0 = 2; % M
hcl0 = 0.001; % M
hcl0 = perc_vary.*hcl0; 
i20 = 1; % M
ineg0 = 0; % M
iodo0 = 0; % M
conv = 0.8; % acetone conversion
ac = ac0*(1-conv); % M

eqn1 = simplify(q.*(ac0 - ac) - k1.*(ac.^alpha).*(hcl_conc.^beta).*(i2_conc.^gamma).*V == 0);
eqn2 = simplify(q.*(hcl0 - hcl_conc) + k1.*(ac.^alpha).*(hcl_conc.^beta).*(i2_conc.^gamma).*V - 2.*k2.*ineg_conc == 0);
eqn3 = simplify(q.*(i20 - i2_conc) - k1.*(ac.^alpha).*(hcl_conc.^beta).*(i2_conc.^gamma).*V + k2.*ineg_conc == 0);
eqn4 = simplify(q.*(ineg0 - ineg_conc) + k1.*(ac.^alpha).*(hcl_conc.^beta).*(i2_conc.^gamma).*V - 2.*k2.*ineg_conc == 0);
eqn5 = simplify(q.*(iodo0 - iodo_conc) + k1.*(ac.^alpha).*(hcl_conc.^beta).*(i2_conc.^gamma).*V == 0);

init_guess = [0.001,i20,ineg0,iodo0,100]./2;

for i = 1:length(perc_vary)
    [var1(i),var2(i),var3(i),var4(i),var5(i)] = vpasolve([eqn1(i),eqn2(i),eqn3(i),eqn4(i),eqn5(i)],...
        [hcl_conc,i2_conc,ineg_conc,iodo_conc,V],init_guess);
end

save vpasolvedata_hcl0vary var1 var2 var3 var4 var5
load vpasolvedata_hcl0vary.mat

[hcl_conc,i2_conc,ineg_conc,iodo_conc,V] = deal(var1,var2,var3,var4,var5);

hcl_fix = 0.2184;
i2_fix = 0.0913;
ineg_fix = 0.2174;
iodo_fix = 1.6;
V_fix = 56.6108;
alpha_fix = 0.98760;
beta_fix = 1.00140;
gamma_fix = -0.00032;
a_fix = 1.026063e11; % M^-1.s^-1
ea_fix = 83010.13; % J/mol

perc_hcl = (hcl_conc - hcl_fix)./hcl_fix.*100;
perc_i2 = (i2_conc - i2_fix)./i2_fix.*100;
perc_ineg = (ineg_conc - ineg_fix)./ineg_fix.*100;
perc_iodo = (iodo_conc - iodo_fix)./iodo_fix.*100;
perc_V10 = (V- V_fix)./V_fix.*100;
perc_A = (A - a_fix)./a_fix.*100;

save('vol_percent.mat','perc_V10','-append')

% plot(perc_A,perc_hcl,'k-','linewidth',1.5)
% hold on
% plot(perc_A,perc_i2,'r-','linewidth',1.5)
% plot(perc_A,perc_ineg,'b-','linewidth',1.5)
% plot(perc_A,perc_iodo,'m-','linewidth',1.5)
% plot(perc_A,perc_V,'b--','linewidth',1.5)
% legend
% hold off

%% ANALYZE VARYING [I_2]0
clear
close all

syms hcl_conc i2_conc ineg_conc iodo_conc V
perc_vary = 0.9:0.001:1.1; % 10% smaller and greater

R = 8.314; % J/mol.K
A = 1.026063e11; % M^-1.s^-1
Ea = 83010.13; % J/mol
T = 353; % K
T = perc_vary.*T; 
k1 = A*exp(-Ea./R./T); % M^-1.s^-1
k2 = 0.53; % L/s

q = 10/60; % L/s
q = perc_vary.*q; 

alpha = 0.98760;
beta = 1.00140;
gamma = -0.00032;

ac0 = 2; % M
hcl0 = 0.001; % M
i20 = 1; % M
i20 = perc_vary.*i20; 
ineg0 = 0; % M
iodo0 = 0; % M
conv = 0.8; % acetone conversion
ac = ac0*(1-conv); % M

eqn1 = simplify(q.*(ac0 - ac) - k1.*(ac.^alpha).*(hcl_conc.^beta).*(i2_conc.^gamma).*V == 0);
eqn2 = simplify(q.*(hcl0 - hcl_conc) + k1.*(ac.^alpha).*(hcl_conc.^beta).*(i2_conc.^gamma).*V - 2.*k2.*ineg_conc == 0);
eqn3 = simplify(q.*(i20 - i2_conc) - k1.*(ac.^alpha).*(hcl_conc.^beta).*(i2_conc.^gamma).*V + k2.*ineg_conc == 0);
eqn4 = simplify(q.*(ineg0 - ineg_conc) + k1.*(ac.^alpha).*(hcl_conc.^beta).*(i2_conc.^gamma).*V - 2.*k2.*ineg_conc == 0);
eqn5 = simplify(q.*(iodo0 - iodo_conc) + k1.*(ac.^alpha).*(hcl_conc.^beta).*(i2_conc.^gamma).*V == 0);

init_guess = [hcl0,1,ineg0,iodo0,100]./2;

for i = 1:length(perc_vary)
    [var1(i),var2(i),var3(i),var4(i),var5(i)] = vpasolve([eqn1(i),eqn2(i),eqn3(i),eqn4(i),eqn5(i)],...
        [hcl_conc,i2_conc,ineg_conc,iodo_conc,V],init_guess);
end

save vpasolvedata_i20vary var1 var2 var3 var4 var5
load vpasolvedata_i20vary.mat

[hcl_conc,i2_conc,ineg_conc,iodo_conc,V] = deal(var1,var2,var3,var4,var5);

hcl_fix = 0.2184;
i2_fix = 0.0913;
ineg_fix = 0.2174;
iodo_fix = 1.6;
V_fix = 56.6108;
alpha_fix = 0.98760;
beta_fix = 1.00140;
gamma_fix = -0.00032;
a_fix = 1.026063e11; % M^-1.s^-1
ea_fix = 83010.13; % J/mol

perc_hcl = (hcl_conc - hcl_fix)./hcl_fix.*100;
perc_i2 = (i2_conc - i2_fix)./i2_fix.*100;
perc_ineg = (ineg_conc - ineg_fix)./ineg_fix.*100;
perc_iodo = (iodo_conc - iodo_fix)./iodo_fix.*100;
perc_V11 = (V- V_fix)./V_fix.*100;
perc_A = (A - a_fix)./a_fix.*100;

save('vol_percent.mat','perc_V11','-append')

% plot(perc_A,perc_hcl,'k-','linewidth',1.5)
% hold on
% plot(perc_A,perc_i2,'r-','linewidth',1.5)
% plot(perc_A,perc_ineg,'b-','linewidth',1.5)
% plot(perc_A,perc_iodo,'m-','linewidth',1.5)
% plot(perc_A,perc_V,'b--','linewidth',1.5)
% legend
% hold off

%% PLOT OF VOLUME VARYING
clear
close all

load vol_percent.mat

param_perc = -10:0.1:10;

figure
plot(param_perc,perc_V1,'k-','linewidth',1.5)
hold on
plot(param_perc,perc_V2,'r-','linewidth',1.5)
plot(param_perc,perc_V3,'b-','linewidth',1.5)
plot(param_perc,perc_V4,'m-','linewidth',1.5)
plot(param_perc,perc_V5,'color',[0,100,0]./265,'linewidth',1.5)
legend('\bf\alpha','\bf\beta','\bf\gamma','E_a','A','location','best')
xtickformat('%.0f'); ytickformat('%.0f');
ylim([-20,20])
xlabel('Percent Change in Parameters (%)','fontsize',12,'fontweight','bold')
ylabel('Percent Change in CSTR Volume (%)','fontsize',12,'fontweight','bold')
set(gca,'xcolor',[0 0 0],'ycolor',[0 0 0],'fontname','times',...
    'xminortick','on','yminortick','on','fontsize',12,'linewidth',1.5)
print -djpeg sensitivity_predictedparameters
hold off

figure
plot(param_perc(1:10:end),perc_V6(1:10:end),'ko','linewidth',1.5)
hold on
plot(param_perc(1:1:end),perc_V7(1:1:end),'bs','linewidth',1.5)
plot(param_perc(1:2:end),perc_V8(1:2:end),'rd','linewidth',1.5)
plot(param_perc(1:3:end),perc_V9(1:3:end),'m^','linewidth',1.5)
plot(param_perc(1:4:end),perc_V10(1:4:end),'x','color',[0,100,0]./265,'linewidth',1.5)
plot(param_perc(1:5:end),perc_V11(1:5:end),'h','linewidth',1.5)

legend('k_2','T','q','[CH_3COCH_3]_0','[HCl]_0','[I_2]_0','location','best')
xtickformat('%.0f'); ytickformat('%.0f');
% ylim([-20,20])
xlabel('Percent Change in Parameters (%)','fontsize',12,'fontweight','bold')
ylabel('Percent Change in CSTR Volume (%)','fontsize',12,'fontweight','bold')
set(gca,'xcolor',[0 0 0],'ycolor',[0 0 0],'fontname','times',...
    'xminortick','on','yminortick','on','fontsize',12,'linewidth',1.5)
print -djpeg sensitivity_givenparameters
hold off

