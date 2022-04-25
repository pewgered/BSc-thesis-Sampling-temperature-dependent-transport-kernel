function [ FP, newE, mu ] = getMFP_O16_exact( E, An, T, CS, e)
MeV=1e6; %eV MeV �tv�lt�s
eV=1.602176e-19; %1 eV Joule �tv�lt�s
Mn=1.674927e-27; %AMU kg
k=1.380649e-23; %Boltzmann-�lland� J/K

v=sqrt(2*E*MeV*eV/Mn); % �gy kapjuk m/s-ban
gamma=sqrt(An*Mn/(2*k*T));

[newE,mu]=getNewEnergy(v,gamma);

CS=getTotCS(E,CS,e);
FP=-1/CS*log(1-rand());


end