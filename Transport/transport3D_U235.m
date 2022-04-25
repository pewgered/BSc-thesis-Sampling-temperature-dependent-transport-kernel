function [  ] = transport3D_U235(  )
tic
T=600;
An=235;

MeV=1e6; %eV MeV átváltás
eV=1.602176e-19; %1 eV Joule átváltás
Mn=1.674927e-27; %AMU kg
k=1.380649e-23; %Boltzmann-állandó J/K

load('U235_SigmaE_SigmaT_energy.mat')
avogadro=0.59703109;
suruseg=10;
U235_600K_SigmaT=U235_600K_SigmaT*avogadro*suruseg/An;
U235_600K_SigmaE=U235_600K_SigmaE*avogadro*suruseg/An;
U235_0K_SigmaT=U235_0K_SigmaT*avogadro*suruseg/An;
U235_0K_SigmaE=U235_0K_SigmaE*avogadro*suruseg/An;


[indexek0,indexek600]=energyindexfinderU235();
eIndex=40000;
nValues=1e4;
radius=3/U235_600K_SigmaT(indexek600(eIndex))
eIndex=indexek0(eIndex);

j=1;
for i=1:nValues
    
    pos=zeros(1,3);
    time=0;
    energy=U235_0K_e(eIndex);
    isAlive=true;
    isInside=true;
    irany=getIsotropicDirection();
    scatdir=[0, 0, 1];

    while isAlive && isInside
        [FP, newE, mu]=getMFP_U235(1,eIndex,T,An,U235_0K_SigmaT,U235_0K_e);
        irany=transformDirection(scatdir,irany);
        oldPos=pos;
        pos=pos+FP*irany;
        v=sqrt(2*energy*MeV*eV/Mn);
        time=time+FP/v;
        
        if pos(1)^2+pos(2)^2+pos(3)^2>radius
            isInside=false;
            %times(j)=time-FP/v+getDistToSphere(radius,oldPos,v,irany,FP/v)/v;
            times(j)=time;
            energies(j)=energy;
            j=j+1;
            break
        end
            
        probScat=getProbScat(newE,U235_0K_e,U235_0K_SigmaT,U235_0K_SigmaE);
        
        if rand()>probScat
            isAlive=false;            
        else
            oldE=energy;
            energy=newE+(oldE+2*mu*(An+1)*sqrt(oldE*newE))/(An+1)^2;
            mu=mu*sqrt(newE/energy)+1/(An+1)*sqrt(oldE/energy);
            phi=2*pi*rand();
            sinmu=sqrt(1-mu^2);
            scatdir=[sinmu*cos(phi), sinmu*sin(phi),mu];
        end
    end
end

plot(times, energies,'.')
xlabel('ido')
ylabel('energia')

toc
end