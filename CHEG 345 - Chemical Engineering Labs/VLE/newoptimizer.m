gagfunction F = newoptimizer(temp,antoine1,antoine2,antoine3,x1,x2,x3,...
    gamma1,gamma2,gamma3,phicoeff1,phicoeff2,phicoeff3,totalP)
%function F = optimizer(temp,antoine1,antoine2,x1,x2,gamma1,gamma2,totalP)

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
pvap3 = 10.^(antoine3(1) - antoine3(2)./(temp + antoine3(3)));
act_phi1 = polyval(phicoeff1,temp);
act_phi2 = polyval(phicoeff2,temp);
act_phi3 = polyval(phicoeff3,temp);

p1 = pvap1.*x1.*gamma1./act_phi1;
p2 = pvap2.*x2.*gamma2./act_phi2;
p3 = pvap3.*x3.*gamma3./act_phi3;

F = p1 + p2 + p3 - totalP;