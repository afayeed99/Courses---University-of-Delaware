%% TERNARY DIAGRAM
% Acetone - 1, Methanol - 2, Ethanol - 3

% vanLaar parameters
% [a12,a21,a23,a32,a13,a31] = deal(0.3605,0.5192,0.0449,0.3058,0.6062,0.7322);
[a12,a21,a23,a32,a13,a31] = deal(0.8276,0.6282,0.8447,0.6540,0.1764,0.2070);

%0.8068

x1 = 0.00000000001:0.01:1; % predefined
array = zeros(1,3); % predefined array, will removed this row
for i = 1:length(x1)
    x2 = linspace(0,1 - x1(i),length(x1)); 
    % when x1 = 0.3, x2 should only be from 0 - 0.7
    for j = 1:length(x2)
        x3 = 1 - x1(i) - x2(j);
        array = cat(1,array,[x1(i),x2(j),x3]);
    end
end

array(1,:) = []; % remove the first row of 0
% idx = find(array(:,1) == 1); % attempt to remove all 1,0,0 combo
% array(idx(1:end-1),:) = []; % remove, but keep one pair

[x1,x2,x3] = deal(array(:,1),array(:,2),array(:,3));

x2(x2 == 0) = 0.00000000001; 
x3(x3 == 0) = 0.00000000001; 

% w.r.t 1
num1 = x2.^2.*a12.*(a21/a12).^2 + x3.^2.*a13.*(a31/a13).^2 + ...
    x2.*x3.*(a21.*a31./a12./a13).*(a12 + a13 - a23.*a12./a21);
den1 = (x1 + x2.*a21./a12 + x3.*a31./a13).^2;

gamma1 = exp(num1./den1);  

% w.r.t 2

num2 = x1.^2.*a21.*(a12/a21).^2 + x3.^2.*a23.*(a32/a23).^2 + ...
    x1.*x3.*(a12.*a32./a21./a23).*(a21 + a23 - a13.*a21./a12);
den2 = (x2 + x1.*a12./a21 + x3.*a32./a23).^2;

gamma2 = exp(num2./den2);  

% w.r.t 3

num3 = x2.^2.*a32.*(a23/a32).^2 + x1.^2.*a31.*(a13/a31).^2 + ...
    x2.*x1.*(a23.*a13./a32./a31).*(a32 + a31 - a21.*a32./a23);
den3 = (x3 + x2.*a23./a32 + x1.*a13./a31).^2;

gamma3 = exp(num3./den3); 

%
ant_ace = [4.42448,1312.253,-32.445]; % 259.16K - 507.6K
ant_met = [5.20409,1581.341,-33.50]; % 288.1 - 356.83K
ant_eth = [5.24677,1598.673,-46.424]; % 292.77 - 366.63K

syms pres
% using syms for pres as pres varies, so bp for each may change to

bp_ace = ant_ace(2)/(ant_ace(1) - log10(pres)) - ant_ace(3); % 329.0342 K
bp_met = ant_met(2)/(ant_met(1) - log10(pres)) - ant_met(3); % 337.3650 K
bp_eth = ant_eth(2)/(ant_eth(1) - log10(pres)) - ant_eth(3); % 351.1206 K 

%% DO NOT RUN THIS, it will take forever to run, I've saved the data in a file
cd '/Users/fayeed/Desktop/SPRING 2021/CHEG 345 -JLab/VLE/MATLAB'
load phicoeff

phicoeff_ace = phi_coeff(1,:);
phicoeff_met = phi_coeff(2,:);
phicoeff_eth = phi_coeff(3,:);

p = 1.0271; % AVERAGE P OF ALL BINARY MIXTURES
tbp_ace = eval(subs(bp_ace,pres,p));
tbp_met = eval(subs(bp_met,pres,p));
tbp_eth = eval(subs(bp_eth,pres,p));

T = linspace(tbp_ace,tbp_eth,length(x1)); % min - max of the bp
opt = optimset('Display','notify');

tic
t_solve = fsolve(@newoptimizer,T',opt,ant_ace,ant_met,ant_eth,x1,x2,x3,gamma1,gamma2,gamma3,...
    phicoeff_ace,phicoeff_met,phicoeff_eth,p);
toc %102.21 s
% tic
% % for i = 1:length(x1)
% %     t_solve(i) = fsolve(@newoptimizer,T(i),opt,ant_ace,ant_met,ant_eth,...
% %         x1(i),x2(i),x3(i),gamma1(i),gamma2(i),gamma3(i),phicoeff_ace,...
% %         phicoeff_met,phicoeff_eth,p);
% % end
% toc % 83.31 s to run!!!
%% saving t_solve generated above because it took forever to solve
%save NEWT_iterations_ternary t_solve
%% don't run the save anymore, just LOAD!!!!
cd '/Users/fayeed/Desktop/SPRING 2021/CHEG 345 -JLab/VLE/MATLAB'
% load T_iterations_ternary
load NEWT_iterations_ternary

load phicoeff

phicoeff_ace = phi_coeff(1,:);
phicoeff_met = phi_coeff(2,:);
phicoeff_eth = phi_coeff(3,:);

p = 1.0271; % AVERAGE P OF ALL BINARY MIXTURES
pvap1 = 10.^(ant_ace(1) - ant_ace(2)./(t_solve + ant_ace(3)));
pvap2 = 10.^(ant_met(1) - ant_met(2)./(t_solve + ant_met(3)));
pvap3 = 10.^(ant_eth(1) - ant_eth(2)./(t_solve + ant_eth(3)));

phival1 = polyval(phicoeff_ace,t_solve);
phival2 = polyval(phicoeff_met,t_solve);
phival3 = polyval(phicoeff_eth,t_solve);

y1 = x1.*gamma1.*pvap1./p./phival1; 
y2 = x2.*gamma2.*pvap2./p./phival2; 
y3 = x3.*gamma3.*pvap3./p./phival3;

k1 = y1./x1; k2 = y2./x2; k3 = y3./x3; 

%% Contour K = 1 plot
cd '/Users/fayeed/Desktop/SPRING 2021/CHEG 345 -JLab/VLE/MATLAB/Ternary example'

close all

figure

h = terplot;
v = [1,1];

% CONTOUR FOR K1 = 1
[hcont,ccont]=tercontour(x1,x2,x3,k1,v);
% colormap(flipud(parula))
% [hcont,ccont,hcb]=tercontour(x1,x2,x3,k1);

clabel(ccont,hcont,'fontweight','bold','fontname','times','fontsize',15,...
    'LabelSpacing',1000,'color','r');
set(hcont,'linewidth',2,'color','k','linestyle','-')
% set(hcont,'linewidth',2)%,'color','k')

% oldLabelText = get(hcl(1),'String');
% kfactor = str2double(oldLabelText);
% newLabelText = ['K = ' num2str(kfactor)];
% set(hcl(1), 'String', newLabelText);

hold on

% CONTOUR FOR K2 = 1
[hcont,ccont]=tercontour(x1,x2,x3,k2,v);
% [hcont,ccont]=tercontour(x1,x2,x3,k2);

clabel(ccont,hcont,'fontweight','bold','fontname','times','fontsize',18,...
    'LabelSpacing',1000,'color','r');
set(hcont,'linewidth',2,'color','k','linestyle','--');
% set(hcont,'linewidth',2)%,'color','k')

hold on

% CONTOUR FOR K3 = 1
[hcont,ccont,hcb]=tercontour(x1,x2,x3,k3,v);

clabel(ccont,hcont,'fontweight','bold','fontname','times','fontsize',18,...
    'LabelSpacing',1000,'color','k');
set(hcont,'linewidth',2,'color','k','linestyle','-.')

% add the intersection points
hold on
plot(0.265,0,'ro','markersize',8,'markerfacecolor','r','linewidth',1.5)

% Add the labels
text(1.025,-0.025,'Methanol','fontsize',15,'horizontalalignment','left',...
    'verticalalignment','top','fontweight','bold','fontname','times')
text(-0.025,-0.025,'Acetone','fontsize',15,'horizontalalignment','right',...
    'verticalalignment','top','fontweight','bold','fontname','times')
text(0.5,0.9,'Ethanol','fontsize',15,'horizontalalignment','center',...
    'verticalalignment','bottom','fontweight','bold','fontname','times')

set(h,'facecolor',[220,220,220]/230,'edgecolor','k')
set(gcf,'color',[1 1 1],'position',[754   332   657   445])
set(hcb,'visible','off') % turning off labels at the end

handels=terlabel('\it\bfx_{\rm\bfAcetone}','\it\bfx_{\rm\bfMethanol}','\itx_{\rm\bfEthanol}');
set(handels,'fontweight','bold','fontsize',15,'fontname','times')

print -djpeg K1_contour

cd '/Users/fayeed/Desktop/SPRING 2021/CHEG 345 -JLab/VLE/MATLAB'

%% T contouring
close all
cd '/Users/fayeed/Desktop/SPRING 2021/CHEG 345 -JLab/VLE/MATLAB/Ternary example'

set(gcf,'position',[873   368   560   420])
% Plot the ternary axis system
h = terplot;
% Plot the data
% First set the colormap (can't be done afterwards)
v = [min(t_solve),max(t_solve)];
colormap(flipud(hot))
[hcont,ccont,hcb]=tercontour(x1,x2,x3,t_solve,4);

clabel(ccont,hcont,'fontname','times','fontsize',15,'fontweight','bold',...
    'LabelSpacing',500,'color','k');
set(hcont,'linewidth',2)
% [220,220,220]/235
set(h,'facecolor',[220,220,220]/240,'edgecolor','k')
text(1.025,-0.025,'Methanol','fontsize',15,'horizontalalignment','left',...
    'verticalalignment','top','fontweight','bold','fontname','times')
text(-0.025,-0.025,'Acetone','fontsize',15,'horizontalalignment','right',...
    'verticalalignment','top','fontweight','bold','fontname','times')
text(0.5,0.9,'Ethanol','fontsize',15,'horizontalalignment','center',...
    'verticalalignment','bottom','fontweight','bold','fontname','times')
set(gcf,'color',[1 1 1])
set(gcf,'position',[754   332   657   445])

pos = get(gcf,'chi3ldren'); 
pos(2).Position = [0.1,pos(2).Position(2),pos(2).Position(3),pos(2).Position(4)];
pos(1).Position = [0.87,pos(1).Position(2),pos(1).Position(3),pos(1).Position(4)];

set(hcb,'fontname','times','fontsize',15,'linewidth',1.5)
hcb.Label.String = 'Temperature (K)'; hcb.Label.FontWeight = 'bold';
handels=terlabel('\it\bfx_{\rm\bfAcetone}','\it\bfx_{\rm\bfMethanol}','\itx_{\rm\bfEthanol}');
set(handels,'fontweight','bold','fontsize',15,'fontname','times')
print -djpeg T_contourlines

hold on
tval_exp = [333.11,333.11];
[hcont,ccont,hcb]=tercontour(x1,x2,x3,t_solve,tval_exp);
clabel(ccont,hcont,'fontweight','bold','fontname','times','fontsize',15,...
    'LabelSpacing',300,'color','k');
set(hcont,'linewidth',2,'linestyle','--')
set(hcb,'visible','off')
hold off

print -djpeg T_contourlines_newwith_experimentaldata

%% Plotting the ternary with mole fraction lines
set(gcf,'position',[873   368   560   420])
h = terplot;
colormap(flipud(hot))
tval_exp = [333.11,333.11];
[hcont,ccont,hcb]=tercontour(x1,x2,x3,t_solve,tval_exp);
clabel(ccont,hcont,'fontweight','bold','fontname','times','fontsize',15,...
    'LabelSpacing',260,'color','k');
set(hcont,'linewidth',2,'linestyle','-','color','k')
set(hcb,'visible','off')
hold on

x1_exp = 0.3161; x2_exp = 0.4609; x3_exp = 1 - x1_exp - x2_exp; % 0.223
plot([x2_exp,0.5724],[0,0.1931],'k--','linewidth',2)
plot([0.5724,1-0.1115],[0.1931,0.1931],'k--','linewidth',2)
plot([0.3419,0.5724],[0.5922,0.1931],'k--','linewidth',2)
plot(0.5724,0.1931,'ko','markersize',8,'linewidth',2,'markerfacecolor','k')
set(h,'facecolor',[220,220,220]/230,'edgecolor','k')
text(1.025,-0.025,'Methanol','fontsize',15,'horizontalalignment','left',...
    'verticalalignment','top','fontweight','bold','fontname','times')
text(-0.025,-0.025,'Acetone','fontsize',15,'horizontalalignment','right',...
    'verticalalignment','top','fontweight','bold','fontname','times')
text(0.5,0.9,'Ethanol','fontsize',15,'horizontalalignment','center',...
    'verticalalignment','bottom','fontweight','bold','fontname','times')
set(gcf,'color',[1 1 1])
set(gcf,'position',[754   332   657   445])
handels=terlabel('\it\bfx_{\rm\bfAcetone}','\it\bfx_{\rm\bfMethanol}','\itx_{\rm\bfEthanol}');
set(handels,'fontweight','bold','fontsize',15,'fontname','times')

text(0.5,0.4,'\it\bfx_{\rm\bfAce} = \rm\bf0.3161','fontsize',15,'horizontalalignment','left',...
    'verticalalignment','top','fontweight','bold','fontname','times')
text(0.523,0.1,'\it\bfx_{\rm\bfMet} = \rm\bf0.4609','fontsize',15,'horizontalalignment','left',...
    'verticalalignment','top','fontweight','bold','fontname','times')
text(0.7,0.2,'\it\bfx_{\rm\bfEth} = \rm\bf0.2230','fontsize',15,'horizontalalignment','center',...
    'verticalalignment','bottom','fontweight','bold','fontname','times')

print -djpeg T_contour_experimental_calculatedT

%% PLOTTING NEW T CONTOURS FOR AZEOTROPE
close all
set(gcf,'position',[873   368   560   420])
h = terplot;
colormap(flipud(hot))
tval_exp = [328.75,328.75];
[hcont,ccont,hcb]=tercontour(x1,x2,x3,t_solve,tval_exp);
clabel(ccont,hcont,'fontweight','bold','fontname','times','fontsize',12,...
    'LabelSpacing',500,'color','k');
set(hcont,'linewidth',2,'linestyle','-','color','k')
set(hcb,'visible','off')
hold on
plot([0.1346,0.2692],[0.2331,0],'r--','linewidth',2)
plot([0.2692,1],[0,0],'r--','linewidth',2)
plot(0.2692,0,'ro','markersize',8,'linewidth',2,'markerfacecolor','r')
text(0.2,0.2,'\it\bfx_{\rm\bfAce} = \rm\bf0.7308','fontsize',15,'horizontalalignment','left',...
    'verticalalignment','top','fontweight','bold','fontname','times')
text(0.7,0,'\it\bfx_{\rm\bfEth} = \rm\bf0','fontsize',15,'horizontalalignment','center',...
    'verticalalignment','bottom','fontweight','bold','fontname','times')

text(1.025,-0.025,'Methanol','fontsize',15,'horizontalalignment','left',...
    'verticalalignment','top','fontweight','bold','fontname','times')
text(-0.025,-0.025,'Acetone','fontsize',15,'horizontalalignment','right',...
    'verticalalignment','top','fontweight','bold','fontname','times')
text(0.5,0.9,'Ethanol','fontsize',15,'horizontalalignment','center',...
    'verticalalignment','bottom','fontweight','bold','fontname','times')

set(h,'facecolor',[220,220,220]/230,'edgecolor','k')
set(gcf,'color',[1 1 1])
set(gcf,'position',[754   332   657   445])
handels=terlabel('\it\bfx_{\rm\bfAcetone}','\it\bfx_{\rm\bfMethanol}','\itx_{\rm\bfEthanol}');
set(handels,'fontweight','bold','fontsize',15,'fontname','times')
print -djpeg NEWT_contour_experimental_calculatedT
%% Isosurface Ternary of Temperature
close all
cd '/Users/fayeed/Desktop/SPRING 2021/CHEG 345 -JLab/VLE/MATLAB/Ternary example'
colormap(flipud(hot))
[hg,htick,hcb]=tersurf(x1,x2,x3,t_solve);
text(1.025,-0.025,'Methanol','fontsize',15,'horizontalalignment','left',...
    'verticalalignment','top','fontweight','bold','fontname','times')
text(-0.025,-0.025,'Acetone','fontsize',15,'horizontalalignment','right',...
    'verticalalignment','top','fontweight','bold','fontname','times')
text(0.5,0.9,'Ethanol','fontsize',15,'horizontalalignment','center',...
    'verticalalignment','bottom','fontweight','bold','fontname','times')
pos = get(gcf,'children'); 
pos(2).Position = [0.1,pos(2).Position(2),pos(2).Position(3),pos(2).Position(4)];
pos(1).Position = [0.87,pos(1).Position(2),pos(1).Position(3),pos(1).Position(4)];

%--  Change the color of the grid lines
set(hg(:,3),'color','k')
set(hg(:,2),'color','k')
set(hg(:,1),'color','k')

%--  Modify the tick labels
set(htick(:,1),'color','k','linewidth',3)
set(htick(:,2),'color','k','linewidth',3)
set(htick(:,3),'color','k','linewidth',3)

%--  Change the colorbar
set(hcb,'fontname','times','fontsize',15,'linewidth',1.5)
hcb.Label.String = 'Temperature (K)'; hcb.Label.FontWeight = 'bold';

%--  Modify the figure color
set(gcf,'color',[1 1 1])
%-- Change some defaults
set(gcf,'position',[754   332   657   445])
handels=terlabel('\it\bfx_{\rm\bfAcetone}','\it\bfx_{\rm\bfMethanol}','\itx_{\rm\bfEthanol}');
set(handels,'fontweight','bold','fontsize',15,'fontname','times')
print -djpeg T_isosurface
cd '/Users/fayeed/Desktop/SPRING 2021/CHEG 345 -JLab/VLE/MATLAB'

%% EXPERIMENTAL DATA FOR TERNARY
cd '/Users/fayeed/Desktop/SPRING 2021/CHEG 345 -JLab/VLE/MATLAB'
% 1 - acetone, 2 - methanol, 3 - ethanol
% [a12,a21,a23,a32,a13,a31] = deal(0.8068,0.5192,0.0449,0.3058,0.6062,0.7322);
[a12,a21,a23,a32,a13,a31] = deal(0.8276,0.6282,0.8447,0.6540,0.1764,0.2070);
x1 = 0.3161; x2 = 0.4609; x3 = 1 - x1 - x2; % 0.223

num1 = x2.^2.*a12.*(a21/a12).^2 + x3.^2.*a13.*(a31/a13).^2 + ...
    x2.*x3.*(a21.*a31./a12./a13).*(a12 + a13 - a23.*a12./a21);
den1 = (x1 + x2.*a21./a12 + x3.*a31./a13).^2;

gamma1 = exp(num1./den1);  

num2 = x1.^2.*a21.*(a12/a21).^2 + x3.^2.*a23.*(a32/a23).^2 + ...
    x1.*x3.*(a12.*a32./a21./a23).*(a21 + a23 - a13.*a21./a12);
den2 = (x2 + x1.*a12./a21 + x3.*a32./a23).^2;

gamma2 = exp(num2./den2);  

% w.r.t 3

num3 = x2.^2.*a32.*(a23/a32).^2 + x1.^2.*a31.*(a13/a31).^2 + ...
    x2.*x1.*(a23.*a13./a32./a31).*(a32 + a31 - a21.*a32./a23);
den3 = (x3 + x2.*a23./a32 + x1.*a13./a31).^2;

gamma3 = exp(num3./den3); 

load phicoeff
phicoeff_ace = phi_coeff(1,:);
phicoeff_met = phi_coeff(2,:);
phicoeff_eth = phi_coeff(3,:);

p = 1.0271; % AVERAGE P OF ALL BINARY MIXTURES
% p = 756.1/750; % bar, DEOS of the ternary mixture

syms pres
% using syms for pres as pres varies, so bp for each may change to
ant_ace = [4.42448,1312.253,-32.445]; % 259.16K - 507.6K
ant_met = [5.20409,1581.341,-33.50]; % 288.1 - 356.83K
ant_eth = [5.24677,1598.673,-46.424]; % 292.77 - 366.63K

bp_ace = ant_ace(2)/(ant_ace(1) - log10(pres)) - ant_ace(3); % 329.0342 K
bp_met = ant_met(2)/(ant_met(1) - log10(pres)) - ant_met(3); % 337.3650 K
bp_eth = ant_eth(2)/(ant_eth(1) - log10(pres)) - ant_eth(3); % 351.1206 K 

tbp_ace = eval(subs(bp_ace,pres,p));
tbp_met = eval(subs(bp_met,pres,p));
tbp_eth = eval(subs(bp_eth,pres,p));

T = linspace(tbp_ace,tbp_eth,length(x1)); % min - max of the bp
opt = optimset('Display','notify');

t_solve = fsolve(@newoptimizer,T',opt,ant_ace,ant_met,ant_eth,x1,x2,x3,gamma1,gamma2,gamma3,...
    phicoeff_ace,phicoeff_met,phicoeff_eth,p); % 333.11 K

t_recorded = [58.92,58.99] + 273.15; % K, RTD 2 and 3
t_avg_rtd = mean(t_recorded); % 332.105 K

% (exp - theory) / theory, use P from analysis, not the recorded
t_error = abs(t_avg_rtd - t_solve)/t_solve*100;