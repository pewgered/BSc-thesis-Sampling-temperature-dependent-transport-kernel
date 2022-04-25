function [  ] = testMFP_U235_relativElteresTeljesSpektrum(  )
tic
N=1e5;
T=900;
An=235;

load('U235_SigmaE_SigmaT_energy.mat')
avogadro=0.59703109;
suruseg=10;
U235_900K_SigmaT=U235_900K_SigmaT*avogadro*suruseg/An;
U235_0K_SigmaT=U235_0K_SigmaT*avogadro*suruseg/An;

[i0,i900]=ekvilogIndexfinderU235();
len=size(i0,1);
y1=zeros(1,len);

for i=1:len
    [MFP,newE,mu,efficiency(i)]=getMFP_U235(N,i0(i),T,An,U235_0K_SigmaT,U235_0K_e);
    CS=1/MFP;
    y1(i)=(CS-U235_900K_SigmaT(i900(i)))/U235_900K_SigmaT(i900(i));
end
mineff=min(efficiency) %3,1623e-5 MeV-nél
maxeff=max(efficiency)
meaneff=mean(efficiency)

semilogx(U235_0K_e(i0),y1,'.')
xlabel('Energia (MeV)')
ylabel('Relatív eltérés')

xlim([1e-12, 1e2])
toc
end