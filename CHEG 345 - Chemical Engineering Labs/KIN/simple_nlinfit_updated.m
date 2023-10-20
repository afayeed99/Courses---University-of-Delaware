function simple_nlinfit_updated
% This is an example program to do simple non-linear regression against a
% single model equation; it can be adapted to do more complicted
% regression and use multiple equations and data sets simultaneously, if
% needed.

% The specific example uses lsqfit to regress the parameters in a test 
% model against h(t) data.
% The data used below are from Denn Table 2.1
h=[30.5 27.9 25.4 22.9 20.3 17.8 15.2 12.7 10.2 7.6 5.1];
t=[0 5.8 10.9 16.6 23.0 30 36.4 43.8 51 60.2 71];

npoints=length(t); % this is the number of entries in h=[] and t=[]

%Let X denote the vector of time values
%Let Y denote the vector of height values
% these lines can easily be changed to input other types of data (e.g., concentrations and rates)
X=t; 
Y=h;
%Let b0 denote the vector of initial guesses for the model parameters
%See also, the functional form in the Function "ycalc" listed below
b0=[30;.01]

%Use the built-in function "nlinfit" to use nonlinear least-squares
%regression to estimate best-fit values of the model parameters
[bfinal,Resid,Jac,COVB,MSE]=nlinfit(X,Y,@Model,b0);
h0_pred=real(bfinal(1))
k=real(bfinal(2))


%Plot the actual data (height vs. time) and compare with the predicted
%curve of h(t).  By convention, plot actual data as symbols, and plot
%predictions or models as continuous curves.
% If you are changing the data inputs and model(s), adjust the plot labels
% accordingly

for i=1:npoints
    %make sure this equation matches that in the function "ycalc" below
    h_pred(i)=h0_pred*(1-k/sqrt(h0_pred)*X(i))^2;
end



plot(X,h,'ro',X,h_pred,'b-') % these can be tailored to your needs
xlabel('time(s)'); % these can be tailored to your needs
ylabel('height(cm.)'); % these can be tailored to your needs
%Use the built-in function "nlparci" to estimate the 95% confidence
%intervals for the fitted parameters
ci = nlparci([h0_pred,k],Resid,'covar',COVB)

% the function below needs to be adjusted based on whatever equation(s) you
% are trying to fit against your data; be sure to also change the
% corresponding equation for h_pred being calculated above
function ycalc=Model(b,X)
h0=b(1);
k=b(2);
npts=length(X);
for i=1:npts % make sure that the index "i" runs from "1" to the number of data points in your data set
% that you entered for the h(t) vector and t vector at the top of the program 
    %ycalc(i)=h0*exp(-k*X(i));
    ycalc(i)=h0*(1-k/sqrt(h0)*X(i))^2; % this is the "model equation" being fit; tailor it to your needs
end
ycalc=ycalc;

