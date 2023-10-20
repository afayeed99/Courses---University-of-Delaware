W=5000; %Weight of catalyst in grams
T=linspace(273.15,673.15,1000); %going from 200 to 600
P=30/1.01325; %bar to atm
k=(3*10^4).*exp(-8370./T);
x_out_1=zeros(1000,1); %output for 1 atm
F0=1000; %flow rate kmol/hr
syms x 
for i=1:1000;
    eqn1=((W*k(1,i)*P)/F0)==log(1/(1-x))+x;
    soln=vpasolve([eqn1],[x]);
    if size(soln,1)==0;
        x_out_1(i,1)=NaN;
    else;
        x_out_1(i,1)=soln;
    end;
end;

