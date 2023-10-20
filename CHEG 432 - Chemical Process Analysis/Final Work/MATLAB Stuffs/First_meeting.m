%% NOTES TO MYSELF
% alpha the same for both route
% n will differ based on BFD
% FI_c and FI_e depend on the FI_ratio pre-determined (0-2 maybe)
% VC MIGHT be different too, and prod_rate can be different too
% Thus, transfer price will differ, then find the difference in price
clear all; close all
%% Plotting

FI_ratio = 0.001:0.1:4; % carbonylation-esterification FI ratio (double loop)
for i = 1:length(FI_ratio)

    % Carbonylation

    FIc = 1:1:1000; % predetermined based on anything we want, and depending on the ratio

    for j = 1:length(FIc)
        alpha = 0.25/0.75; % fixed for NROI = 25% 
        nc = 7; % number of employees (will change depends on BFD)
        VCc = 206.7; % depends on the ingredient cost, $MM/yr
        Rc = ((1 + 0.14/12)*alpha + 0.1484)*FIc(j) + (alpha/6 + 1.06)*VCc + (0.067*alpha + 0.848)*nc; % revenue equation

        prod_rate_c = 375; % 375 MMppy MeOAc
        t_price_c = Rc/prod_rate_c; %transfer price for carbonylation

        % Esterification

        FIe = FIc(j)/FI_ratio(i); % esterification FI (might do in loop so FI_new has one value only)
        ne = 5; % number of employees (will change depends on BFD)
        VCe = 358.9; % depends on the ingredient cost, $MM/yr
        Re = ((1 + 0.14/12)*alpha + 0.1484)*FIe + (alpha/6 + 1.06)*VCe + (0.067*alpha + 0.848)*ne; % revenue equation

        prod_rate_e = 375; % 375 MMppy MeOAc
        t_price_e = Re/prod_rate_e; % transfer price for carbonylation % will be $/ppy

        diff_t(j) = t_price_c - t_price_e; 
        price_collection(i,j) = diff_t(j); % same ratio for each row, varying FIc each column
    end
% plot(FIc,diff_t)
% hold on
end

%% FINDING THE CHANGE IN SIGN

FI_act = zeros(1,length(FI_ratio));

for k = 1:length(FI_ratio)
    x = price_collection(k,:);
    n = find(x(1:end-1) < 0 & x(2:end) > 0); % finding where it changes sign from neg to pos
    
    if isempty(n) == 1
        n = NaN;
        FI_act(k) = NaN;
    else
        n1 = n; n2 = n + 1;
        FI1 = FIc(n1); FI2 = FIc(n2);
        x1 = x(n1); x2 = x(n2);
        FI_act(k) = -x1*(FI2 - FI1)/(x2 - x1) + FI1; 
        % linear interpolation for FI with transfer price = 0 
    end
end

close all
plot(FI_act,FI_ratio,'r-','linewidth',1.5)

xlabel('Carbonylation Critical FI ($MM/yr)','fontweight','bold','fontsize',15)
ylabel('FI Ratio (Carbonylation to Esterification)','fontweight','bold','fontsize',15)
set(gca,'linewidth',1.5,'fontsize',20)%,'fontname','times')
set(gcf,'position',[440   188   790   610])

ytickformat('%.1f'); ylim([1,5])
print -djpeg NROI