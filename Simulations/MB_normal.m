function [] = MB_normal() %GUARDYAN fejlesztési segédlet
tic

nValues=1e7;
Values=zeros(1,nValues);
irany=zeros(1,nValues);

v=2200; %termikus neutron átlagos sebessége: 2200 m/s
An=238; %urán tömegszáma AMU
m=1.674927e-27; %AMU kg
k=1.380649e-23; %Boltzmann-állandó J/K
T=290; %termikus neutron legvalószínûbb hõmérséklete: 290K

beta=sqrt(An*m/(2*k*T)); %MB-eloszlás paramétere

B=beta*v*sqrt(pi)/2; 
crit1=(1/(1+B));

elfogad=0;
osszes=0;

for i=1:nValues
    accept=true;
    while accept     
        if rand()<crit1
            vT=sqrt(-log(rand()*rand()));
            vT=vT/beta;
        else
            %arg=getNormalNumber_Exact()^2+getNormalNumber_Exact()^2+getNormalNumber_Exact()^2;
            arg=randn()^2+randn()^2+randn()^2;
            vT=sqrt(arg/2)/beta;
        end

        mu=2*rand()-1; %szórt neutron iránykoszinusza
        crit2=sqrt(v^2+vT^2-2*v*vT*mu)/(v+vT);   
        if rand()<crit2
            Values(i)=vT;
            accept=false;
            irany(i)=acos(mu);
            
            elfogad=elfogad+1;
        end
        osszes=osszes+1;
    end
   
end

elfogad/osszes

figure(1)
hold on
%ecdf(Values)

%[f,x]=calculatePDF(irany, 1000, min(irany), max(irany), 1);
%polar(x,f)

[f,x]=calculatePDF(Values, 1000, 0.0, max(Values), 1);
plot(x,f)
legend("normál")

toc
end

