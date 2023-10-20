%% PART 1

% system 4
clc;clear
out=sim('Lab3_Soh_Nguyen_Kho_AbdulKadir_simulink', 20);
figure(1)

subplot(2,1,1)
plot(out.tout,out.Lab3_1_4(:,1),'Linewidth',2,'color','b')
grid on
xlabel('time[unitless]')
ylabel('Input[unitless]')
ylim([-0.1 1.5])
subplot(2,1,2)
plot(out.tout,out.Lab3_1_4(:,2),'Linewidth',2,'color','b')
hold on
plot(out.tout,out.Lab3_1_4(:,3),'--g')
grid on
xlabel('time[unitless]')
ylabel('Output[unitless]')
ylim([-1 2.3])
legend('Estimated','FOPTD','Location','East')
hold off


% system 5
 figure (2)

subplot(2,1,1)
plot(out.tout,out.Lab3_1_5(:,1),'Linewidth',2,'color','b')
xlabel('time[unitless]')
ylabel('Input[unitless]')
grid on
subplot(2,1,2)
plot(out.tout,out.Lab3_1_5(:,2),'Linewidth',2,'color','b')
hold on
plot(out.tout,out.Lab3_1_5(:,3),'--g')
xlabel('time[unitless]')
ylabel('Output[unitless]')
grid on
legend('Estimated','FOPTD','Location','East')
hold off

%% PART 2
close all
alpha = 4.23824963308; tau = 12.1972042132; yinf = 15.56; 
t = alpha:0.01:60; % min, equation applicable only for t > alpha
y = yinf.*(1 - exp(-(t - alpha)./tau));

plot(t,y,'r-','linewidth',1.5)
hold on

% import data from excel
[num,txt,raw] = xlsread('Lab3_Soh_Nguyen_Kho_AbdulKadir_excel.xlsx','Part 2','a5:d32');
t_real = num(:,1); y_treal = num(:,4);

plot(t_real,y_treal,'ko','markersize',8,'markerfacecolor','k')
xlabel('Time (min)','fontname','times','fontweight','bold','fontsize',15); 
ylabel('Deviation in Liquid Level (ft)','fontname','times','fontweight','bold','fontsize',15)
legend('Theoretical Response','Experimental Data','location','southeast','fontsize',15)
xlim([0,70]); ylim([0,20])
ytickformat('%.1f')
set(gca,'linewidth',1.5,'fontname','times','fontsize',15)

print -djpeg part2_lab3

%% PART 3

clc;clear;close all;
%Author: Chaoying 
%Updated 10/05/2021

%%----------------------------------------------------------------------------------------------
%The code is shown as an example to estimate the parameters of
%y(k+1)=phi*y(k)+beta*u(k)
%It is a simplification of the original problem and you should modify the
%code based on the requirements of Lab3 PartIII
%The data given in this example code is not the raw data and you should
%use your own data from previous parts. 

%%----------------------------------------------------------------------------------------------
%extract data from the spreadsheet 
%remember to change the path and filename accordingly 

%%----------------------------------------------------------------------------------------------
%estimate the parameters

error = 1e5; %define the intial error upbound
para_0 = [0.1,0.1,0]; %define initial parameters (phi,beta,m)
para_b = [0, 0, 0]; %initialize a vector to save best parameters

for i = 0:0.01:2 % first parameter (phi) increases by 0.01 for every iteration 
    for j = 0:0.01:3 % second parameter (beta) increases by 0.01 for every iteration
        for m = 1:(length(h))
            para_t = para_0+[i j m]; % para_t to save current parameters 
            RSS = 0;
        
            for k = 1:(length(h)-1) % Indexing each sample point; last point cannot be used
                if k > m
                    temp = (para_t(1)*h(k)+para_t(2)*u(k - para_t(3))-h(k+1))^2; % Error for one sample point
                    % phi*y(k) + beta*u(k-m) - y(k+1)
                    RSS = RSS + temp; % Sum up error for all points
                else
                    temp = (para_t(1)*h(k)+para_t(2)*0 - h(k+1))^2; % Error for one sample point
                    % phi*y(k) + beta*u(k-m) - y(k+1)
                    RSS = RSS + temp;
                end   
            end
            
            % Check if current parameter set has a smaller error than current best
            if RSS < error
                para_b = para_t; % If so, then store this best set in para_b
                error = RSS; % Reset upper bound of error  
            end
                    % THIS PART IS ESSENTIALLY TO MAKE SURE THE CODE KEEPS RUNNING
                    % UNTIL IT FINDS THE LOWEST ERROR EVER         
        end
    end
end