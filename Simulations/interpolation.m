load('U235_SigmaE_SigmaT_energy.mat')
tic
N=1e7;
T=900;
An=235;

avogadro=0.59703109;
suruseg=10;
U235_0K_SigmaT=U235_0K_SigmaT*avogadro*suruseg/An;
U235_600K_SigmaT=U235_600K_SigmaT*avogadro*suruseg/An;
U235_900K_SigmaT=U235_900K_SigmaT*avogadro*suruseg/An;
U235_1200K_SigmaT=U235_1200K_SigmaT*avogadro*suruseg/An;

indexek=energyindexfinderU235_900K();
start=39805;
%start=200;
step=3;
len=30;
stop=(start+(len-1)*step);
CS=zeros(1,len);
energies=(start:step:stop);
for i=1:len
    CS(i)=1/getMFP_U235(N,indexek(energies(i)),T,An,U235_0K_SigmaT,U235_0K_e);
end

[i600,i1200]=energyindexfinder600_900_1200_U();
lin=zeros(size(i600,1),1);
loglg=zeros(size(i600,1),1);
sqrtsqrt=zeros(size(i600,1),1);
a=log(3/2)/log(2);
b=(sqrt(3)-sqrt(2))/(2-sqrt(2));
for i=1:size(i600,1)
    lin(i)=(U235_600K_SigmaT(i600(i))+U235_1200K_SigmaT(i1200(i)))/2;
    loglg(i)=U235_600K_SigmaT(i600(i))^(1-a)*U235_1200K_SigmaT(i1200(i))^a;
    sqrtsqrt(i)=((sqrt(U235_1200K_SigmaT(i1200(i)))-sqrt(U235_600K_SigmaT(i600(i))))*b+sqrt(U235_600K_SigmaT(i600(i))))^2;
end

loglog(U235_900K_e,U235_900K_SigmaT,U235_600K_e(i600(:)),lin,U235_600K_e(i600(:)),loglg,U235_600K_e(i600(:)),sqrtsqrt,U235_0K_e(indexek(energies)),CS,'*',U235_0K_e,U235_0K_SigmaT)
legend("900K","linear","loglog","sqrtsqrt","TSM","0K")
xlabel('Energia (MeV)')
ylabel('Hatáskeresztmetszet (1/cm)')

xlim([(U235_0K_e(indexek(start))/1.1) (U235_0K_e(indexek(stop))*1.1)])
toc