%% Yield of Stuffs/Flow of stuffs

%% MeOH Flow
clear; close all

range_vary = 0.8:0.001:1.2;
range_vary = range_vary';

prod = 170; % MM kg/yr meoac production

%prod = prod.*range_vary;

vga = 55; % specify vga values $MM

%vga = vga.*range_vary;


% specify at the very beginning
meoh_flow = 0.999*700;
co_flow = 0.995*452.278;
h2_flow = 0.005*452.78 + 100;
cat_cost = 154420 + 5460000 - 0.00005*170*10^6*2; % $ from VGA or sizing

meoh_flow = meoh_flow.*range_vary;

meoh_qpu = meoh_flow.*32.04.*8000./(prod.*10.^6);
co_qpu = co_flow.*28.01.*8000./(prod.*10.^6);
h2_qpu = h2_flow.*2.*8000./(prod.*10.^6);
cat_qpu = (cat_cost./70)./2./(prod.*10.^6);
meoh_unit = 0.62; % $/kg
co_unit = 0.205; % $/kg
h2_unit = 2;
cat_unit = 70; % $/kg

%meoh_unit = meoh_unit.*range_vary;
%co_unit = co_unit.*range_vary;
%cat_unit = cat_unit.*range_vary;

meoh_pr = meoh_qpu.*meoh_unit;
co_pr = co_qpu.*co_unit;
h2_pr = h2_qpu.*h2_unit;
cat_pr = cat_qpu.*cat_unit;

meoh_mm = prod.*meoh_pr;
co_mm = prod.*co_pr;
h2_mm = prod.*h2_pr;
cat_mm = prod.*cat_pr;

total_ing_mm = meoh_mm + co_mm + cat_mm + h2_mm; % might add another cat

byprod_qpu = 0; % might be 0
byprod_unit = 0; % might be 0
waste_fuel_unit = 3.61; 
waste_fuel_flashtank = 5080; 

byprod_pr = byprod_qpu.*byprod_unit;
waste_fuel_pr = waste_fuel_unit.*waste_fuel_flashtank./10^6;

byprod_mm = byprod_pr.*prod;
waste_fuel_mm = waste_fuel_pr.*prod;

total_cred_mm = byprod_mm + waste_fuel_mm; 
cool_flow = 0.300464; % MMGal/hr

%steam_flow = steam_flow.*range_vary;
%el_flow = el_flow.*range_vary;
%cool_flow = cool_flow.*range_vary;

steam_qpu = steam_flow.*1000.*8000./(prod.*10.^6);
steam_unit = 1.93;

el_qpu = el_flow.*8000./(prod.*10.^6);
el_unit = 0.061;

cool_qpu = cool_flow.*10.^6.*8000./(prod.*10.^6);
cool_unit = 0.075;

ref_price_aspen = 50;

%steam_unit = steam_unit.*range_vary;
%el_unit = el_unit.*range_vary;
%cool_unit = cool_unit.*range_vary;
%ref_price_aspen = ref_price_aspen.*range_vary;

steam_pr = steam_qpu.*steam_unit./1000;
electricity_pr = el_qpu.*el_unit;
cooling_pr = cool_qpu.*cool_unit./1000;

steam_mm = prod.*steam_pr;
electricty_mm = prod.*electricity_pr;
refrigerant_mm = ref_price_aspen.*8000./10^6; % fix myself
refrigerant_pr = refrigerant_mm./prod; 
cooling_mm = prod.*cooling_pr;

total_uti_mm = steam_mm + electricty_mm + refrigerant_mm + cooling_mm; % depends what utility

gas_qpu = 0;
gas_unit = 0;
liq_qpu = 0;
liq_unit = 0;
sol_qpu = 0;
sol_unit = 0;

gas_pr = gas_qpu.*gas_unit;
liq_pr = liq_qpu.*liq_unit;
sol_pr = sol_qpu.*sol_unit;

gas_mm = gas_pr.*prod;
liq_mm = liq_pr.*prod;
sol_mm = sol_pr.*prod;

total_waste_mm = gas_mm + liq_mm + sol_mm; % might be nothing

total_vc_mm = total_ing_mm - total_cred_mm + total_uti_mm + total_waste_mm; 

% specify at the very beginning
num_op = 9;
op_perhour = 32;
other_employ_perc = 0.45; % 45%
unit_sup_perc = 1; % 100%
plant_ov_perc = 0.5; %50%
main_perc = 0.03; %3%
tax_perc = 0.02; %2%
dep_perc = 0.09; %9%

%num_op = num_op.*range_vary;
%op_perhour = op_perhour.*range_vary;

op_mm = num_op.*op_perhour.*365.*24./10^6;
other_employ_mm = other_employ_perc.*op_mm; 
unit_sup_mm = unit_sup_perc.*op_mm;
plant_ov_mm = plant_ov_perc.*op_mm;
main_mm = main_perc.*vga;
tax_mm = tax_perc.*vga;
dep_mm = dep_perc.*vga;

total_fc_mm = op_mm + other_employ_mm + unit_sup_mm + plant_ov_mm + main_mm + ...
    tax_mm + dep_mm; 

total_com_mm = total_vc_mm + total_fc_mm;

raw_inv = total_ing_mm./12;
prod_inv = total_com_mm./12;
total_inv = vga + raw_inv + prod_inv; 

tax_rate = 0.25; %25% tax rate on earnings
%tax_rate = tax_rate.*range_vary;
nroi_mm = 0.25.*total_inv./(1-tax_rate); % goal is to earn 25% NROI
nroi = nroi_mm./prod;

%specify at the beginning
bus_ov_perc = 0.06; 

ing_pr = meoh_pr + co_pr + h2_pr + cat_pr;
cred_pr = byprod_pr + waste_fuel_pr;
uti_pr = steam_pr + electricity_pr + refrigerant_pr + cooling_pr;
waste_pr = gas_pr + liq_pr + sol_pr;

vc_pr = ing_pr - cred_pr + uti_pr + waste_pr;

fc_pr = total_fc_mm./prod;
com_pr = fc_pr + vc_pr;
bus_ov_pr = bus_ov_perc.*com_pr;

total_sales_cost = com_pr + bus_ov_pr;
tp = nroi + total_sales_cost;

plot((range_vary-1).*100,tp.*1000,'linewidth',1.5)
xlabel('Variations in Parameters (%)','fontweight','bold')
ylabel('Transfer Price ($/tonnes)','fontweight','bold')
set(gca,'linewidth',1.5,'fontsize',15)
set(gcf,'position',[440 205 765 593])
ytickformat('%.0f')
hold on
%%

%% CO Flow
clear; 

range_vary = 0.8:0.001:1.2;
range_vary = range_vary';

prod = 170; % MM kg/yr meoac production

%prod = prod.*range_vary;

vga = 55; % specify vga values $MM

%vga = vga.*range_vary;


% specify at the very beginning
meoh_flow = 0.999*700;
co_flow = 0.995*452.278;
h2_flow = 0.005*452.78 + 100;
cat_cost = 154420 + 5460000 - 0.00005*170*10^6*2; % $ from VGA or sizing
co_flow = co_flow.*range_vary;

meoh_qpu = meoh_flow.*32.04.*8000./(prod.*10.^6);
co_qpu = co_flow.*28.01.*8000./(prod.*10.^6);
h2_qpu = h2_flow.*2.*8000./(prod.*10.^6);
cat_qpu = (cat_cost./70)./2./(prod.*10.^6);
meoh_unit = 0.62; % $/kg
co_unit = 0.205; % $/kg
h2_unit = 2;
cat_unit = 70; % $/kg

%meoh_unit = meoh_unit.*range_vary;
%co_unit = co_unit.*range_vary;
%cat_unit = cat_unit.*range_vary;

meoh_pr = meoh_qpu.*meoh_unit;
co_pr = co_qpu.*co_unit;
h2_pr = h2_qpu.*h2_unit;
cat_pr = cat_qpu.*cat_unit;

meoh_mm = prod.*meoh_pr;
co_mm = prod.*co_pr;
h2_mm = prod.*h2_pr;
cat_mm = prod.*cat_pr;

total_ing_mm = meoh_mm + co_mm + cat_mm + h2_mm; % might add another cat

byprod_qpu = 0; % might be 0
byprod_unit = 0; % might be 0
waste_fuel_unit = 3.61; 
waste_fuel_flashtank = 5080; 

byprod_pr = byprod_qpu.*byprod_unit;
waste_fuel_pr = waste_fuel_unit.*waste_fuel_flashtank./10^6;

byprod_mm = byprod_pr.*prod;
waste_fuel_mm = waste_fuel_pr.*prod;

total_cred_mm = byprod_mm + waste_fuel_mm; 

% specify at the very beginning

steam_flow = 12; % klb/hr
el_flow = 100; % kW
cool_flow = 0.300464; % MMGal/hr

%steam_flow = steam_flow.*range_vary;
%el_flow = el_flow.*range_vary;
%cool_flow = cool_flow.*range_vary;

steam_qpu = steam_flow.*1000.*8000./(prod.*10.^6);
steam_unit = 1.93;

el_qpu = el_flow.*8000./(prod.*10.^6);
el_unit = 0.061;

cool_qpu = cool_flow.*10.^6.*8000./(prod.*10.^6);
cool_unit = 0.075;

ref_price_aspen = 50;

%steam_unit = steam_unit.*range_vary;
%el_unit = el_unit.*range_vary;
%cool_unit = cool_unit.*range_vary;
%ref_price_aspen = ref_price_aspen.*range_vary;

steam_pr = steam_qpu.*steam_unit./1000;
electricity_pr = el_qpu.*el_unit;
cooling_pr = cool_qpu.*cool_unit./1000;

steam_mm = prod.*steam_pr;
electricty_mm = prod.*electricity_pr;
refrigerant_mm = ref_price_aspen.*8000./10^6; % fix myself
refrigerant_pr = refrigerant_mm./prod; 
cooling_mm = prod.*cooling_pr;

total_uti_mm = steam_mm + electricty_mm + refrigerant_mm + cooling_mm; % depends what utility

gas_qpu = 0;
gas_unit = 0;
liq_qpu = 0;
liq_unit = 0;
sol_qpu = 0;
sol_unit = 0;

gas_pr = gas_qpu.*gas_unit;
liq_pr = liq_qpu.*liq_unit;
sol_pr = sol_qpu.*sol_unit;

gas_mm = gas_pr.*prod;
liq_mm = liq_pr.*prod;
sol_mm = sol_pr.*prod;

total_waste_mm = gas_mm + liq_mm + sol_mm; % might be nothing

total_vc_mm = total_ing_mm - total_cred_mm + total_uti_mm + total_waste_mm; 

% specify at the very beginning
num_op = 9;
op_perhour = 32;
other_employ_perc = 0.45; % 45%
unit_sup_perc = 1; % 100%
plant_ov_perc = 0.5; %50%
main_perc = 0.03; %3%
tax_perc = 0.02; %2%
dep_perc = 0.09; %9%

%num_op = num_op.*range_vary;
%op_perhour = op_perhour.*range_vary;

op_mm = num_op.*op_perhour.*365.*24./10^6;
other_employ_mm = other_employ_perc.*op_mm; 
unit_sup_mm = unit_sup_perc.*op_mm;
plant_ov_mm = plant_ov_perc.*op_mm;
main_mm = main_perc.*vga;
tax_mm = tax_perc.*vga;
dep_mm = dep_perc.*vga;

total_fc_mm = op_mm + other_employ_mm + unit_sup_mm + plant_ov_mm + main_mm + ...
    tax_mm + dep_mm; 

total_com_mm = total_vc_mm + total_fc_mm;

raw_inv = total_ing_mm./12;
prod_inv = total_com_mm./12;
total_inv = vga + raw_inv + prod_inv; 

tax_rate = 0.25; %25% tax rate on earnings
%tax_rate = tax_rate.*range_vary;
nroi_mm = 0.25.*total_inv./(1-tax_rate); % goal is to earn 25% NROI
nroi = nroi_mm./prod;

%specify at the beginning
bus_ov_perc = 0.06; 

ing_pr = meoh_pr + co_pr + h2_pr + cat_pr;
cred_pr = byprod_pr + waste_fuel_pr;
uti_pr = steam_pr + electricity_pr + refrigerant_pr + cooling_pr;
waste_pr = gas_pr + liq_pr + sol_pr;

vc_pr = ing_pr - cred_pr + uti_pr + waste_pr;

fc_pr = total_fc_mm./prod;
com_pr = fc_pr + vc_pr;
bus_ov_pr = bus_ov_perc.*com_pr;

total_sales_cost = com_pr + bus_ov_pr;
tp = nroi + total_sales_cost;

plot((range_vary-1).*100,tp.*1000,'linewidth',1.5)
xlabel('Variations in Parameters (%)','fontweight','bold')
ylabel('Transfer Price ($/tonnes)','fontweight','bold')
set(gca,'linewidth',1.5,'fontsize',15)
set(gcf,'position',[440 205 765 593])
ytickformat('%.0f')
hold on

%%

%% H2 Flow

range_vary = 0.8:0.001:1.2;
range_vary = range_vary';

prod = 170; % MM kg/yr meoac production

%prod = prod.*range_vary;

vga = 55; % specify vga values $MM

%vga = vga.*range_vary;


% specify at the very beginning
meoh_flow = 0.999*700;
co_flow = 0.995*452.278;
h2_flow = 0.005*452.78 + 100;
cat_cost = 154420 + 5460000 - 0.00005*170*10^6*2; % $ from VGA or sizing
h2_flow = h2_flow.*range_vary;


meoh_qpu = meoh_flow.*32.04.*8000./(prod.*10.^6);
co_qpu = co_flow.*28.01.*8000./(prod.*10.^6);
h2_qpu = h2_flow.*2.*8000./(prod.*10.^6);
cat_qpu = (cat_cost./70)./2./(prod.*10.^6);
meoh_unit = 0.62; % $/kg
co_unit = 0.205; % $/kg
h2_unit = 2;
cat_unit = 70; % $/kg

%meoh_unit = meoh_unit.*range_vary;
%co_unit = co_unit.*range_vary;
%cat_unit = cat_unit.*range_vary;

meoh_pr = meoh_qpu.*meoh_unit;
co_pr = co_qpu.*co_unit;
h2_pr = h2_qpu.*h2_unit;
cat_pr = cat_qpu.*cat_unit;

meoh_mm = prod.*meoh_pr;
co_mm = prod.*co_pr;
h2_mm = prod.*h2_pr;
cat_mm = prod.*cat_pr;

total_ing_mm = meoh_mm + co_mm + cat_mm + h2_mm; % might add another cat

byprod_qpu = 0; % might be 0
byprod_unit = 0; % might be 0
waste_fuel_unit = 3.61; 
waste_fuel_flashtank = 5080; 

byprod_pr = byprod_qpu.*byprod_unit;
waste_fuel_pr = waste_fuel_unit.*waste_fuel_flashtank./10^6;

byprod_mm = byprod_pr.*prod;
waste_fuel_mm = waste_fuel_pr.*prod;

total_cred_mm = byprod_mm + waste_fuel_mm; 

% specify at the very beginning

steam_flow = 12; % klb/hr
el_flow = 100; % kW
cool_flow = 0.300464; % MMGal/hr

%steam_flow = steam_flow.*range_vary;
%el_flow = el_flow.*range_vary;
%cool_flow = cool_flow.*range_vary;

steam_qpu = steam_flow.*1000.*8000./(prod.*10.^6);
steam_unit = 1.93;

el_qpu = el_flow.*8000./(prod.*10.^6);
el_unit = 0.061;

cool_qpu = cool_flow.*10.^6.*8000./(prod.*10.^6);
cool_unit = 0.075;

ref_price_aspen = 50;

%steam_unit = steam_unit.*range_vary;
%el_unit = el_unit.*range_vary;
%cool_unit = cool_unit.*range_vary;
%ref_price_aspen = ref_price_aspen.*range_vary;

steam_pr = steam_qpu.*steam_unit./1000;
electricity_pr = el_qpu.*el_unit;
cooling_pr = cool_qpu.*cool_unit./1000;

steam_mm = prod.*steam_pr;
electricty_mm = prod.*electricity_pr;
refrigerant_mm = ref_price_aspen.*8000./10^6; % fix myself
refrigerant_pr = refrigerant_mm./prod; 
cooling_mm = prod.*cooling_pr;

total_uti_mm = steam_mm + electricty_mm + refrigerant_mm + cooling_mm; % depends what utility

gas_qpu = 0;
gas_unit = 0;
liq_qpu = 0;
liq_unit = 0;
sol_qpu = 0;
sol_unit = 0;

gas_pr = gas_qpu.*gas_unit;
liq_pr = liq_qpu.*liq_unit;
sol_pr = sol_qpu.*sol_unit;

gas_mm = gas_pr.*prod;
liq_mm = liq_pr.*prod;
sol_mm = sol_pr.*prod;

total_waste_mm = gas_mm + liq_mm + sol_mm; % might be nothing

total_vc_mm = total_ing_mm - total_cred_mm + total_uti_mm + total_waste_mm; 

% specify at the very beginning
num_op = 9;
op_perhour = 32;
other_employ_perc = 0.45; % 45%
unit_sup_perc = 1; % 100%
plant_ov_perc = 0.5; %50%
main_perc = 0.03; %3%
tax_perc = 0.02; %2%
dep_perc = 0.09; %9%

%num_op = num_op.*range_vary;
%op_perhour = op_perhour.*range_vary;

op_mm = num_op.*op_perhour.*365.*24./10^6;
other_employ_mm = other_employ_perc.*op_mm; 
unit_sup_mm = unit_sup_perc.*op_mm;
plant_ov_mm = plant_ov_perc.*op_mm;
main_mm = main_perc.*vga;
tax_mm = tax_perc.*vga;
dep_mm = dep_perc.*vga;

total_fc_mm = op_mm + other_employ_mm + unit_sup_mm + plant_ov_mm + main_mm + ...
    tax_mm + dep_mm; 

total_com_mm = total_vc_mm + total_fc_mm;

raw_inv = total_ing_mm./12;
prod_inv = total_com_mm./12;
total_inv = vga + raw_inv + prod_inv; 

tax_rate = 0.25; %25% tax rate on earnings
%tax_rate = tax_rate.*range_vary;
nroi_mm = 0.25.*total_inv./(1-tax_rate); % goal is to earn 25% NROI
nroi = nroi_mm./prod;

%specify at the beginning
bus_ov_perc = 0.06; 

ing_pr = meoh_pr + co_pr + h2_pr + cat_pr;
cred_pr = byprod_pr + waste_fuel_pr;
uti_pr = steam_pr + electricity_pr + refrigerant_pr + cooling_pr;
waste_pr = gas_pr + liq_pr + sol_pr;

vc_pr = ing_pr - cred_pr + uti_pr + waste_pr;

fc_pr = total_fc_mm./prod;
com_pr = fc_pr + vc_pr;
bus_ov_pr = bus_ov_perc.*com_pr;

total_sales_cost = com_pr + bus_ov_pr;
tp = nroi + total_sales_cost;

plot((range_vary-1).*100,tp.*1000,'linewidth',1.5)
xlabel('Variations in Parameters (%)','fontweight','bold')
ylabel('Transfer Price ($/tonnes)','fontweight','bold')
set(gca,'linewidth',1.5,'fontsize',15)
set(gcf,'position',[440 205 765 593])
ytickformat('%.0f')
hold on

%%

%% Steam Flow
clear; 

range_vary = 0.8:0.001:1.2;
range_vary = range_vary';

prod = 170; % MM kg/yr meoac production

%prod = prod.*range_vary;

vga = 55; % specify vga values $MM

%vga = vga.*range_vary;


% specify at the very beginning
meoh_flow = 0.999*700;
co_flow = 0.995*452.278;
h2_flow = 0.005*452.78 + 100;
cat_cost = 154420 + 5460000 - 0.00005*170*10^6*2; % $ from VGA or sizing

meoh_qpu = meoh_flow.*32.04.*8000./(prod.*10.^6);
co_qpu = co_flow.*28.01.*8000./(prod.*10.^6);
h2_qpu = h2_flow.*2.*8000./(prod.*10.^6);
cat_qpu = (cat_cost./70)./2./(prod.*10.^6);
meoh_unit = 0.62; % $/kg
co_unit = 0.205; % $/kg
h2_unit = 2;
cat_unit = 70; % $/kg

%meoh_unit = meoh_unit.*range_vary;
%co_unit = co_unit.*range_vary;
%cat_unit = cat_unit.*range_vary;

meoh_pr = meoh_qpu.*meoh_unit;
co_pr = co_qpu.*co_unit;
h2_pr = h2_qpu.*h2_unit;
cat_pr = cat_qpu.*cat_unit;

meoh_mm = prod.*meoh_pr;
co_mm = prod.*co_pr;
h2_mm = prod.*h2_pr;
cat_mm = prod.*cat_pr;

total_ing_mm = meoh_mm + co_mm + cat_mm + h2_mm; % might add another cat

byprod_qpu = 0; % might be 0
byprod_unit = 0; % might be 0
waste_fuel_unit = 3.61; 
waste_fuel_flashtank = 5080; 

byprod_pr = byprod_qpu.*byprod_unit;
waste_fuel_pr = waste_fuel_unit.*waste_fuel_flashtank./10^6;

byprod_mm = byprod_pr.*prod;
waste_fuel_mm = waste_fuel_pr.*prod;

total_cred_mm = byprod_mm + waste_fuel_mm; 

% specify at the very beginning

steam_flow = 12; % klb/hr
el_flow = 100; % kW
cool_flow = 0.300464; % MMGal/hr

steam_flow = steam_flow.*range_vary;
%el_flow = el_flow.*range_vary;
%cool_flow = cool_flow.*range_vary;

steam_qpu = steam_flow.*1000.*8000./(prod.*10.^6);
steam_unit = 1.93;

el_qpu = el_flow.*8000./(prod.*10.^6);
el_unit = 0.061;

cool_qpu = cool_flow.*10.^6.*8000./(prod.*10.^6);
cool_unit = 0.075;

ref_price_aspen = 50;

%steam_unit = steam_unit.*range_vary;
%el_unit = el_unit.*range_vary;
%cool_unit = cool_unit.*range_vary;
%ref_price_aspen = ref_price_aspen.*range_vary;

steam_pr = steam_qpu.*steam_unit./1000;
electricity_pr = el_qpu.*el_unit;
cooling_pr = cool_qpu.*cool_unit./1000;

steam_mm = prod.*steam_pr;
electricty_mm = prod.*electricity_pr;
refrigerant_mm = ref_price_aspen.*8000./10^6; % fix myself
refrigerant_pr = refrigerant_mm./prod; 
cooling_mm = prod.*cooling_pr;

total_uti_mm = steam_mm + electricty_mm + refrigerant_mm + cooling_mm; % depends what utility

gas_qpu = 0;
gas_unit = 0;
liq_qpu = 0;
liq_unit = 0;
sol_qpu = 0;
sol_unit = 0;

gas_pr = gas_qpu.*gas_unit;
liq_pr = liq_qpu.*liq_unit;
sol_pr = sol_qpu.*sol_unit;

gas_mm = gas_pr.*prod;
liq_mm = liq_pr.*prod;
sol_mm = sol_pr.*prod;

total_waste_mm = gas_mm + liq_mm + sol_mm; % might be nothing

total_vc_mm = total_ing_mm - total_cred_mm + total_uti_mm + total_waste_mm; 

% specify at the very beginning
num_op = 9;
op_perhour = 32;
other_employ_perc = 0.45; % 45%
unit_sup_perc = 1; % 100%
plant_ov_perc = 0.5; %50%
main_perc = 0.03; %3%
tax_perc = 0.02; %2%
dep_perc = 0.09; %9%

%num_op = num_op.*range_vary;
%op_perhour = op_perhour.*range_vary;

op_mm = num_op.*op_perhour.*365.*24./10^6;
other_employ_mm = other_employ_perc.*op_mm; 
unit_sup_mm = unit_sup_perc.*op_mm;
plant_ov_mm = plant_ov_perc.*op_mm;
main_mm = main_perc.*vga;
tax_mm = tax_perc.*vga;
dep_mm = dep_perc.*vga;

total_fc_mm = op_mm + other_employ_mm + unit_sup_mm + plant_ov_mm + main_mm + ...
    tax_mm + dep_mm; 

total_com_mm = total_vc_mm + total_fc_mm;

raw_inv = total_ing_mm./12;
prod_inv = total_com_mm./12;
total_inv = vga + raw_inv + prod_inv; 

tax_rate = 0.25; %25% tax rate on earnings
%tax_rate = tax_rate.*range_vary;
nroi_mm = 0.25.*total_inv./(1-tax_rate); % goal is to earn 25% NROI
nroi = nroi_mm./prod;

%specify at the beginning
bus_ov_perc = 0.06; 

ing_pr = meoh_pr + co_pr + h2_pr + cat_pr;
cred_pr = byprod_pr + waste_fuel_pr;
uti_pr = steam_pr + electricity_pr + refrigerant_pr + cooling_pr;
waste_pr = gas_pr + liq_pr + sol_pr;

vc_pr = ing_pr - cred_pr + uti_pr + waste_pr;

fc_pr = total_fc_mm./prod;
com_pr = fc_pr + vc_pr;
bus_ov_pr = bus_ov_perc.*com_pr;

total_sales_cost = com_pr + bus_ov_pr;
tp = nroi + total_sales_cost;

plot((range_vary-1).*100,tp.*1000,'linewidth',1.5)
xlabel('Variations in Parameters (%)','fontweight','bold')
ylabel('Transfer Price ($/tonnes)','fontweight','bold')
set(gca,'linewidth',1.5,'fontsize',15)
set(gcf,'position',[440 205 765 593])
ytickformat('%.0f')
hold on

%%

%% Electricity Flow
clear; 

range_vary = 0.8:0.001:1.2;
range_vary = range_vary';

prod = 170; % MM kg/yr meoac production

%prod = prod.*range_vary;

vga = 55; % specify vga values $MM

%vga = vga.*range_vary;


% specify at the very beginning
meoh_flow = 0.999*700;
co_flow = 0.995*452.278;electri
h2_flow = 0.005*452.78 + 100;
cat_cost = 154420 + 5460000 - 0.00005*170*10^6*2; % $ from VGA or sizing

meoh_qpu = meoh_flow.*32.04.*8000./(prod.*10.^6);
co_qpu = co_flow.*28.01.*8000./(prod.*10.^6);
h2_qpu = h2_flow.*2.*8000./(prod.*10.^6);
cat_qpu = (cat_cost./70)./2./(prod.*10.^6);
meoh_unit = 0.62; % $/kg
co_unit = 0.205; % $/kg
h2_unit = 2;
cat_unit = 70; % $/kg

%meoh_unit = meoh_unit.*range_vary;
%co_unit = co_unit.*range_vary;
%cat_unit = cat_unit.*range_vary;

meoh_pr = meoh_qpu.*meoh_unit;
co_pr = co_qpu.*co_unit;
h2_pr = h2_qpu.*h2_unit;
cat_pr = cat_qpu.*cat_unit;

meoh_mm = prod.*meoh_pr;
co_mm = prod.*co_pr;
h2_mm = prod.*h2_pr;
cat_mm = prod.*cat_pr;

total_ing_mm = meoh_mm + co_mm + cat_mm + h2_mm; % might add another cat

byprod_qpu = 0; % might be 0
byprod_unit = 0; % might be 0
waste_fuel_unit = 3.61; 
waste_fuel_flashtank = 5080; 

byprod_pr = byprod_qpu.*byprod_unit;
waste_fuel_pr = waste_fuel_unit.*waste_fuel_flashtank./10^6;

byprod_mm = byprod_pr.*prod;
waste_fuel_mm = waste_fuel_pr.*prod;

total_cred_mm = byprod_mm + waste_fuel_mm; 

% specify at the very beginning

steam_flow = 12; % klb/hr
el_flow = 100; % kW
cool_flow = 0.300464; % MMGal/hr

%steam_flow = steam_flow.*range_vary;
el_flow = el_flow.*range_vary;
%cool_flow = cool_flow.*range_vary;

steam_qpu = steam_flow.*1000.*8000./(prod.*10.^6);
steam_unit = 1.93;

el_qpu = el_flow.*8000./(prod.*10.^6);
el_unit = 0.061;

cool_qpu = cool_flow.*10.^6.*8000./(prod.*10.^6);
cool_unit = 0.075;

ref_price_aspen = 50;

%steam_unit = steam_unit.*range_vary;
%el_unit = el_unit.*range_vary;
%cool_unit = cool_unit.*range_vary;
%ref_price_aspen = ref_price_aspen.*range_vary;

steam_pr = steam_qpu.*steam_unit./1000;
electricity_pr = el_qpu.*el_unit;
cooling_pr = cool_qpu.*cool_unit./1000;

steam_mm = prod.*steam_pr;
electricty_mm = prod.*electricity_pr;
refrigerant_mm = ref_price_aspen.*8000./10^6; % fix myself
refrigerant_pr = refrigerant_mm./prod; 
cooling_mm = prod.*cooling_pr;

total_uti_mm = steam_mm + electricty_mm + refrigerant_mm + cooling_mm; % depends what utility

gas_qpu = 0;
gas_unit = 0;
liq_qpu = 0;
liq_unit = 0;
sol_qpu = 0;
sol_unit = 0;

gas_pr = gas_qpu.*gas_unit;
liq_pr = liq_qpu.*liq_unit;
sol_pr = sol_qpu.*sol_unit;

gas_mm = gas_pr.*prod;
liq_mm = liq_pr.*prod;
sol_mm = sol_pr.*prod;

total_waste_mm = gas_mm + liq_mm + sol_mm; % might be nothing

total_vc_mm = total_ing_mm - total_cred_mm + total_uti_mm + total_waste_mm; 

% specify at the very beginning
num_op = 9;
op_perhour = 32;
other_employ_perc = 0.45; % 45%
unit_sup_perc = 1; % 100%
plant_ov_perc = 0.5; %50%
main_perc = 0.03; %3%
tax_perc = 0.02; %2%
dep_perc = 0.09; %9%

%num_op = num_op.*range_vary;
%op_perhour = op_perhour.*range_vary;

op_mm = num_op.*op_perhour.*365.*24./10^6;
other_employ_mm = other_employ_perc.*op_mm; 
unit_sup_mm = unit_sup_perc.*op_mm;
plant_ov_mm = plant_ov_perc.*op_mm;
main_mm = main_perc.*vga;
tax_mm = tax_perc.*vga;
dep_mm = dep_perc.*vga;

total_fc_mm = op_mm + other_employ_mm + unit_sup_mm + plant_ov_mm + main_mm + ...
    tax_mm + dep_mm; 

total_com_mm = total_vc_mm + total_fc_mm;

raw_inv = total_ing_mm./12;
prod_inv = total_com_mm./12;
total_inv = vga + raw_inv + prod_inv; 

tax_rate = 0.25; %25% tax rate on earnings
%tax_rate = tax_rate.*range_vary;
nroi_mm = 0.25.*total_inv./(1-tax_rate); % goal is to earn 25% NROI
nroi = nroi_mm./prod;

%specify at the beginning
bus_ov_perc = 0.06; 

ing_pr = meoh_pr + co_pr + h2_pr + cat_pr;
cred_pr = byprod_pr + waste_fuel_pr;
uti_pr = steam_pr + electricity_pr + refrigerant_pr + cooling_pr;
waste_pr = gas_pr + liq_pr + sol_pr;

vc_pr = ing_pr - cred_pr + uti_pr + waste_pr;

fc_pr = total_fc_mm./prod;
com_pr = fc_pr + vc_pr;
bus_ov_pr = bus_ov_perc.*com_pr;

total_sales_cost = com_pr + bus_ov_pr;
tp = nroi + total_sales_cost;

plot((range_vary-1).*100,tp.*1000,'linewidth',1.5)
xlabel('Variations in Parameters (%)','fontweight','bold')
ylabel('Transfer Price ($/tonnes)','fontweight','bold')
set(gca,'linewidth',1.5,'fontsize',15)
set(gcf,'position',[440 205 765 593])
ytickformat('%.0f')
hold on

%%

%% Cooling Flow
clear; 

range_vary = 0.8:0.001:1.2;
range_vary = range_vary';

prod = 170; % MM kg/yr meoac production

%prod = prod.*range_vary;

vga = 55; % specify vga values $MM

%vga = vga.*range_vary;


% specify at the very beginning
meoh_flow = 0.999*700;
co_flow = 0.995*452.278;
h2_flow = 0.005*452.78 + 100;
cat_cost = 154420 + 5460000 - 0.00005*170*10^6*2; % $ from VGA or sizing

meoh_qpu = meoh_flow.*32.04.*8000./(prod.*10.^6);
co_qpu = co_flow.*28.01.*8000./(prod.*10.^6);
h2_qpu = h2_flow.*2.*8000./(prod.*10.^6);
cat_qpu = (cat_cost./70)./2./(prod.*10.^6);
meoh_unit = 0.62; % $/kg
co_unit = 0.205; % $/kg
h2_unit = 2;
cat_unit = 70; % $/kg

%meoh_unit = meoh_unit.*range_vary;
%co_unit = co_unit.*range_vary;
%cat_unit = cat_unit.*range_vary;

meoh_pr = meoh_qpu.*meoh_unit;
co_pr = co_qpu.*co_unit;
h2_pr = h2_qpu.*h2_unit;
cat_pr = cat_qpu.*cat_unit;

meoh_mm = prod.*meoh_pr;
co_mm = prod.*co_pr;
h2_mm = prod.*h2_pr;
cat_mm = prod.*cat_pr;

total_ing_mm = meoh_mm + co_mm + cat_mm + h2_mm; % might add another cat

byprod_qpu = 0; % might be 0
byprod_unit = 0; % might be 0
waste_fuel_unit = 3.61; 
waste_fuel_flashtank = 5080; 

byprod_pr = byprod_qpu.*byprod_unit;
waste_fuel_pr = waste_fuel_unit.*waste_fuel_flashtank./10^6;

byprod_mm = byprod_pr.*prod;
waste_fuel_mm = waste_fuel_pr.*prod;

total_cred_mm = byprod_mm + waste_fuel_mm; 

% specify at the very beginning

steam_flow = 12; % klb/hr
el_flow = 100; % kW
cool_flow = 0.300464; % MMGal/hr

%steam_flow = steam_flow.*range_vary;
%el_flow = el_flow.*range_vary;
cool_flow = cool_flow.*range_vary;

steam_qpu = steam_flow.*1000.*8000./(prod.*10.^6);
steam_unit = 1.93;

el_qpu = el_flow.*8000./(prod.*10.^6);
el_unit = 0.061;

cool_qpu = cool_flow.*10.^6.*8000./(prod.*10.^6);
cool_unit = 0.075;

ref_price_aspen = 50;

%steam_unit = steam_unit.*range_vary;
%el_unit = el_unit.*range_vary;
%cool_unit = cool_unit.*range_vary;
%ref_price_aspen = ref_price_aspen.*range_vary;

steam_pr = steam_qpu.*steam_unit./1000;
electricity_pr = el_qpu.*el_unit;
cooling_pr = cool_qpu.*cool_unit./1000;

steam_mm = prod.*steam_pr;
electricty_mm = prod.*electricity_pr;
refrigerant_mm = ref_price_aspen.*8000./10^6; % fix myself
refrigerant_pr = refrigerant_mm./prod; 
cooling_mm = prod.*cooling_pr;

total_uti_mm = steam_mm + electricty_mm + refrigerant_mm + cooling_mm; % depends what utility

gas_qpu = 0;
gas_unit = 0;
liq_qpu = 0;
liq_unit = 0;
sol_qpu = 0;
sol_unit = 0;

gas_pr = gas_qpu.*gas_unit;
liq_pr = liq_qpu.*liq_unit;
sol_pr = sol_qpu.*sol_unit;

gas_mm = gas_pr.*prod;
liq_mm = liq_pr.*prod;
sol_mm = sol_pr.*prod;

total_waste_mm = gas_mm + liq_mm + sol_mm; % might be nothing

total_vc_mm = total_ing_mm - total_cred_mm + total_uti_mm + total_waste_mm; 

% specify at the very beginning
num_op = 9;
op_perhour = 32;
other_employ_perc = 0.45; % 45%
unit_sup_perc = 1; % 100%
plant_ov_perc = 0.5; %50%
main_perc = 0.03; %3%
tax_perc = 0.02; %2%
dep_perc = 0.09; %9%

%num_op = num_op.*range_vary;
%op_perhour = op_perhour.*range_vary;

op_mm = num_op.*op_perhour.*365.*24./10^6;
other_employ_mm = other_employ_perc.*op_mm; 
unit_sup_mm = unit_sup_perc.*op_mm;
plant_ov_mm = plant_ov_perc.*op_mm;
main_mm = main_perc.*vga;
tax_mm = tax_perc.*vga;
dep_mm = dep_perc.*vga;

total_fc_mm = op_mm + other_employ_mm + unit_sup_mm + plant_ov_mm + main_mm + ...
    tax_mm + dep_mm; 

total_com_mm = total_vc_mm + total_fc_mm;

raw_inv = total_ing_mm./12;
prod_inv = total_com_mm./12;
total_inv = vga + raw_inv + prod_inv; 

tax_rate = 0.25; %25% tax rate on earnings
%tax_rate = tax_rate.*range_vary;
nroi_mm = 0.25.*total_inv./(1-tax_rate); % goal is to earn 25% NROI
nroi = nroi_mm./prod;

%specify at the beginning
bus_ov_perc = 0.06; 

ing_pr = meoh_pr + co_pr + h2_pr + cat_pr;
cred_pr = byprod_pr + waste_fuel_pr;
uti_pr = steam_pr + electricity_pr + refrigerant_pr + cooling_pr;
waste_pr = gas_pr + liq_pr + sol_pr;

vc_pr = ing_pr - cred_pr + uti_pr + waste_pr;

fc_pr = total_fc_mm./prod;
com_pr = fc_pr + vc_pr;
bus_ov_pr = bus_ov_perc.*com_pr;

total_sales_cost = com_pr + bus_ov_pr;
tp = nroi + total_sales_cost;

plot((range_vary-1).*100,tp.*1000,'linewidth',1.5)
xlabel('Variations in Parameters (%)','fontweight','bold')
ylabel('Transfer Price ($/tonnes)','fontweight','bold')
set(gca,'linewidth',1.5,'fontsize',15)
set(gcf,'position',[440 205 765 593])
ytickformat('%.0f')
hold on

legend('MeOH Yield','CO Yield','Steam Usage','Electricity Usage','Cooling Water Usage',...
    'location','southeast')

print -djpeg sense3