function [  ] = testMFP_O16(  )
tic
N=1e5;
T=600;
An=16;

load('O16_SigmaE_SigmaT_energy.mat')
avogadro=0.59703109;
suruseg=1;
O16_600K_SigmaT=O16_600K_SigmaT*avogadro*suruseg/An;
O16_0K_SigmaT=O16_0K_SigmaT*avogadro*suruseg/An;

indexek=energyindexfinderO16();
start=1000;
step=1;
len=100;
stop=(start+(len-1)*step);
CS=zeros(1,len);
energies=(start:step:stop);

for i=1:len
    CS(i)=1/getMeanFreePathO16(N,indexek(energies(i)),T,An);
end

loglog(O16_0K_e(indexek(energies)),CS,'.',O16_0K_e,O16_0K_SigmaT,O16_600K_e,O16_600K_SigmaT)
legend('TMS','0K','600K')

xlim([(O16_0K_e(indexek(start))/1.1) (O16_0K_e(indexek(stop))*1.1)])
%ylim([1e-1 4])

title('600K Total CS O16')

toc
end