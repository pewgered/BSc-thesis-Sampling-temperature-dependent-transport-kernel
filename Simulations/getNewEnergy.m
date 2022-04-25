function [ newE, mu ] = getNewEnergy( v, gamma )

Mn=1.674927e-27; %AMU kg

B=gamma*v*sqrt(pi)/2; %
crit1=(1/(1+B)); %

accept1=true;
while accept1
    accept2=true;
    while accept2       
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
            accept2=false;
        end
    end
    
    if vr<v+4/gamma && vr>v-4/gamma %4/gamma levágás
        accept1=false;
    end
end

newE=Mn*vr^2/2;

MeV=1e6; %eV MeV átváltás
eV=1.602176e-19; %1 eV Joule átváltás

newE=newE/(MeV*eV);

end


