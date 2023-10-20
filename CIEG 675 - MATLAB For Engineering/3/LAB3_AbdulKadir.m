%% CIEG 675 - Matlab For Engineering Analysis (Lab 3)
%% Problem 1
% * Call the function ???

x = 0:0.01:10;
[min_idx,max_idx] = min_max(x);
print -djpeg -r600 Problem1_curve

%% Problem 2
% * 1 x 2 structure array - multidimensional structure
% * 3 fields needed - 1) string (class: char), 2) cell array (class: cell),
% 3) numeric array (class: double)
% * Each dimension will have different things in each field
% * The structure is college, and the fields are major, favorite spots at
% college, and credit hours per semester.
% * Each field doesn't have to be the same length

% First dimension
college.major = 'Business';
college.fav_spots = {'ISE','Perkins','Roots'}; % {} for cell array
college.credits_per_sem = [12 15 15 12 14 15]; % [] for matrices

% Second dimension
college(2).major = 'Engineering';
college(2).fav_spots = {'Morris','Trabant','Gore','Caesar Rodney'};
college(2).credits_per_sem = [15 18 18 16];

%% Problem 3
% * 12 x 1 cell array containing twelve months of the year in order

months = {'January';'February';'March';'April';'May';'June';'July';...
    'August';'September';'October';'November';'December'};
%% Problem 4
% * Call the function??

%% Problem 5
% * Load the data from Atlantic City Temperature Data csv file
% * First column is the dates in MATLAB time, for all day in 2015
% * Second column is the air temperature (degree celcius)
% * Third column is the water temperature (degree celcius)
% * All data are corrected in reference to the first row data
% * Plots of temperature vs. time 

temp_data = dlmread('AtlanticCity_TemperatureData.csv');
% Load data from the said file (no specifier needed like %6.5f cuz dlmread
% can understand the existence of columns and rows in the csv)

temp_data = temp_data - temp_data(1,:); 
% Corrected in reference to first row data

days = temp_data(:,1) + 1; % First column and make day 0 to day 1 
air_temp = temp_data(:,2); % Second column
water_temp = temp_data(:,3); % Third column

figure('name','Water and Air Temperature')
plot(days,air_temp,'k-','linewidth',1.5)
hold on
plot(days,water_temp,'r-','linewidth',1.5)
legend('Air Temperature','Water Temperature','fontweight','bold')
xlabel('Months','fontweight','bold');
ylabel(['Temperature (' char(176) 'C)'],'fontweight','bold');
% use [] to concantenate the naming, and char(176) for the degree symbol
xlim([1,366]);
set(gca,'fontname','times','xcolor',[0 0 0],'ycolor',[0 0 0],'fontsize',12,...
    'xtick',[1,32,60,91,121,152,182,213,244,274,305,335],'xticklabel',months)
set(gcf,'position',[103 70 1000 500],'color',[1 1 1])

print -djpeg Problem5_curve
%% Problem 6
% * Print each line in the surprise.txt file, one character at a time into
% the command window

ct = 0; % a counter
fid = fopen('surprise.txt', 'r'); % open file for reading

% Keep running a loop until EndOfFile (feof)
% (feof(fid) = 1 if end of the file is reached) - 0 otherwise
while feof(fid) ~= 1
    ct = ct + 1; % increase counter by 1
    data{ct} = fgetl(fid); % grab entire line of text from file,
                           % store as string in the ct^th cell
end
fclose(fid); % close file
% ct should be equal to the number of lines of text in the file

for i = 1:ct % Loop over the entire lines
    for j = 1:length(data{i}) % Accessing each character in each cell lines
        fprintf(data{i}(j)) % Print each character j in line i
        pause(1/500); % To ensure one character at a time printed
    end
    fprintf('\n') % To get to a new line
end

%% Problem 7
% * Plot histograms and overlay Gaussian curve on top

y = randn(10000,1); % Generate random # for normal dist.
figure('name','Histograms and Gaussian Distribution')
histogram(y,'normalization','pdf','facecolor','r','edgecolor','k','linewidth',1);
% Plot histograms, with some normalization and probability dist. func.
% (pdf)
hold on

[n,edges] = histcounts(y,'normalization','pdf'); % Info. on the histograms
bins = edges(1:end-1) + diff(edges)/2; % To have the middle points of each bar
new_y = normpdf(bins,0,1); % To create a normalized Gaussian Dist.
plot(bins,new_y,'k-','linewidth',2) 
set(gca,'fontname','times','fontsize',12)
ytickformat('%.2f') % 2 sig. figs on ytick label

print -djpeg -r600 Plot_Prob7

%% Problem 8
% * Perform power spectral density calculation using pwelch
% * Mess with the different parameters (window,noverlap,nfft)
% * Conclude the behavior
% * [Pxx,F] = pwelch(x,window,noverlap,nfft,fs)

t = 0:0.01:10000; % Fs = 1/0.01 = 100; sample frequency
y = 4*cos(2*pi*t) + sin(2*pi*t/0.2) + 0.01*randn(1,length(t)); % fs = 1,5 Hz
% No need to plot this, it's messy

%% Randomize window

% my observation - smaller window, less resolution, can't see the peak
% means more values are segmented into less # of window, so can resolute
% the peak perfectly
% larger window #, better resolution, can be segmented perfectly, see the
% distinction in peaks
% something to do with smoothness

fig_wind = figure('name','PWELCH Randomized WINDOW');
window = [10000,1000,50]; % Default 8
% # of segments I want MATLAB to chop the time series data
% BUT, MATLAB pwelch makes WINDOW value as the # of time series data one
% segment holds, not # of segments to be chopped into

for i = 1:length(window)
    s(i) = subplot(4,1,i);
    [Pxx,F] = pwelch(y,floor(length(y)/window(i)),[],[],100);
    % Rounding down using floor, ceil to round up
    semilogy(F,Pxx,'k-'); legend(['Window = ' num2str(window(i))])
    set(gca,'xticklabel',[],'fontname','times'); xlim([0 10])
end
s(4) = subplot(4,1,4);
[Pxx,F] = pwelch(y,[],[],[],100);
semilogy(F,Pxx,'k-'); legend('Window = 8 (Default)')
set(gca,'fontname','times'); xlim([0 10])

h = axes(fig_wind,'visible','off'); 
% * essentially what this means is making a new axis on the entire figure,
% but make in invisible (so it won't affect the entire plot)
% * restricts linkaxes and zooming the figure

h.XLabel.Visible = 'on';h.YLabel.Visible = 'on'; 
% making the label on for the entire figure altogether (structure method)

xlabel(h,'Frequency (Hz)','fontname','times','fontweight','bold');
ylabel(h,'Power Spectral Density (s^2/Hz)','fontname','times','fontweight','bold')

print -djpeg -r600 Pwelch_WindowRandom

%% Randomize noverlap
% * Noverlap should have a smaller number than window (scalar) or smaller
% length than window (vector)

fig_nover = figure('name','PWELCH Randomized NOVERLAP');
noverlap = [0.25,0.75,1]; % Default 50%; 0.5; less than 8 (window's default)
for i = 1:length(noverlap)
    subplot(2,4,i); % Plot focus on 1 Hz
    [Pxx,F] = pwelch(y,[],noverlap(i)*floor(length(y)/8),[],100); 
    % WINDOW = floor(length(y)/8) is default
    semilogy(F,Pxx,'r-'); legend(['Noverlap = ' num2str(noverlap(i)*100) '%'])
    set(gca,'fontname','times'); xlim([0.95 1.05]); ylim([0 1e6])
    xlabel('Frequency (Hz)','fontname','times','fontweight','bold');
    ylabel('Power Spectral Density (s^2/Hz)','fontname','times','fontweight','bold')
    
    subplot(2,4,4+i); % Plot focus on 5 Hz
    semilogy(F,Pxx,'r-'); legend(['Noverlap = ' num2str(noverlap(i)*100) '%'])
    set(gca,'fontname','times'); xlim([4.95 5.05])
    xlabel('Frequency (Hz)','fontname','times','fontweight','bold');
    ylabel('Power Spectral Density (s^2/Hz)','fontname','times','fontweight','bold')
end
s(4) = subplot(2,4,4); % Plot focus on 1 Hz default
[Pxx,F] = pwelch(y,[],[],[],100);
semilogy(F,Pxx,'r-'); legend('Noverlap = 50% (Default)')
set(gca,'fontname','times'); xlim([0.95 1.05])
xlabel('Frequency (Hz)','fontname','times','fontweight','bold');
ylabel('Power Spectral Density (s^2/Hz)','fontname','times','fontweight','bold')

r(4) = subplot(2,4,8); % Plot focus on 5 Hz default
[Pxx,F] = pwelch(y,[],[],[],100);
semilogy(F,Pxx,'r-'); legend('Noverlap = 50% (Default)')
set(gca,'fontname','times'); xlim([4.95 5.05]);
xlabel('Frequency (Hz)','fontname','times','fontweight','bold');
ylabel('Power Spectral Density (s^2/Hz)','fontname','times','fontweight','bold')

set(gcf,'position',[229 95 993 638])

print -djpeg Pwelch_NoverlapRandom

%% Randomize NFFT
% * Focus on the spectral leakage
% * Higher NFFT, less spectral leakage 
% * All NFFT has been resolved perfectly regardless of NFFT values, just
% the matter of spectral leakage (distinction b/n windows and NFFT)

fig_nfft = figure('name','PWELCH Randomized NFFT');
nfft = [128,512,16384]; % 2^7,9,14
for i = 1:length(nfft)
    s(i) = subplot(4,1,i);
    [Pxx,F] = pwelch(y,[],[],nfft(i),100);
    semilogy(F,Pxx,'b-'); legend(['NFFT = ' num2str(nfft(i))])
    set(gca,'xticklabel',[],'fontname','times'); xlim([0 10])
end
s(4)= subplot(4,1,4);
[Pxx,F] = pwelch(y,[],[],[],100);
semilogy(F,Pxx,'b-'); legend('NFFT = Default')
set(gca,'fontname','times'); xlim([0 10]);

h = axes(fig_nfft,'visible','off'); 
% * essentially what this means is making a new axis on the entire figure,
% but make in invisible (so it won't affect the entire plot)

h.XLabel.Visible = 'on';h.YLabel.Visible = 'on'; 
% making the label on for the entire figure altogether (structure method)

xlabel(h,'Frequency (Hz)','fontname','times','fontweight','bold');
ylabel(h,'Power Spectral Density (s^2/Hz)','fontname','times','fontweight','bold')

print -djpeg -r600 Pwelch_NFFTRandom