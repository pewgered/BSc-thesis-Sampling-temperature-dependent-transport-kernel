function [ MFP, newE, mu ] = getMFP_O16( N, Eindex, T, An, O16_0K_SigmaT, O16_0K_e )

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

FP=zeros(1,N);
for i=1:N
    accept=false;
    while accept==false
        FP(i)=FP(i)-1/majcorr*log(1-rand());

        [newE,mu]=getNewEnergy(v,gamma);
        tot=getTotCS(newE,totCS,tote);

        if rand()<tot/maj
            accept=true;
        end
    end
end

MFP=mean(FP);

%histogram(FP,100);
%[f,x]=calculatePDF(FP, 1000, 0.0, max(FP), 1);
%plot(x,f)

end