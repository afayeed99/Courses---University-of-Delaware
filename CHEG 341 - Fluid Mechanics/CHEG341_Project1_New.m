t = linspace(0,1000,1001); % s
cv_fix = 0.61; % fix value of cv
cv = linspace(0.2,1,5);
a2a1 = 1/900; % ratio of outlet area to surface
z0 = 1.421; % initial height, m
g = 9.81; % m/s^2 
a2 = 5.067e-4; % area of outlet, m^2

z1 = (sqrt(z0) - cv_fix/2*a2a1*sqrt(2*g).*t).^2;
q1 = cv_fix*a2*sqrt(2*g)*(sqrt(z0) - cv_fix/2*a2a1*sqrt(2*g).*t);
%% *Plot of z(t) and Q(t) vs t for many Cv (w/ fixed Cv too)*

for i = 1:length(cv)
    z2 = (sqrt(z0) - cv(i)/2*a2a1*sqrt(2*g).*t).^2;
    plot(t,z2,'linewidth',1.5)
    hold on
end
plot(t,z1,'color','k','LineWidth',1.5,'LineStyle',"--")
xlabel('\bf \fontname{Times} Time (s)')
ylabel('\bf \fontname{Times} Height of Fluid (m)')
legend('C_V = 0.20','C_V = 0.40','C_V = 0.60','C_V = 0.80','C_V = 1.00','C_V = 0.61')
ax = gca; ax.FontSize = 15; ax.FontName = 'times'; ax.LineWidth = 1.5; 
ax.XLim = [0 800];ax.YLim = [0 1.5]; ytickformat('%.1f')
hold off

for i = 1:length(cv)
    q2 = cv(i)*a2*sqrt(2*g)*(sqrt(z0) - cv(i)/2*a2a1*sqrt(2*g).*t);
    plot(t,q2,'linewidth',1.5)
    hold on
end
plot(t,q1,'color','k','LineWidth',1.5,"LineStyle","--")
yline(8.172e-3,'color','k','linewidth',1.5,'linestyle','--');
text(100,7.8e-3,"Q = 8.172 x 10^-^3 m^3/s from Scenario I",'FontName','times', ...
    "FontWeight","bold","FontSize",15)
xlabel('\bf \fontname{Times} Time (s)')
ylabel('\bf \fontname{Times} Volumetric Flow Rate (m^3/s)')
legend('C_V = 0.20','C_V = 0.40','C_V = 0.60','C_V = 0.80','C_V = 1.00','C_V = 0.61')
ax = gca; ax.FontSize = 15; ax.FontName = 'times'; ax.LineWidth = 1.5; 
ax.XLim = [0 800];ax.YLim = [0 9e-3];ytickformat('%.1f')
hold off
%% Plot of z(t) and Q(t) vs t for Cv = 0.61 with many N2 pressure

P1 = linspace(0,3e5,7); % Pa, pressure inlet
rho = 1400; % kg/m^3

for i = 1:length(P1)
    z3 = 1/g*((sqrt(P1(i)/rho + z0*g) - sqrt(2)/2*g*cv_fix*a2a1.*t).^2 - P1(i)/rho);
    plot(t,z3,'linewidth',1.5)
    hold on
end
xlabel('\bf \fontname{Times} Time (s)')
ylabel('\bf \fontname{Times} Height of Fluid (m)')
legend('P_I_n_l_e_t = 0 kPa','P_I_n_l_e_t = 50 kPa','P_I_n_l_e_t = 100 kPa','P_I_n_l_e_t = 150 kPa', ...
    'P_I_n_l_e_t = 200 kPa','P_I_n_l_e_t = 250 kPa','P_I_n_l_e_t = 300 kPa')
ax = gca; ax.FontSize = 15; ax.FontName = 'times'; ax.LineWidth = 1.5; 
ax.XLim = [0 800];ax.YLim = [0 1.5];ytickformat('%.1f')
hold off

for i = 1:length(P1)
    q3 = cv_fix*a2*sqrt(2*(sqrt(P1(i)/rho + z0*g) - sqrt(2)/2*g*cv_fix*a2a1.*t).^2);
    plot(t,q3,'linewidth',1.5)
    hold on
end
xlabel('\bf \fontname{Times} Time (s)')
ylabel('\bf \fontname{Times} Volumetric Flow Rate (m^3/s)')
legend('P_I_n_l_e_t = 0 kPa','P_I_n_l_e_t = 50 kPa','P_I_n_l_e_t = 100 kPa','P_I_n_l_e_t = 150 kPa', ...
    'P_I_n_l_e_t = 200 kPa','P_I_n_l_e_t = 250 kPa','P_I_n_l_e_t = 300 kPa')
ax = gca; ax.FontSize = 15; ax.FontName = 'times'; ax.LineWidth = 1.5; 
ax.XLim = [0 800];ax.YLim = [0 9e-3];ytickformat('%.1f')
hold off