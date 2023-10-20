function f=odemodel(t,X)
global  U  %Initiator vol. flow rate

f(1)=10*(6-X(1))-2.4568*X(1)*sqrt(X(2));
f(2)=80*U-10.1022*X(2);
f(3)=0.0024121*X(1)*sqrt(X(2))+0.112191*X(2)-10*X(3);
f(4)=245.978*X(1)*sqrt(X(2))-10*X(4);

f=f';
