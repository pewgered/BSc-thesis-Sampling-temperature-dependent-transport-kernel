load('O16_SigmaE_SigmaT_energy.mat')
T=600;
An=16;
MeV=1e6; %eV MeV átváltás
eV=1.602176e-19; %1 eV Joule átváltás
Mn=1.674927e-27; %AMU kg
k=1.380649e-23; %Boltzmann-állandó J/K
avogadro=0.59703109;
suruseg=1;
O16_600K_SigmaT=O16_600K_SigmaT*avogadro*suruseg/An;
O16_600K_SigmaE=O16_600K_SigmaE*avogadro*suruseg/An;
O16_0K_SigmaT=O16_0K_SigmaT*avogadro*suruseg/An;
O16_0K_SigmaE=O16_0K_SigmaE*avogadro*suruseg/An;
E=O16_600K_e(132)
[maj,minindex,maxindex]=getMajorantCSO16nemindexesen(E,T,An,O16_600K_SigmaT,O16_600K_e)
