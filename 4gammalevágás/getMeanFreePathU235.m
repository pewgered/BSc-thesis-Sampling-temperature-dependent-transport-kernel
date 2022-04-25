function [ MFP ] = getMeanFreePathU235( N, Eindex, T, An )
%getMeanFreePathU235(1e9,58300,600,235)
tic

load('U235_SigmaE_SigmaT_energy.mat', 'U235_0K_SigmaT')
load('U235_SigmaE_SigmaT_energy.mat', 'U235_0K_e')
load('U235_SigmaE_SigmaT_energy.mat', 'U235_600K_SigmaT')
load('U235_SigmaE_SigmaT_energy.mat', 'U235_600K_e')
avogadro=0.59703109;
suruseg=10;
U235_0K_SigmaT=U235_0K_SigmaT*avogadro*suruseg/An;
U235_600K_SigmaT=U235_600K_SigmaT*avogadro*suruseg/An;

[i0,i600]=energyindexfinderU235();

1/U235_600K_SigmaT(i600(Eindex))

MeV=1e6; %eV MeV átváltás
eV=1.602176e-19; %1 eV Joule átváltás
Mn=1.674927e-27; %AMU kg
k=1.380649e-23; %Boltzmann-állandó J/K

E=U235_0K_e(i0(Eindex))
lambda=sqrt(An/(k*T))*sqrt(eV*MeV)*sqrt(E); % így lesz SI
maj=getMajorantCSU235exact(i0(Eindex),T,An,U235_0K_SigmaT,U235_0K_e);
majcorr=maj*g(lambda);

v=sqrt(2*E*MeV*eV/Mn); % így kapjuk m/s-ban
gamma=sqrt(An*Mn/(2*k*T));

totCS=U235_0K_SigmaT;   %(minindex:maxindex);
tote=U235_0K_e;         %(minindex:maxindex);

FP=zeros(1,N);
for i=1:N
    accept=false;
    while accept==false
        FP(i)=FP(i)-1/majcorr*log(1-rand());

        newE=getNewEnergy(v,gamma);
        tot=getTotCS(newE,totCS,tote);

        if rand()<tot/maj
            accept=true;
        end
    end
end


E=U235_0K_e(i0(Eindex));
lambda=sqrt(An/(k*T))*sqrt(eV*MeV)*sqrt(E); % így lesz SI
[maj,minindex,maxindex]=getMajorantCSU235(i0(Eindex),T,An,U235_0K_SigmaT,U235_0K_e);
majcorr=maj*g(lambda);

v=sqrt(2*E*MeV*eV/Mn); % így kapjuk m/s-ban
gamma=sqrt(An*Mn/(2*k*T));

totCS=U235_0K_SigmaT(minindex:maxindex);
tote=U235_0K_e(minindex:maxindex);


FPappr=zeros(1,N);
for i=1:N
    accept=false;
    while accept==false
        FPappr(i)=FPappr(i)-1/majcorr*log(1-rand());

        newE=getNewEnergy(v,gamma);
        tot=getTotCS(newE,totCS,tote);

        if rand()<tot/maj
            accept=true;
        end
    end
end

CS=U235_600K_SigmaT(i600(Eindex));
FPexact=zeros(1,N);
for i=1:N
    FPexact(i)=-1/CS*log(1-rand());
end

maximum=max([max(FP),max(FPappr),max(FPexact)]);
[f,x]=calculatePDF(FP, 100, 0.0, maximum, 1);
[fa,xa]=calculatePDF(FPappr, 100, 0.0, maximum, 1);
[fe,xe]=calculatePDF(FPexact, 100, 0.0, maximum, 1);
semilogy(xe,fe,'.',x,f,'.',xa,fa,'.')
legend('Woodcock','Levágás nélkül','4/gamma levágás')
xlabel('Szabadúthossz (cm)')
ylabel('Eloszlás')
%title('Szabadúthossz eloszlása U235 600K 0,0883MeV') 

MFP=mean(FP)
MFPa=mean(FPappr)
MFPe=mean(FPexact)
toc
end