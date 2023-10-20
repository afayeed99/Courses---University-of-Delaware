function main
% clear all
global U %initiator flow rate

Tmax=3;
dt=0.01; %time increment
N=round(Tmax/dt);

t=[0:dt/10:dt]; %time interval for ODE calculation at every increment

%Steady state values
us=0.016783; %steady state initiator flow rate
Ys=25000.5;  %steady state NAMW

%delay
alpha=0.1;
delay=round(alpha/dt);
% For step response introduce step change here
% Step change
U=input('[Step Input Change] Input new value of the initiator volumetric flow rate: ')
% To implement your controller, remove this line and replace with your controller 
% algorithm and insert inside the loop
for k=1:N
    if k==1
        T(k)=0;
    else
        T(k)=T(k-1)+dt;
    end
    
    u_vector(k)=U;
    
  %NOTE. When implementing a feedback controller, the computed control action
  % is in terms of deviation variables; what is actually implemented on the process
  % is the absolute initiator flow rate.
  
    if k==1
        X0=[5.506774 0.132906 0.0019752 49.38182];
    end
    
    [T1 X]=ode45(@odemodel,[0:dt/10:dt],X0);
    
    X0=[X(11,1) X(11,2) X(11,3) X(11,4)];
    
    z(k)=X(11,4)/X(11,3);
    
    if k<= delay
        Yout(k)=Ys;
    else
        Yout(k)=z(k-delay);
    end
    Yno(k)=Yout(k).*(1+0.02*(-1+2*rand)); %noisy output
    
    % to implement control action, compute feedback error here 
    % and use to determine control action
end

% plot measured reactor output

subplot(211);
plot(T,Yno);grid on
xlabel('Time, hr');
ylabel('NAMW');
subplot(212);
hold on
plot(T,u_vector);
plot([0 0],[us U]);
xlabel('Time, hr');
ylabel('Initiator flow rate, m^3/hr');
axis([0 Tmax 0 0.032]);

%output file
% output = [T' Yno'];
save reactor_output_yourname.txt -ascii
save('OutputTY2.xls','T','Yno')
end 
% %Reactor model
% function f=odemodel(t,X)
% global U
% f(1)=10*(6-X(1))-2.4568*X(1)*sqrt(X(2));
% f(2)=80*U-10.1022*X(2);
% f(3)=0.0024121*X(1)*sqrt(X(2))+0.112191*X(2)-10*X(3);
% f(4)=245.978*X(1)*sqrt(X(2))-10*X(4);
% f=f';
% end 

