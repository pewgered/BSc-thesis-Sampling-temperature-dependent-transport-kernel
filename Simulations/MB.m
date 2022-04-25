function [] = MB() %Normál eloszlású számokból, paraméterezve
tic

nValues=1e8;
Values=zeros(1,nValues);

v=2200; %termikus neutron sebessége
An=238; %urán tömegszáma AMU
m=1.674927e-27; %AMU kg
k=1.380649e-23; %Boltzmann-állandó J/K
T=290; %termikus neutron legvalószínûbb hõmérséklete: 290K
beta=sqrt(An*m/(2*k*T));

for i=1:nValues
    
    %arg=getNormalNumber_Exact()^2+getNormalNumber_Exact()^2+getNormalNumber_Exact()^2;
    arg=randn()^2+randn()^2+randn()^2;
    vT=sqrt(arg/2)/beta;
    Values(i)=vT;

end

%ecdf(Values)

figure(1)
hold on
[f,x]=calculatePDF(Values, 1000, 0.0, max(Values), 1);
plot(x,f)
plot(x,sqrt(beta^6*2/pi*8)*x.^2.*exp(-x.^2.*(beta^2)))
legend("Random","Exact")
%hold off

toc
end