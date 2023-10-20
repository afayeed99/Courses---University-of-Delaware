%% TEMPERATURE VS. TIME DATA

%% AM data from lab

cd '/Users/fayeed/Desktop/SPRING 2021/CHEG 345 -JLab/VLE/Follow Up/Excel Files/Injection Data/AM'

a_AMdata = xlsread('Injection Data of AM 2:25 & 2:26:2021.xlsx','A into M','A6:B130');
m_AMdata = xlsread('Injection Data of AM 2:25 & 2:26:2021.xlsx','M into A','A6:B104');

cd '/Users/fayeed/Desktop/SPRING 2021/CHEG 345 -JLab/VLE/Follow Up'

ta_am = a_AMdata(:,1); tm_am = m_AMdata(:,1); % times elapsed, minutes
temp_a_am = a_AMdata(:,2); temp_m_am = m_AMdata(:,2); % degree C
%% Plotting the raw data

% a of am
plot(ta_am,temp_a_am,'ko','linewidth',1.5,'markersize',5)
hold on
plot(ta_am,temp_a_am,'k-','linewidth',0.5,'markersize',5)
injpt = [1,22,44,73,102]; 
inj = plot(ta_am(injpt),temp_a_am(injpt),'ro','linewidth',1.5,'markersize',7,...
    'markerfacecolor','r');
xtickformat('%.1f'); ytickformat('%.2f'); xlim([0,100])
xlabel('Times Elapsed (min)','fontweight','bold')
ylabel(['Temperature (' char(176) 'C)'],'fontweight','bold')
legend(inj,'Injection Point','fontsize',12)
set(gca,'xcolor',[0 0 0],'ycolor',[0 0 0],'fontname','times',...
    'xminortick','on','yminortick','on','fontsize',12,'linewidth',1.5)

print -djpeg Traw_a_am
%%
% m of am
plot(tm_am,temp_m_am,'ko','linewidth',1.5,'markersize',5)
hold on
plot(tm_am,temp_m_am,'k-','linewidth',0.5,'markersize',5)
injpt = [1,18,37,56,78];
inj = plot(tm_am(injpt),temp_m_am(injpt),'ro','linewidth',1.5,'markersize',7,...
    'markerfacecolor','r');
xtickformat('%.1f'); ytickformat('%.2f'); xlim([0,90])
xlabel('Times Elapsed (min)','fontweight','bold')
ylabel(['Temperature (' char(176) 'C)'],'fontweight','bold')
legend(inj,'Injection Point','fontsize',12)
set(gca,'xcolor',[0 0 0],'ycolor',[0 0 0],'fontname','times',...
    'xminortick','on','yminortick','on','fontsize',12,'linewidth',1.5)

print -djpeg Traw_m_am
%% Corrected for averaging
a_am = [17:21,39:43,68:72,97:101,121:125];
m_am = [13:17,32:36,51:55,73:77,95:99];
texta_idx = [17,39,68,97,121]; textm_idx = [13,32,51,73,95];

plot(ta_am(a_am),temp_a_am(a_am),'ko','linewidth',1.5,'markersize',5)
xtickformat('%.1f'); ytickformat('%.2f'); xlim([0,100]); ylim([60.5,64.5])
xlabel('Times Elapsed (min)','fontweight','bold')
ylabel(['Temperature (' char(176) 'C)'],'fontweight','bold')
%title('Acetone Injected into Methanol','fontweight','bold')
set(gca,'xcolor',[0 0 0],'ycolor',[0 0 0],'fontname','times',...
    'xminortick','on','yminortick','on','fontsize',12,'linewidth',1.5) 
for i = 1:length(texta_idx)
    text(ta_am(texta_idx(i)),temp_a_am(texta_idx(i)) + 0.15,['Inj. ', num2str(i)],...
        'horizontalalignment','left','verticalalignment','bottom',...
        'fontweight','bold','fontsize',12,'fontname','times')
end
print -djpeg Tvstime_a_am
%%

plot(tm_am(m_am),temp_m_am(m_am),'ko','linewidth',1.5,'markersize',5)
xtickformat('%.1f'); ytickformat('%.2f'); xlim([0,100]); ylim([55.6,56.8])
xlabel('Times Elapsed (min)','fontweight','bold')
ylabel(['Temperature (' char(176) 'C)'],'fontweight','bold')
%title('Methanol Injected into Acetone','fontweight','bold')
set(gca,'xcolor',[0 0 0],'ycolor',[0 0 0],'fontname','times',...
    'xminortick','on','yminortick','on','fontsize',12,'linewidth',1.5) 

for i = 1:length(textm_idx)
    text(tm_am(textm_idx(i)),temp_m_am(textm_idx(i)) + 0.05,['Inj. ', num2str(i)],...
        'horizontalalignment','left','verticalalignment','bottom',...
        'fontweight','bold','fontsize',12,'fontname','times')
end

print -djpeg Tvstime_m_am

%% ME data from lab

cd '/Users/fayeed/Desktop/SPRING 2021/CHEG 345 -JLab/VLE/Follow Up/Excel Files/Injection Data/ME'

m_MEdata = xlsread('Injection Data of ME 3:5 & 3:9:2021.xlsx','M into E','A6:B133');
e_MEdata = xlsread('Injection Data of ME 3:5 & 3:9:2021.xlsx','E into M','A5:B136');

cd '/Users/fayeed/Desktop/SPRING 2021/CHEG 345 -JLab/VLE/Follow Up'

tm_me = m_MEdata(:,1); te_me = e_MEdata(:,1); % minutes
temp_m_me = m_MEdata(:,2); temp_e_me = e_MEdata(:,2); % K

%% Plotting the raw data

% m of me
plot(tm_me,temp_m_me,'ko','linewidth',1.5,'markersize',5)
hold on
plot(tm_me,temp_m_me,'k-','linewidth',0.5,'markersize',5)
injpt = [1,30,55,79,103]; 
inj = plot(tm_me(injpt),temp_m_me(injpt),'ro','linewidth',1.5,'markersize',7,...
    'markerfacecolor','r');
xtickformat('%.1f'); ytickformat('%.2f'); xlim([0,100])
xlabel('Times Elapsed (min)','fontweight','bold')
ylabel(['Temperature (' char(176) 'C)'],'fontweight','bold')
legend(inj,'Injection Point','fontsize',12)
set(gca,'xcolor',[0 0 0],'ycolor',[0 0 0],'fontname','times',...
    'xminortick','on','yminortick','on','fontsize',12,'linewidth',1.5)

print -djpeg Traw_m_me
%%
% e of me
plot(te_me,temp_e_me,'ko','linewidth',1.5,'markersize',5)
hold on
plot(te_me,temp_e_me,'k-','linewidth',0.5,'markersize',5)
injpt = [1,30,53,80,107];
inj = plot(te_me(injpt),temp_e_me(injpt),'ro','linewidth',1.5,'markersize',7,...
    'markerfacecolor','r');
xtickformat('%.1f'); ytickformat('%.2f'); xlim([0,80])
xlabel('Times Elapsed (min)','fontweight','bold')
ylabel(['Temperature (' char(176) 'C)'],'fontweight','bold')
legend(inj,'Injection Point','fontsize',12)
set(gca,'xcolor',[0 0 0],'ycolor',[0 0 0],'fontname','times',...
    'xminortick','on','yminortick','on','fontsize',12,'linewidth',1.5)

print -djpeg Traw_e_me
%% Corrected for averaging

m_me = [25:29,50:54,74:78,98:102,123:128];
e_me = [25:29,48:52,75:79,102:106,128:132];
textm_idx = [25,50,74,98,123]; texte_idx = [25,48,75,102,128];

plot(tm_me(m_me),temp_m_me(m_me),'ko','linewidth',1.5,'markersize',5)
xtickformat('%.1f'); ytickformat('%.2f'); xlim([0,100]); ylim([76,78.5])
xlabel('Times Elapsed (min)','fontweight','bold')
ylabel(['Temperature (' char(176) 'C)'],'fontweight','bold')
%title('Methanol Injected into Ethanol','fontweight','bold')
set(gca,'xcolor',[0 0 0],'ycolor',[0 0 0],'fontname','times',...
    'xminortick','on','yminortick','on','fontsize',12,'linewidth',1.5) 
for i = 1:length(textm_idx)
    text(tm_me(textm_idx(i)),temp_m_me(textm_idx(i)) + 0.15,['Inj. ', num2str(i)],...
        'horizontalalignment','left','verticalalignment','bottom',...
        'fontweight','bold','fontsize',12,'fontname','times')
end
print -djpeg Tvstime_m_me
%%

plot(te_me(e_me),temp_e_me(e_me),'ko','linewidth',1.5,'markersize',5)
xtickformat('%.1f'); ytickformat('%.2f'); xlim([0,100]); ylim([65,66.2])
xlabel('Times Elapsed (min)','fontweight','bold')
ylabel(['Temperature (' char(176) 'C)'],'fontweight','bold')
%title('Ethanol Injected into Methanol','fontweight','bold')
set(gca,'xcolor',[0 0 0],'ycolor',[0 0 0],'fontname','times',...
    'xminortick','on','yminortick','on','fontsize',12,'linewidth',1.5) 


for i = 1:length(texte_idx)
    text(te_me(texte_idx(i)),temp_e_me(texte_idx(i)) + 0.05,['Inj. ', num2str(i)],...
        'horizontalalignment','left','verticalalignment','bottom',...
        'fontweight','bold','fontsize',12,'fontname','times')
end

print -djpeg Tvstime_e_me

%% AE data from lab

cd '/Users/fayeed/Desktop/SPRING 2021/CHEG 345 -JLab/VLE/Follow Up/Excel Files/Injection Data/AE'

a_AEdata = xlsread('Injection Data of AE 3:9 & 3:8:2021.xlsx','A into E','A7:B166');
e_AEdata = xlsread('Injection Data of AE 3:9 & 3:8:2021.xlsx','E into A','A5:B192');

cd '/Users/fayeed/Desktop/SPRING 2021/CHEG 345 -JLab/VLE/Follow Up'

ta_ae = a_AEdata(:,1); te_ae = e_AEdata(:,1); % times elapsed, minutes
temp_a_ae = a_AEdata(:,2); temp_e_ae = e_AEdata(:,2); % degree C

%% Plotting the raw data

% a of ae
plot(ta_ae,temp_a_ae,'ko','linewidth',1.5,'markersize',5)
hold on
plot(ta_ae,temp_a_ae,'k-','linewidth',0.5,'markersize',5)
injpt = [1,33,67,92,131]; 
inj = plot(ta_ae(injpt),temp_a_ae(injpt),'ro','linewidth',1.5,'markersize',7,...
    'markerfacecolor','r');
xtickformat('%.1f'); ytickformat('%.2f'); xlim([0,120])
xlabel('Times Elapsed (min)','fontweight','bold')
ylabel(['Temperature (' char(176) 'C)'],'fontweight','bold')
legend(inj,'Injection Point','fontsize',12)
set(gca,'xcolor',[0 0 0],'ycolor',[0 0 0],'fontname','times',...
    'xminortick','on','yminortick','on','fontsize',12,'linewidth',1.5)

print -djpeg Traw_a_ae
%%
% e of ae
plot(te_ae,temp_e_ae,'ko','linewidth',1.5,'markersize',5)
hold on
plot(te_ae,temp_e_ae,'k-','linewidth',0.5,'markersize',5)
injpt = [1,44,87,119,154];
inj = plot(te_ae(injpt),temp_e_ae(injpt),'ro','linewidth',1.5,'markersize',7,...
    'markerfacecolor','r');
xtickformat('%.1f'); ytickformat('%.2f'); xlim([0,140])
xlabel('Times Elapsed (min)','fontweight','bold')
ylabel(['Temperature (' char(176) 'C)'],'fontweight','bold')
legend(inj,'Injection Point','fontsize',12)
set(gca,'xcolor',[0 0 0],'ycolor',[0 0 0],'fontname','times',...
    'xminortick','on','yminortick','on','fontsize',12,'linewidth',1.5)

print -djpeg Traw_e_ae
%% Corrected for averaging

a_ae = [28:32,62:66,87:91,126:130,156:160];
e_ae = [39:43,82:86,114:118,149:153,184:188];
texta_idx = [28,62,87,126,156]; texte_idx = [39,82,114,149,184];

plot(ta_ae(a_ae),temp_a_ae(a_ae),'ko','linewidth',1.5,'markersize',5)
xtickformat('%.1f'); ytickformat('%.2f'); xlim([0,140]); ylim([73.5,78])
xlabel('Times Elapsed (min)','fontweight','bold')
ylabel(['Temperature (' char(176) 'C)'],'fontweight','bold')
%title('Acetone Injected into Ethanol','fontweight','bold')
set(gca,'xcolor',[0 0 0],'ycolor',[0 0 0],'fontname','times',...
    'xminortick','on','yminortick','on','fontsize',12,'linewidth',1.5) 

for i = 1:length(texta_idx)
    text(ta_ae(texta_idx(i)),temp_a_ae(texta_idx(i)) + 0.2,['Inj. ', num2str(i)],...
        'horizontalalignment','left','verticalalignment','bottom',...
        'fontweight','bold','fontsize',12,'fontname','times')
end
print -djpeg Tvstime_a_ae
%%

plot(te_ae(e_ae),temp_e_ae(e_ae),'ko','linewidth',1.5,'markersize',5)
xtickformat('%.1f'); ytickformat('%.2f'); xlim([0,140]); ylim([56.6,57.8])
xlabel('Times Elapsed (min)','fontweight','bold')
ylabel(['Temperature (' char(176) 'C)'],'fontweight','bold')
%title('Ethanol Injected into Acetone','fontweight','bold')
set(gca,'xcolor',[0 0 0],'ycolor',[0 0 0],'fontname','times',...
    'xminortick','on','yminortick','on','fontsize',12,'linewidth',1.5) 

for i = 1:length(texte_idx)
    text(te_ae(texte_idx(i)),temp_e_ae(texte_idx(i)) + 0.07,['Inj. ', num2str(i)],...
        'horizontalalignment','left','verticalalignment','bottom',...
        'fontweight','bold','fontsize',12,'fontname','times')
end

print -djpeg Tvstime_e_ae