function [  ] = testMFP_U235(  )
tic
N=1e4;
T=600;
An=235;

load('U235_SigmaE_SigmaT_energy.mat')
avogadro=0.59703109;
suruseg=10;
U235_600K_SigmaT=U235_600K_SigmaT*avogadro*suruseg/An;
U235_0K_SigmaT=U235_0K_SigmaT*avogadro*suruseg/An;

indexek=energyindexfinderU235();
start=40000;
step=3;
len=100;
stop=(start+(len-1)*step);
CS=zeros(1,len);
energies=(start:step:stop);

for i=1:len
    CS(i)=1/getMeanFreePathU235(N,indexek(energies(i)),T,An);
    %U235_0K_e(indexek(energies(i)))
end

loglog(U235_0K_e(indexek(energies)),CS,'.',U235_0K_e,U235_0K_SigmaT,U235_600K_e,U235_600K_SigmaT)
legend('TMS','0K','600K')

xlim([(U235_0K_e(indexek(start))/1.1) (U235_0K_e(indexek(stop))*1.1)])
%ylim([1e-1 3e1])

title('600K Total CS U235')

toc
end