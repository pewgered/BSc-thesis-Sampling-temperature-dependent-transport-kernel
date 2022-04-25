function [  ] = transport3D_O16(  )
tic
T=600;
An=16;

MeV=1e6; %eV MeV átváltás
eV=1.602176e-19; %1 eV Joule átváltás
Mn=1.674927e-27; %AMU kg
k=1.380649e-23; %Boltzmann-állandó J/K

load('O16_SigmaE_SigmaT_energy.mat')
avogadro=0.59703109;
suruseg=1;
O16_600K_SigmaT=O16_600K_SigmaT*avogadro*suruseg/An;
O16_600K_SigmaE=O16_600K_SigmaE*avogadro*suruseg/An;
O16_0K_SigmaT=O16_0K_SigmaT*avogadro*suruseg/An;
O16_0K_SigmaE=O16_0K_SigmaE*avogadro*suruseg/An;

[i0,i600]=energyindexfinderO16();
eIndex=100;

E=O16_600K_e(i600(eIndex));
[maj,minindex,maxindex]=getMajorantCSO16nemindexesen(E,T,An,O16_600K_SigmaT,O16_600K_e);


nValues=1e7;
O16_600K_SigmaT(i600(eIndex))
radius=3/O16_600K_SigmaT(i600(eIndex))
e0=O16_0K_e(i0(eIndex))
v0=sqrt(O16_0K_e(eIndex)*eV*MeV*2/Mn)
t0=radius/v0
j=1;
for i=1:nValues
    pos=zeros(1,3);
    time=0;
    energy=O16_0K_e(i0(eIndex));
    isAlive=true;
    isInside=true;
    irany=getIsotropicDirection();
    scatdir=[0, 0, 1];
    while isAlive && isInside
        [FP, newE, mu]=getMFP_O16nemindexesen(energy,T,An,O16_0K_SigmaT,O16_0K_e,maj,minindex,maxindex);

        irany=transformDirection(scatdir,irany);
        pos=pos+FP*irany;
        v=sqrt(2*energy*MeV*eV/Mn);
        time=time+FP/v;
        
        if pos(1)^2+pos(2)^2+pos(3)^2>radius
            isInside=false;
            times(j)=time-getDistToSphere(radius,pos,-irany)/v;
            energies(j)=energy;
            j=j+1;
            break
        end
        
        probScat=getProbScat(newE,O16_0K_e,O16_0K_SigmaT,O16_0K_SigmaE);
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
toc
tic
j=1;
for i=1:nValues
    pos=zeros(1,3);
    time=0;
    energy=O16_600K_e(i600(eIndex));
    isAlive=true;
    isInside=true;
    irany=getIsotropicDirection();
    scatdir=[0, 0, 1];
    while isAlive && isInside

        [FP, newE, mu]=getMFP_O16_exact(energy,An,T,O16_600K_SigmaT,O16_600K_e);


        v=sqrt(2*energy*MeV*eV/Mn);
        irany=transformDirection(scatdir,irany);
        pos=pos+FP*irany;

        time=time+FP/v;
        
        if pos(1)^2+pos(2)^2+pos(3)^2>radius
            isInside=false;
            exacttimes(j)=time-getDistToSphere(radius,pos,-irany)/v;
            exactenergies(j)=energy;
            j=j+1;
            break
        end
        
        probScat=getProbScat(newE,O16_600K_e,O16_600K_SigmaT,O16_600K_SigmaE);
        if rand()>probScat
            isAlive=false;            
        else
            oldE=energy;
            energy=newE+(oldE+2*mu*(An+1)*sqrt(oldE*newE))/(An+1)^2;
            mu=mu*sqrt(newE/energy)+1/(An+1)*sqrt(oldE/energy);
            phi=2*pi*rand();
            sinmu=sqrt(1-mu^2);
            scatdir=[sinmu*cos(phi),sinmu*sin(phi),mu];
        end
    end
end

yes=0;
yes2=0;
if yes
    egybolkiszokes=0;
    j=1;
    size(energies,2)
    for i=1:size(energies,2)
        if energies(i)==e0
            egybolkiszokes=egybolkiszokes+1;
        else
            e(j)=energies(i);
            j=j+1;
        end
    end


    exactegybolkiszokes=0;
    j=1;
    size(exactenergies,2)
    for i=1:size(exactenergies,2)
        if exactenergies(i)==e0
            exactegybolkiszokes=exactegybolkiszokes+1;
        else
            ee(j)=exactenergies(i);
            j=j+1;
        end
    end
    egybolkiszokes
    exactegybolkiszokes
    if yes2
        [f,x]=calculatePDF(e, 100, 0.0, 5e-8, 1);
        [ff,xx]=calculatePDF(ee, 100, 0.0, 5e-8, 1);
        plot(xx,ff,'.',x,f,'.')
        xlabel('Energia (MeV)')
        ylabel('Eloszlás')
        legend('Referencia','TMS')
    else
        semilogx(energies,times,'.',exactenergies,exacttimes,'.')
        xlabel('Energia (MeV)')
        ylabel('Idõ (s)')
        legend('Referencia','TMS')
    end

    
elseif yes2
    j=1;
    size(energies,2)
    for i=1:size(energies,2)
        if times(i)<=0.02 && 0.015<times(i)
            e2(j)=energies(i);
            j=j+1;
        elseif times(i)<=0.015 && 0.01<times(i)
            e1(j)=energies(i);
            j=j+1;
        elseif times(i)<=0.01 && 0.005<times(i)
            e5(j)=energies(i);
            j=j+1;
        end
    end
    j=1;
    size(exactenergies,2)
    for i=1:size(exactenergies,2)
        if exacttimes(i)<=0.02 && 0.015<exacttimes(i)
            ee2(j)=exactenergies(i);
            j=j+1;
        elseif exacttimes(i)<=0.015 && 0.01<exacttimes(i)
            ee1(j)=exactenergies(i);
            j=j+1;
        elseif exacttimes(i)<=0.01 && 0.005<exacttimes(i)
            ee5(j)=exactenergies(i);
            j=j+1;
        end     
    end

    [f2,x2]=calculatePDF(e2, 100, 0.0, 5e-8, 0);
    [f1,x1]=calculatePDF(e1, 100, 0.0, 5e-8, 0);
    [f5,x5]=calculatePDF(e5, 100, 0.0, 5e-8, 0);
    [ff2,xx2]=calculatePDF(ee2, 100, 0.0, 5e-8, 0);
    [ff1,xx1]=calculatePDF(ee1, 100, 0.0, 5e-8, 0);
    [ff5,xx5]=calculatePDF(ee5, 100, 0.0, 5e-8, 0);
    plot(xx5,ff5,'.',xx1,ff1,'.',xx2,ff2,'.',x5,f5,'.',x1,f1,'.',x2,f2,'.')
    xlabel('Energia (MeV)')
    ylabel('Neutronok száma')
    legend('Referencia (0,005-0,01 s)','Referencia (0,01-0,015 s)','Referencia (0,015-0,02 s)','TMS (0,005-0,01 s)','TMS (0,01-0,015 s)','TMS (0,015-0,02 s)')
else
    j=1;
    size(energies,2)
    for i=1:size(energies,2)
        if energies(i)<=1e-8 && 0.5e-8<energies(i)
            e5(j)=times(i);
            j=j+1;
        elseif energies(i)<=2e-8 && 1e-8<energies(i)
            e1(j)=times(i);
            j=j+1;
        elseif energies(i)<=4e-8 && 3e-8<energies(i)
            e2(j)=times(i);
            j=j+1;
        end
    end
    j=1;
    size(exactenergies,2)
    for i=1:size(exactenergies,2)
        if exactenergies(i)<=1e-8 && 0.5e-8<exactenergies(i)
            ee5(j)=exacttimes(i);
            j=j+1;
        elseif exactenergies(i)<=2e-8 && 1e-8<exactenergies(i)
            ee1(j)=exacttimes(i);
            j=j+1;
        elseif exactenergies(i)<=4e-8 && 3e-8<exactenergies(i)
            ee2(j)=exacttimes(i);
            j=j+1;
        end     
    end

    [f2,x2]=calculatePDF(e2, 100, 0.0, max([e2,ee2]), 0);
    [f1,x1]=calculatePDF(e1, 100, 0.0, max([e1,ee1]), 0);
    [f5,x5]=calculatePDF(e5, 100, 0.0, max([e5,ee5]), 0);
    [ff2,xx2]=calculatePDF(ee2, 100, 0.0, max([e2,ee2]), 0);
    [ff1,xx1]=calculatePDF(ee1, 100, 0.0, max([e1,ee1]), 0);
    [ff5,xx5]=calculatePDF(ee5, 100, 0.0, max([e5,ee5]), 0);
    plot(xx5,ff5,'.',xx1,ff1,'.',xx2,ff2,'.',x5,f5,'.',x1,f1,'.',x2,f2,'.')
    xlabel('Idõ (s)')
    ylabel('Neutronok száma')
    legend('Referencia (0,5-1e-8 MeV)','Referencia (1-2e-8 MeV)','Referencia (3-4e-8 MeV)','TMS (0,5-1e-8 MeV)','TMS (1-2e-8 MeV)','TMS (3-4e-8 MeV)')

end
toc
end