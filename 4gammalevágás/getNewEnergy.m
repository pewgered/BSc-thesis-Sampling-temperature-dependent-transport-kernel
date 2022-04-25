function [ newE ] = getNewEnergy( v, gamma )

Mn=1.674927e-27; %AMU kg

B=gamma*v*sqrt(pi)/2; %
crit1=(1/(1+B)); %

accept2=true;
while accept2       
    if rand()<crit1
        vT=sqrt(-log(rand()*rand()));
        vT=vT/gamma;
    else
        vT=sqrt(-log(rand())-log(rand())*cos(pi/2*rand())^2);
        vT=vT/gamma;
    end

    mu=2*rand()-1; %sz�rt neutron ir�nykoszinusza
    vr=sqrt(v^2+vT^2-2*v*vT*mu);

    crit2=vr/(v+vT);   
    if rand()<crit2
        accept2=false;
    end
end

newE=Mn*vr^2/2;

MeV=1e6; %eV MeV �tv�lt�s
eV=1.602176e-19; %1 eV Joule �tv�lt�s

newE=newE/(MeV*eV);

end