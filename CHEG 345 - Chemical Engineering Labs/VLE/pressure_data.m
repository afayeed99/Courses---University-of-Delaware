%% Pressure data

%% 2/25
cd '/Users/fayeed/Desktop/SPRING 2021/CHEG 345 -JLab/VLE/Follow Up/Excel Files/P and T data'

baro_p_feb2526 = xlsread('P and T of 2:25 and 2:26:2021.xlsx','A5:B35');
atm_p_feb2526 = xlsread('P and T of 2:25 and 2:26:2021.xlsx','A41:B329');

cd '/Users/fayeed/Desktop/SPRING 2021/CHEG 345 -JLab/VLE/Follow Up/'

dates_baro = datevec(baro_p_feb2526(:,1)); % convert to yyyy,mm,dd format
dates_baro(:,1) = 2021; dates_baro(:,3) = 25; % correcting the year and day
dates_baro = datenum(dates_baro); % convert back to MATLAB date number
baro_p = baro_p_feb2526(:,2)./750.062; % mmHg to bar

dates_atm = datevec(atm_p_feb2526(:,1)); 
dates_atm(:,1) = 2021; dates_atm(:,3) = dates_atm(:,3) - 1;
dates_atm = datenum(dates_atm);
atm_p = atm_p_feb2526(:,2)./1000; % mbar to bar

plot(dates_baro,baro_p,'ko-','linewidth',1.5)
datetick('x','HH:MM')
hold on
plot(dates_atm,atm_p,'ro-','linewidth',1.5)
%title('February 25^{th}, 2021','fontweight','bold')

legend('Lab Pressure','Atmospheric Pressure','location','northwest')
ytickformat('%.3f'); xlabel('Time (HH:MM)','fontsize',12,'fontweight','bold'); 
ylabel('Pressure (bar)','fontsize',12,'fontweight','bold')
set(gca,'xcolor',[0 0 0],'ycolor',[0 0 0],'fontname','times',...
    'xminortick','on','yminortick','on','linewidth',1.5,'fontsize',12) 
hold off
print -djpeg p_feb25
%% 3/5
cd '/Users/fayeed/Desktop/SPRING 2021/CHEG 345 -JLab/VLE/Follow Up/Excel Files/P and T data'

baro_p_mar5 = xlsread('P and T of 3:5:2021.xlsx','A5:B53');
atm_p_mar5 = xlsread('P and T of 3:5:2021.xlsx','A57:B286');

cd '/Users/fayeed/Desktop/SPRING 2021/CHEG 345 -JLab/VLE/Follow Up/'

dates_baro = datevec(baro_p_mar5(:,1)); % convert to yyyy,mm,dd format
dates_baro(:,1) = 2021; dates_baro(:,3) = 5; % correcting the year and day
dates_baro = datenum(dates_baro); % convert back to MATLAB date number
baro_p = baro_p_mar5(:,2)./750.062; % mmHg to bar

dates_atm = datevec(atm_p_mar5(:,1)); 
dates_atm(:,1) = 2021; dates_atm(:,3) = 5;
dates_atm = datenum(dates_atm);
atm_p = atm_p_mar5(:,2)./1000; % mbar to bar

plot(dates_baro,baro_p,'ko-','linewidth',1.5)
datetick('x','HH:MM')
hold on
plot(dates_atm,atm_p,'ro-','linewidth',1.5)
%title('March 5^{th}, 2021','fontweight','bold')
legend('Lab Pressure','Atmospheric Pressure','location','northeast')
ytickformat('%.3f'); xlabel('Time (HH:MM)','fontsize',12,'fontweight','bold'); 
ylabel('Pressure (bar)','fontsize',12,'fontweight','bold')
set(gca,'xcolor',[0 0 0],'ycolor',[0 0 0],'fontname','times',...
    'xminortick','on','yminortick','on','linewidth',1.5,'fontsize',12) 
hold off
print -djpeg p_mar5
%% 3/8
cd '/Users/fayeed/Desktop/SPRING 2021/CHEG 345 -JLab/VLE/Follow Up/Excel Files/P and T data'

baro_p_mar8 = xlsread('P and T of 3:8:2021.xlsx','A5:B33');
atm_p_mar8 = xlsread('P and T of 3:8:2021.xlsx','A39:B316');

cd '/Users/fayeed/Desktop/SPRING 2021/CHEG 345 -JLab/VLE/Follow Up/'

dates_baro = datevec(baro_p_mar8(:,1)); % convert to yyyy,mm,dd format
dates_baro(:,1) = 2021; dates_baro(:,3) = 8; % correcting the year and day
dates_baro = datenum(dates_baro); % convert back to MATLAB date number
baro_p = baro_p_mar8(:,2)./750.062; % mmHg to bar

dates_atm = datevec(atm_p_mar8(:,1)); 
dates_atm(:,1) = 2021; dates_atm(:,3) = 8;
dates_atm = datenum(dates_atm);
atm_p = atm_p_mar8(:,2)./1000; % mbar to bar

% find the NaN data
n = find(isnan(baro_p)); baro_p(n) = []; dates_baro(n) = [];

plot(dates_baro,baro_p,'ko-','linewidth',1.5)
datetick('x','HH:MM')
hold on
plot(dates_atm,atm_p,'ro-','linewidth',1.5)
%title('March 8^{th}, 2021','fontweight','bold')

legend('Lab Pressure','Atmospheric Pressure','location','northwest')
ytickformat('%.3f'); xlabel('Time (HH:MM)','fontsize',12,'fontweight','bold'); 
ylabel('Pressure (bar)','fontsize',12,'fontweight','bold')
set(gca,'xcolor',[0 0 0],'ycolor',[0 0 0],'fontname','times',...
    'xminortick','on','yminortick','on','linewidth',1.5,'fontsize',12) 
hold off
print -djpeg p_mar8
%% 3/9
cd '/Users/fayeed/Desktop/SPRING 2021/CHEG 345 -JLab/VLE/Follow Up/Excel Files/P and T data'

baro_p_mar9 = xlsread('P and T of 3:9:2021.xlsx','A5:B22');
atm_p_mar9 = xlsread('P and T of 3:9:2021.xlsx','A27:B314');

cd '/Users/fayeed/Desktop/SPRING 2021/CHEG 345 -JLab/VLE/Follow Up/'

dates_baro = datevec(baro_p_mar9(:,1)); % convert to yyyy,mm,dd format
dates_baro(:,1) = 2021; dates_baro(:,3) = 9; % correcting the year and day
dates_baro = datenum(dates_baro); % convert back to MATLAB date number
baro_p = baro_p_mar9(:,2)./750.062; % mmHg to bar

dates_atm = datevec(atm_p_mar9(:,1)); 
dates_atm(:,1) = 2021; dates_atm(:,3) = 9;
dates_atm = datenum(dates_atm);
atm_p = atm_p_mar9(:,2)./1000; % mbar to bar

% find the NaN data
n = find(isnan(baro_p)); baro_p(n) = []; dates_baro(n) = [];

plot(dates_baro,baro_p,'ko-','linewidth',1.5)
datetick('x','HH:MM')
hold on
plot(dates_atm,atm_p,'ro-','linewidth',1.5)
%title('March 9^{th}, 2021','fontweight','bold')

legend('Lab Pressure','Atmospheric Pressure','location','northwest')
ytickformat('%.3f'); xlabel('Time (HH:MM)','fontsize',12,'fontweight','bold'); 
ylabel('Pressure (bar)','fontsize',12,'fontweight','bold')
set(gca,'xcolor',[0 0 0],'ycolor',[0 0 0],'fontname','times',...
    'xminortick','on','yminortick','on','linewidth',1.5,'fontsize',12) 
hold off
print -djpeg p_mar9