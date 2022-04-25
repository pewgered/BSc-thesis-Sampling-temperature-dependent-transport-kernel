function [  ] = testMFP_O16_relativElteresTeljesSpektrum_600K(  )
tic
N=1e4;
T=600;
An=16;

load('O16_SigmaE_SigmaT_energy.mat')
avogadro=0.59703109;
suruseg=1;
O16_600K_SigmaT=O16_600K_SigmaT*avogadro*suruseg/An;
O16_0K_SigmaT=O16_0K_SigmaT*avogadro*suruseg/An;

[i0,i600]=ekvilogIndexfinderO16();
len=size(i0,1);
y1=zeros(1,len);
O16_0K_e(i0(107))
for i=1:len
    [MFP,newE,mu,efficiency(i)]=getMFP_O16(N,i0(i),T,An,O16_0K_SigmaT,O16_0K_e);
    CS=1/MFP;
    y1(i)=(CS-O16_600K_SigmaT(i600(i)))/O16_600K_SigmaT(i600(i));
end
mineff=min(efficiency) %3,1623e-5 MeV-nél
maxeff=max(efficiency)
meaneff=mean(efficiency)
efficiency;

semilogx(O16_0K_e(i0),y1,'.')
xlabel('Energia (MeV)')
ylabel('Relatív eltérés')

xlim([1e-12, 1e2])
toc
end