function F = optimizer(temp,antoine1,antoine2,x1,x2,gamma1,gamma2,phi,totalP)
% function F = optimizer(temp,antoine1,antoine2,x1,x2,gamma1,gamma2,totalP)
% function F = optimizer(temp,antoine1,antoine2,x1,x2,gamma1,gamma2,phi1,phi2,totalP)

% function F = optimizer(temp,antoine1,antoine2,x1,x2,gamma1,gamma2,totalP)
%
% To solve for temperature-mol fraction relationship to plot T-x curve
%
% Inputs:
% temp_range - guess temperature (K)
% antoine1 - antoine parameters for component 1
% antoine2 - antoine parameters for component 2
% x1 - mole fraction of component 1
% x2 - mole fraction of component 2
% gamma1 - activity coefficient of component 1
% gamma2 - activity coefficient of component 2
% phi - parameters for fugacity correction quadratic equation
% (phi ratio = vap. phi/sat. phi) 
% least)
% totalP - total pressure (bar)
%
% Output:
% F - equations should be 0

pvap1 = 10.^(antoine1(1) - antoine1(2)./(temp + antoine1(3)));
pvap2 = 10.^(antoine2(1) - antoine2(2)./(temp + antoine2(3)));
act_phi1 = polyval(phi,temp);
% act_phi2 = polyval(phi2,temp);

p1 = pvap1.*x1.*gamma1./act_phi1;
p2 = pvap2.*x2.*gamma2./act_phi1;
F = p1 + p2 - totalP;