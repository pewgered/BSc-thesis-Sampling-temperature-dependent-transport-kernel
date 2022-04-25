function [ MFP, newE, mu, efficiency ] = getMFP_O16( N, Eindex, T, An, O16_0K_SigmaT, O16_0K_e )
MeV=1e6; %eV MeV átváltás
eV=1.602176e-19; %1 eV Joule átváltás
Mn=1.674927e-27; %AMU kg
k=1.380649e-23; %Boltzmann-állandó J/K

E=O16_0K_e(Eindex);
lambda=sqrt(An/(k*T))*sqrt(eV*MeV)*sqrt(E); % így lesz SI
[maj,minindex,maxindex]=getMajorantCSO16(Eindex,T,An,O16_0K_SigmaT,O16_0K_e);
majcorr=maj*g(lambda);

v=sqrt(2*E*MeV*eV/Mn); % így kapjuk m/s-ban
gamma=sqrt(An*Mn/(2*k*T));

totCS=O16_0K_SigmaT(minindex:maxindex);
tote=O16_0K_e(minindex:maxindex);

sumFP=0;
numbersneeded=0;
for i=1:N
    accept=false;
    tempFP=0;
    while accept==false
        tempFP=tempFP-1/majcorr*log(1-rand());

        [newE,mu]=getNewEnergy(v,gamma);
        tot=getTotCS(newE,totCS,tote);

        if rand()<tot/maj
            accept=true;
        end
        numbersneeded=numbersneeded+1;
    end
    sumFP=sumFP+tempFP;
end

efficiency=N/numbersneeded;
MFP=sumFP/N;

end