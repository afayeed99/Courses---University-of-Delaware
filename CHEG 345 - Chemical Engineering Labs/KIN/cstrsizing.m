function F = cstrsizing(var,init_conc,ac,q,rate_const,rate_order)

% var(1,2,3,4) = hcl_conc,i2_conc,ineg_conc,V
[k1,k2] = deal(rate_const(1),rate_const(1));
[alpha,beta,gamma] = deal(rate_order(1),rate_order(2),rate_order(3));
[ac0,hcl0,i20,ineg0] = deal(init_conc(1),init_conc(2),init_conc(3),init_conc(4));


F(1) = q.*(ac0 - ac) - k1.*(ac.^alpha).*(var(1).^beta).*(var(2).^gamma).*var(4);
F(2) = q.*(hcl0 - var(1)) + k1.*(ac.^alpha).*(var(1).^beta).*(var(2).^gamma).*var(4) - 2.*k2.*var(3);
F(3) = q.*(i20 - var(2)) - k1.*(ac.^alpha).*(var(1).^beta).*(var(2).^gamma).*var(4) + k2.*var(3);
F(4) = q.*(ineg0 - var(3)) + k1.*(ac.^alpha).*(var(1).^beta).*(var(2).^gamma).*var(4) - 2.*k2.*var(3);

end