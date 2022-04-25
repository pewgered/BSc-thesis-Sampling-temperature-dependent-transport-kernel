function [] = MB_fejlseg() %GUARDYAN fejlesztési segédlet
tic

nValues=1e7;
Values=zeros(1,nValues);
irany=zeros(1,nValues);

v=2200; %termikus neutron átlagos sebessége: 2200 m/s
An=238; %urán tömegszáma AMU
Mn=1.674927e-27; %AMU kg
k=1.380649e-23; %Boltzmann-állandó J/K
T=290; %termikus neutron legvalószínûbb hõmérséklete: 290K

gamma=sqrt(An*Mn/(2*k*T)); %MB-eloszlás paramétere
4/gamma
B=gamma*v*sqrt(pi)/2; 
crit1=(1/(1+B));

elfogad=0;
osszes=0;

for i=1:nValues
    accept=true;
    while accept     
        if rand()<crit1
            vT=sqrt(-log(rand()*rand()));
            vT=vT/gamma;
        else
            vT=sqrt(-log(rand())-log(rand())*cos(pi/2*rand())^2);
            vT=vT/gamma;
        end

        mu=2*rand()-1; %szórt neutron iránykoszinusza
        vr=sqrt(v^2+vT^2-2*v*vT*mu);
        crit2=vr/(v+vT);   
        if rand()<crit2
            Values(i)=vr;%vT;
            %=vr;
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
legend("fejlseg")

toc
end