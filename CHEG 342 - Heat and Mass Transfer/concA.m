function F = concA(x,qi,qii,caf0_ii,ca1_i,caf_i,ca2_ii)
% x(1) = ca2_i, x(2) = ca1_ii
%
% 
%
% Inputs:
%
%
% Output:
% F - equations should be 0

F(1) = caf0_ii.*qii + x(1).*qi - x(2).*qii - ca1_i.*qi;
F(2) = x(2).*qii + caf_i.*qi - ca2_ii.*qii - x(1).*qi;

end