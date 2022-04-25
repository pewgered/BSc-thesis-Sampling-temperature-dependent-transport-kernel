function [ FP, newE, mu ] = getMFP_O16nemindexesen( E, T, An, O16_0K_SigmaT, O16_0K_e,maj,minindex,maxindex )

MeV=1e6; %eV MeV átváltás
eV=1.602176e-19; %1 eV Joule átváltás
Mn=1.674927e-27; %AMU kg
k=1.380649e-23; %Boltzmann-állandó J/K

if E~=O16_0K_e(100)
    [maj,minindex,maxindex]=getMajorantCSO16nemindexesen(E,T,An,O16_0K_SigmaT,O16_0K_e);
end

lambda=sqrt(An/(k*T))*sqrt(eV*MeV)*sqrt(E); % így lesz SI
majcorr=maj*g(lambda);

v=sqrt(2*E*MeV*eV/Mn); % így kapjuk m/s-ban
gamma=sqrt(An*Mn/(2*k*T));

totCS=O16_0K_SigmaT(minindex:maxindex);
tote=O16_0K_e(minindex:maxindex);

accept=false;
FP=0;
while accept==false
    FP=FP-1/majcorr*log(1-rand());

    [newE,mu]=getNewEnergy(v,gamma);
    tot=getTotCS(newE,totCS,tote);

    if rand()<tot/maj
        accept=true;
    end
end
end