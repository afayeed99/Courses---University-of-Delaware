%% PROBLEM 3
syms V T
R = 8.314;
Ttriple = 180.97;
Tcrit = 437.22;
Pcrit = 5.34e+6;
antA = 4.29371;
antB = 995.445;
antC = -47.869;
Pant = @(T) (10^5)*10^(antA - (antB/(T + antC)));
Ptriple = Pant(Ttriple)

syms T V
omega = -1 - log10(Pant(0.7*Tcrit)/Pcrit);
k_small = 0.37464 + 1.5422*omega - 0.26992*omega^2;
alpha_T = @(T) (1 + k_small*(1 - sqrt(T./Tcrit)))^2;
a_T = @(T) (0.45724*(R^2)*(Tcrit^2)/Pcrit) * alpha_T(T);

Trange_a = linspace(0,Tcrit,100);
a_array = [];
for i = 1:length(Trange_a)
    val = a_T(Trange_a(i));
    a_array(i) = val;
end

plot(Trange_a,a_array)
xlabel('Temperature (K)')
ylabel('a(T) (Pa m^6 mol^-2)')
title('Graph of a(T) versus Temperature')

b = 0.0778*R*Tcrit/Pcrit
Prb = @(T,V) R*T./(V - b) - a_T(T)/(V.*(V + b) + b*(V - b));
Vcrit = vpasolve(Prb(Tcrit,V) == Pcrit,V,[0 Inf]);
acentric = omega
Zc = Pcrit*Vcrit/(R*Tcrit)

% FOR REPORT PURPOSES

% CLAUSIUS CLAPEYRON EQUATION
C = log(Pcrit) + (33.78e+3)/(R*Tcrit)
P_unknown = exp(C - (26.4e+3)/(R*(6.88+273.15)))
P_norm = exp(C - (25.05e+3)/(R*(298)))/10^5

Vtriple = vpasolve(Prb(Ttriple,V) == Ptriple,V,[0 Inf])
Vcrit = vpasolve(Prb(Tcrit,V) == Pcrit,V,[0 Inf])
Vnormal = vpasolve(Prb(180.15,V) == 1*10^5,V,[0 Inf])

%% PROBLEM 4, 5, 7


syms T V 

R = 8.314;
Ttriple = 314.06;
Tcrit = 693.65;
Pcrit = 6.03008e+6;
antA = 4.29371;
antB = 995.445;
antC = -47.869;
Pant = @(T) (10^5)*10^(antA - (antB/(T + antC)));
b = 0.0778*R*Tcrit/Pcrit;

%omega = -1 - log10(Pant(0.7*Tcrit)/Pcrit);
omega = 0.438;
k_small = 0.37464 + 1.5422*omega - 0.26992*omega^2;
alpha_T = @(T) (1 + k_small*(1 - sqrt(T./Tcrit)))^2;
a_T = @(T) (0.45724*(R^2)*(Tcrit^2)/Pcrit) * alpha_T(T);
Prb = @(T,V) R*T./(V - b) - a_T(T)/(V.*(V + b) + b*(V - b));

Trange = linspace(Ttriple,2*Tcrit,100);
Prange = Pcrit*[0.000000001,0.5,1];

% NO 4 - Cp - Cv vs. T graph
alpha = zeros(1,length(Trange));

% doing approximation method in dvdt instead of actual diff dvdt
for i = 1:length(Trange)
    
    t_up = Trange(i) + 0.1;
    t_down = Trange(i) - 0.1;
    v1 = max(vpasolve(Prb(t_up,V) == Pcrit, V, [0 Inf]));   
    v2 = max(vpasolve(Prb(t_down,V) == Pcrit, V, [0 Inf]));

    dvdt = (v1 - v2)/(t_up - t_down);
    Vreal = max(vpasolve(Prb(Trange(i),V) == Pcrit, V, [0 Inf]));

    alpha(i) = dvdt/Vreal;
end

Varray = zeros(1,length(Trange));
kappa = zeros(1,length(Trange));

dvdp = matlabFunction(1/diff(Prb,V));

for i = 1:length(Trange)
    Vreal = max(vpasolve(Prb(Trange(i),V) == Pcrit, V, [0 Inf]));
    Varray(i) = Vreal;
    kappa(i) = (-1/Vreal)*dvdp(Trange(i),Vreal);
end

cp_cv_array = zeros(1,length(Trange));

for i = 1:length(Trange)
   cp_cv_array(i) = Trange(i)*Varray(i)*alpha(i)^2/kappa(i);
end

plot(Trange,cp_cv_array)
xlabel('Temperature (K)')
ylabel('Cp - Cv (J/mol.K)')
title('Graph of Cp - Cv versus temperature')


% NO 7 - thermal expansion vs. T graph
% setting up three sets of alpha w.r.t 3 diff pressure
Trange = linspace(Ttriple,2*Tcrit,100);
for j = 1:length(Prange)
    alpha = zeros(1,length(Trange));
    for i = 1:length(Trange)
        t_up = Trange(i) + 0.1;
        t_down = Trange(i) - 0.1;
        v1 = max(vpasolve(Prb(t_up,V) == Prange(j), V, [0 Inf]));   
        v2 = max(vpasolve(Prb(t_down,V) == Prange(j), V, [0 Inf]));

        dvdt = (v1 - v2)/(t_up - t_down);
        Vreal = max(vpasolve(Prb(Trange(i),V) == Prange(j), V, [0 Inf]));
 
        alpha(i) = dvdt/Vreal;
    end
    plot(Trange./Tcrit,alpha)
    hold on
    if j == 1
        alpha_P1 = alpha;
    elseif j == 2
        alpha_P2 = alpha;
    elseif j == 3
        alpha_P3 = alpha;
    end
end

xlabel('Temperature (K)')
ylabel('Coefficient of thermal expansion, a (1/K)')
%title('Graph of thermal expansion coefficient versus temperature')
legend('Pr = 0.0','Pr = 0.5','Pr = 1.0')
hold off


% setting up three sets of kappa and volume w.r.t 3 diff pressure
for j = 1:length(Prange)
    kappa = zeros(1,length(Trange));
    Varray = zeros(1,length(Trange));
    for i = 1:length(Trange)
        Vreal = max(vpasolve(Prb(Trange(i),V) == Prange(j), V, [0 Inf]));
        Varray(i) = Vreal;
        kappa(i) = (-1/Vreal)*dvdp(Trange(i),Vreal);
    end
    if j == 1
        kappa_P1 = kappa;
        Vol1 = Varray;
    elseif j == 2
        kappa_P2 = kappa;
        Vol2 = Varray;
    elseif j == 3
        kappa_P3 = kappa;
        Vol3 = Varray;
    end
end

for j = 1:length(Prange)
    cp_cv_array = zeros(1,length(Trange));
    for i = 1:length(Trange)
        if j == 1
            cp_cv_array(i) = Trange(i)*Vol1(i)*alpha_P1(i)^2/kappa_P1(i);
        elseif j == 2
            cp_cv_array(i) = Trange(i)*Vol2(i)*alpha_P2(i)^2/kappa_P2(i);
        elseif j == 3
            cp_cv_array(i) = Trange(i)*Vol3(i)*alpha_P3(i)^2/kappa_P3(i);
        end
    if j == 1
        cp_cv1 = cp_cv_array;
    elseif j == 2
        cp_cv2 = cp_cv_array;
    elseif j == 3
        cp_cv3 = cp_cv_array;
    end
    end
end

% NO 5 - Cp vs. T graph
Trange = linspace(Ttriple,2*Tcrit,100);
a_cp = -59.69;
b_cp = 0.709;
c_cp = -6.572e-4;
d_cp = 2.437e-7;
cp_star = @(T) a_cp + b_cp*T + c_cp*T.^2 + d_cp*T.^3;
cv_star = @(T) cp_star(T) - R;

dpdt = diff(Prb,T);

dpdt_secdiff = matlabFunction(diff(dpdt,T));

for j = 1:length(Prange)
    cv = zeros(1,length(Trange));
    for i = 1:length(Trange)
        if j == 1
            intgrl = @(T)- int(dpdt_secdiff(T,V),V,Vol1(i),Inf);
            cv(i) = cv_star(Trange(i)) + Trange(i)*intgrl(Trange(i));
        elseif j == 2
            intgrl = @(T)- int(dpdt_secdiff(T,V),V,Vol2(i),Inf);
            cv(i) = cv_star(Trange(i)) + Trange(i)*intgrl(Trange(i));
        elseif j == 3
            intgrl = @(T)- int(dpdt_secdiff(T,V),V,Vol3(i),Inf);
            cv(i) = cv_star(Trange(i)) + Trange(i)*intgrl(Trange(i));
        end
    end
    if j == 1
        cp = cp_cv1 + cv;
        cp_P1 = cp;
    elseif j == 2
        cp = cp_cv2 + cv;
        cp_P2 = cp;
    elseif j == 3
        cp = cp_cv3 + cv;
        cp_P3 = cp;
    end
    plot(Trange./Tcrit,cp,"linewidth",1)
    hold on
end

cp_star_array = zeros(1,length(Trange));

for i = 1:length(Trange)
    cp_star_array(i) = cp_star(Trange(i));
end

%plot(Trange,cp_star_array,'k--','LineWidth',2)

A_job = -59.69;
B_job = 0.709;
C_job = -6.572e-4;
D_job = 2.437e-7;

cp_star_job = @(T) A_job + B_job*T + C_job*T.^2 + D_job*T.^3;
cp_job = zeros(1,length(Trange));

for i = 1:length(Trange)
    cp_job(i) = cp_star_job(Trange(i));
end
plot(Trange./Tcrit,cp_job)
xlabel('Temperature (K)')
ylabel('Cp (J/mol.K)')
title('Cp versus temperature')
legend('Pr = 0.0','Pr = 0.5','Pr = 1.0','Joback Group Contribution')
hold off

% NO 7 - JT-coefficient vs. T graph
Trange = linspace(Ttriple,2*Tcrit,100);
for j = 1:length(Prange)
    u_jt = zeros(1,length(Trange));
    for i = 1:length(Trange)
        Vreal = max(vpasolve(Prb(Trange(i),V) == Prange(j), V, [0 Inf]));
        if j == 1
            u_jt(i) = (Vreal/cp_P1(i)).*(Trange(i).*alpha_P1(i)-1);
        elseif j == 2
            u_jt(i) = (Vreal/cp_P2(i)).*(Trange(i).*alpha_P2(i) - 1);
        elseif j == 3
            u_jt(i) = (Vreal/cp_P3(i)).*(Trange(i).*alpha_P3(i) - 1);
        end
    end
    if j == 1
        u_jt1 = u_jt;
    elseif j == 2
        u_jt2 = u_jt;
    elseif j == 3
        u_jt3 = u_jt;
    end
end
Trange = linspace(0,2,100);
plot(Trange,u_jt1)
hold on 
plot(Trange,u_jt2)
plot(Trange,u_jt3)

xlabel('Temperature (K)')
ylabel('Joule-Thomson Coefficient (K/Pa)')
%title('Graph of Joule-Thomson coefficient versus temperature')
legend('Pr = 0.0','Pr = 0.5','Pr = 1.0')
hold off

%% PROBLEM 6

syms T V

R = 8.314;
Ttriple = 180.97;
Tcrit = 437.22;
Pcrit = 5.34e+6;
antA = 4.29371;
antB = 995.445;
antC = -47.869;
Pant = @(T) (10^5)*10^(antA - (antB/(T + antC)));
b = 0.0778*R*Tcrit/Pcrit;

omega = -1 - log10(Pant(0.7*Tcrit)/Pcrit);
k_small = 0.37464 + 1.5422*omega - 0.26992*omega^2;
alpha_T = @(T) (1 + k_small*(1 - sqrt(T./Tcrit)))^2;
a_T = @(T) (0.45724*(R^2)*(Tcrit^2)/Pcrit) * alpha_T(T);

Prb = @(T,V) R*T./(V - b) - a_T(T)/(V.*(V + b) + b*(V - b));

Trange = Tcrit*[1,1.1,1.25,1.5,1.75,2];

Prange = linspace(0,8*Pcrit,100);

for i = 1:length(Trange)
    Zarray = [];
    P_newarray = [];
    for j = 1:length(Prange)
        Vreal = vpasolve(Prb(Trange(i),V) == Prange(j),V,[0 Inf])';
        
        if numel(Vreal) == 1
            Zarray = [Zarray Prange(j)*Vreal(1)/(R*Trange(i))];
            P_newarray = [P_newarray Prange(j)];
        elseif numel(Vreal) == 2
            Zarray = [Zarray Prange(j)*Vreal(1)/(R*Trange(i)) Prange(j)*Vreal(2)/(R*Trange(i))];
            P_newarray = [P_newarray Prange(j) Prange(j)];   
        end
    end
    if i == 1
        Z1 = double(Zarray');
    elseif i == 2
        Z2 = double(Zarray');
    elseif i == 3
        Z3 = double(Zarray');
    elseif i == 4
        Z4 = double(Zarray');
    elseif i == 5
        Z5 = double(Zarray');
    elseif i == 6
        Z6 = double(Zarray');
    end
    
    [P_newarray,sortIdx] = sort(P_newarray);
    Zarray = Zarray(sortIdx);
    plot(P_newarray/Pcrit,Zarray)
    hold on
    
end
legend({'Tr = 1.00','Tr = 1.10','Tr = 1.25','Tr = 1.50','Tr = 1.75','Tr = 2.00'},'Location','southeast')
xlabel('Reduced Pressure, Pr')
ylabel('Compressibility Factor, Z')
title('Graph of compressibility factor versus reduced pressure')
hold off


Zarray = [];
P_newarray = [];
for i = 1:length(Prange)
    Vreal = vpasolve(Prb(Tcrit,V) == Prange(i),V,[0 Inf])';
    if numel(Vreal) == 1
        Zarray = [Zarray Prange(i)*Vreal(1)/(R*Tcrit)];
        P_newarray = [P_newarray Prange(i)];
    elseif numel(Vreal) == 2
        Zarray = [Zarray Prange(i)*Vreal(1)/(R*Tcrit) Prange(i)*Vreal(2)/(R*Tcrit)];
        P_newarray = [P_newarray Prange(i) Prange(i)];
    end
end

[P_newarray,sortIdx] = sort(P_newarray);
Zarray = Zarray(sortIdx);

plot(P_newarray/Pcrit,Zarray)
hold on

a_vdW = 27*R^2*Tcrit^2/(64*Pcrit);
b_vdW = R*Tcrit/(8*Pcrit);
PvdW = @(T,V) R*T./(V - b_vdW) - a_vdW/V.^2;

Zarray = [];
P_newarray = [];

for i = 1:length(Prange)
    Vreal = vpasolve(PvdW(Tcrit,V) == Prange(i),V,[0 Inf])';
    if numel(Vreal) == 1
        Zarray = [Zarray Prange(i)*Vreal(1)/(R*Tcrit)];
        P_newarray = [P_newarray Prange(i)];
    elseif numel(Vreal) == 2
        Zarray = [Zarray Prange(i)*Vreal(1)/(R*Tcrit) Prange(i)*Vreal(2)/(R*Tcrit)];
        P_newarray = [P_newarray Prange(i) Prange(i)];
    elseif numel(Vreal) == 3
        Zarray = [Zarray Prange(i)*Vreal(1)/(R*Tcrit) Prange(i)*Vreal(2)/(R*Tcrit) Prange(i)*Vreal(3)/(R*Tcrit)];
        P_newarray = [P_newarray Prange(i) Prange(i) Prange(i)];
    end
end

[P_newarray,sortIdx] = sort(P_newarray);
Zarray = Zarray(sortIdx);
plot(P_newarray/Pcrit,Zarray)

Z_book = [0.955 0.942 0.925 0.905 0.88 0.86 0.84 0.82 0.8 0.75 0.7 0.6 0.5 0.4 0.35 0.3 0.278 0.235 0.233 0.23 0.24 0.3 0.35 0.42 0.485 0.54 0.59 0.65 0.88 0.925];
P_book = [0.1 0.15 0.2 0.25 0.3 0.35 0.4 0.45 0.5 0.63 0.74 0.88 0.96 0.98 1 1 1.02 1.1 1.2 1.25 1.5 2 2.5 3 3.5 4 4.5 5 7.7 8];

plot(P_book,Z_book,'k-')

xlabel('Reduced Pressure, Pr')
ylabel('Compressibility Factor, Z')
title('Graph of compressibility factor versus reduced pressure')
legend({'PR EOS','vdW EOS','Corresponding States values'},'Location','southeast')

%% PROBLEM 8

syms T V 

R = 8.314;
Ttriple = 180.97;
Tcrit = 437.22;
Pcrit = 5.34e+6;
antA = 4.29371;
antB = 995.445;
antC = -47.869;
Pant = @(T) (10^5)*10^(antA - (antB/(T + antC)));
b = 0.0778*R*Tcrit/Pcrit;

omega = -1 - log10(Pant(0.7*Tcrit)/Pcrit);
k_small = 0.37464 + 1.5422*omega - 0.26992*omega^2;
alpha_T = @(T) (1 + k_small*(1 - sqrt(T./Tcrit)))^2;
a_T = @(T) (0.45724*(R^2)*(Tcrit^2)/Pcrit) * alpha_T(T);

Prb = @(T,V) R*T./(V - b) - a_T(T)/(V.*(V + b) + b*(V - b));

dpdv = matlabFunction(diff(Prb,V));

Trange = Tcrit*[0.7,0.8,0.9,1,1.25,1.5];

Prange = linspace(-30e+6,20e+6,100);
    
for j = 1:length(Trange)    
    P_rangenew = [];  
    Varray = [];      
    for i = 1:length(Prange)  
        Vval = vpasolve(Prb(Trange(j),V) == Prange(i),V,[0 Inf])'; 
                                        
        n = numel(Vval);                               
    
        if n == 1                
            P_rangenew = [P_rangenew Prange(i)];  
            Varray = [Varray Vval(1)];           
        elseif n == 2
            P_rangenew = [P_rangenew Prange(i) Prange(i)]; 
            Varray = [Varray Vval(1) Vval(2)];             
        elseif n == 3                                       
            P_rangenew = [P_rangenew Prange(i) Prange(i) Prange(i)];
            Varray = [Varray Vval(1) Vval(2) Vval(3)];
        end
    end
    
    [Varray,sortIdx] = sort(Varray); 
    P_rangenew = P_rangenew(sortIdx); 
    plot(Varray,P_rangenew,'-')       
    hold on
end

P_spin = [];
V_spin = [];

Tnew = linspace(0,Tcrit,1000);

for k = 1:length(Tnew)
    Vval2 = vpasolve(dpdv(Tnew(k),V) == 0,V,[0 Inf])';
    m = numel(Vval2);
    if m == 2
        P_spin = [P_spin Prb(Tnew(k),Vval2(1)) Prb(Tnew(k),Vval2(2))];
        V_spin = [V_spin Vval2(1) Vval2(2)];
        
    elseif m == 1
        P_spin = [P_spin Prb(Tnew(k),Vval2(1))];
        V_spin = [V_spin Vval2(1)];
    elseif m == 3
        P_spin = [P_spin Prb(Tnew(k),Vval2(1)) Prb(Tnew(k),Vval2(2)) Prb(Tnew(k),Vval2(3))];
        V_spin = [V_spin Vval2(1) Vval2(2) Vval2(3)];
    end
end
[V_spin,sortIdx] = sort(V_spin); 
P_spin = P_spin(sortIdx); 
plot(V_spin,P_spin,'k--')

Trange = linspace(0,Tcrit,100);
Prange = linspace(Pcrit,-30e+6,1000); 

V_bin = [];
P_bin = [];
P_bin_nine = [];
T_bin_nine = [];

for j = 1:length(Trange)
    for i = 1:length(Prange)
        Vval3 = sort(vpasolve(Prb(Trange(j),V) == Prange(i),V,[0 Inf])');
        m = numel(Vval3);
        n = 1;
        if m == 3
            area = int(Prb(Trange(j),V) - Prange(i),V,Vval3(1),Vval3(3));
            if abs(area) <= 100
                V_bin = [V_bin Vval3(1) Vval3(3)];
                P_bin = [P_bin Prange(i) Prange(i)];
                P_bin_nine = [P_bin_nine Prange(i)];
                T_bin_nine = [T_bin_nine Trange(j)];
                n = n + 1;
                break
            end
        end  
        if n ~= 1
            break
            break
        end
    end
end

Vcrit = vpasolve(Prb(Tcrit,V) == Pcrit,V,[0 Inf]);
V_bin = [V_bin Vcrit];
P_bin = [P_bin Pcrit];

[V_bin,sortidx] = sort(V_bin);
P_bin = P_bin(sortidx);

plot(V_bin,P_bin,'k-','linewidth',2)
plot(Vcrit,Pcrit,'r*')

xlim([0 0.001])
ylim([-30e6 20e6])
xlabel('Volume (m^3/mol)')
ylabel('Pressure (Pa)')
title('Graph of Pressure versus Molar Volume')
legend({'Tr = 0.70','Tr = 0.80','Tr = 0.90','Tr = 1.00','Tr = 1.25','Tr = 1.50','Spinodal Curve','Binodal Curve','Critical point'},'Location','southeast')
hold off

%% PROBLEM 9

syms T V

R = 8.314;
Ttriple = 180.97;
Tcrit = 437.22;
Tfus = 180.15;

Proom = 10^5;
Pcrit = 5.34e+6;

antA = 4.29371;
antB = 995.445;
antC = -47.869;

Pant = @(T) (10^5)*10^(antA - (antB/(T + antC)));
b = 0.0778*R*Tcrit/Pcrit;
Ptriple = Pant(Ttriple);

H_vap = 33780;

omega = -1 - log10(Pant(0.7*Tcrit)/Pcrit);
k_small = 0.37464 + 1.5422*omega - 0.26992*omega^2;
alpha_T = @(T) (1 + k_small*(1 - sqrt(T./Tcrit)))^2;
a_T = @(T) (0.45724*(R^2)*(Tcrit^2)/Pcrit) * alpha_T(T);

Prb = @(T,V) R*T./(V - b) - a_T(T)/(V.*(V + b) + b*(V - b));

Vcrit = vpasolve(Prb(Tcrit,V) == Pcrit,V,[0 Inf]);
Trange_vap = linspace(Ttriple,Tcrit,100);

% VAP CURVE - if antoine equation
Pvap_ant = zeros(1,length(Trange_vap));

for i = 1:length(Trange_vap)
    Pvap_ant(i) = Pant(Trange_vap(i));
end

plot(Trange_vap,Pvap_ant,'k-','linewidth',1)
hold on

% VAP CURVE - if clausius clayperon eqn
Pclaus = @(T) Ptriple*exp(H_vap/R*(1/Ttriple - 1/T));
Pvap_claus = zeros(1,length(Trange_vap));

for i = 1:length(Trange_vap)
    Pvap_claus(i) = Pclaus(Trange_vap(i));
end

plot(Trange_vap,Pvap_claus,'k--','linewidth',1)

% VAP CURVE - PR EOS
plot(T_bin_nine,P_bin_nine,'m-.','linewidth',1)

% TRIPLE AND CRITICAL POINT 
plot(Ttriple,Ptriple,'b.','MarkerSize',20)
plot(Tcrit,Pcrit,'r.','MarkerSize',20)

% Setup of sublimation curve

syms A T
deltaHsub = 39.72086e+3;
B = deltaHsub/R;

Psub = @(A,T) 10^(A - B/T);
Trange_sub = linspace(0,Ttriple,100);

Aact = vpasolve(Psub(A,Ttriple) == Ptriple,A)

Psublim = zeros(1,length(Trange_sub));

for i = 1:length(Trange_sub)
    Psublim(i) = Psub(Aact,Trange_sub(i));
end

plot(Trange_sub,Psublim,'r-','linewidth',2)

% Setup of fusion curve

m = (Proom - Ptriple)/(Tfus - Ttriple)
c = Ptriple - m*Ttriple

Trange_fus = linspace(0,Ttriple,100);

Pfus = @(T) m*T + c;
Pfusion = zeros(1,length(Trange_fus));

for i = 1:length(Trange_fus)
    Pfusion(i) = Pfus(Trange_fus(i));
end

plot(Trange_fus,Pfusion,'r-','linewidth',2)

txt1 = 'Vaporization  Curve \rightarrow';
text(420,4.5e+6,txt1,'HorizontalAlignment','right')

txt2 = '\leftarrow Fusion curve';
text(175,1e+6,txt2)

txt3 = '\downarrow Sublimation curve';
text(25,0.25e+6,txt3)

txt4 = 'SOLID STATE';
text(25,2.5e6,txt4,'fontweight','bold')
txt5 = 'LIQUID STATE';
text(200,3e6,txt5,'fontweight','bold')
txt6 = 'VAPOR STATE';
text(340,0.5e6,txt6,'fontweight','bold')
txt7 = 'STATE';
text()

title('P - T diagram of Dimethylamine')
xlabel('Temperature (K)')
ylabel('Pressure (Pa)')
ylim([0 Pcrit])
legend({'Antoine Equation','Clausius-Clapeyron Equation','PR Equation','Triple Point','Critical Point'},'Location','northwest')
hold off

% PLOTTING VAP CURVE TO HAVE A BETTER VIEW
plot(Trange_vap,Pvap_ant,'k-','linewidth',1)
hold on
plot(Trange_vap,Pvap_claus,'k--','linewidth',1)
plot(T_bin_nine,P_bin_nine,'m-.','linewidth',1)
plot(Ttriple,Ptriple,'b.','MarkerSize',20)
plot(Tcrit,Pcrit,'r.','MarkerSize',20)

txt5 = 'LIQUID STATE';
text(200,3e6,txt5,'fontweight','bold')
txt6 = 'VAPOR STATE';
text(375,1.5e6,txt6,'fontweight','bold')

title('P - T diagram of Dimethylamine (Vaporization Curve)')
xlabel('Temperature (K)')
ylabel('Pressure (Pa)')
ylim([0 Pcrit])
legend({'Antoine Equation','Clausius-Clapeyron Equation','PR Equation','Triple Point','Critical Point'},'Location','northwest')
hold off

% PLOTTING LOG SCALE

plot(Trange_vap,Pvap_ant,'k-','linewidth',1)
hold on
plot(Trange_vap,Pvap_claus,'k--','linewidth',1)
plot(T_bin_nine,P_bin_nine,'m-.','linewidth',1)
plot(Ttriple,Ptriple,'b.','MarkerSize',20)
plot(Tcrit,Pcrit,'r.','MarkerSize',20)
plot(Trange_fus,Pfusion,'r-','linewidth',2)
plot(Trange_sub,Psublim,'r-','linewidth',2)

set(gca,'YScale','log')
txt1 = '\leftarrow Vaporization  Curve ';
text(420,1e4,txt1,'HorizontalAlignment','right')

txt2 = 'Fusion curve \rightarrow';
text(80,1e+4,txt2)

txt3 = '\leftarrow Sublimation curve';
text(170,1,txt3)

txt4 = 'SOLID STATE';
text(50,1e2,txt4,'fontweight','bold')
txt5 = 'LIQUID STATE';
text(200,1e7,txt5,'fontweight','bold')
txt6 = 'VAPOR STATE';
text(300,1e2,txt6,'fontweight','bold')

title('P - T diagram of Dimethylamine (logarithmic scale)')
xlabel('Temperature (K)')
ylabel('log(Pressure) (Pa)')
ylim([1e-5 1e8])
legend({'Antoine Equation','Clausius-Clapeyron Equation','PR Equation','Triple Point','Critical Point'},'Location','southeast')
hold off


