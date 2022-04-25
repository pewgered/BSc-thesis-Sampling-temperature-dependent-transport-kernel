function [ FP, newE, mu ] = getMFP_O16_exact( E, An, T, CS, e)
MeV=1e6; %eV MeV átváltás
eV=1.602176e-19; %1 eV Joule átváltás
Mn=1.674927e-27; %AMU kg
k=1.380649e-23; %Boltzmann-állandó J/K

v=sqrt(2*E*MeV*eV/Mn); % így kapjuk m/s-ban
gamma=sqrt(An*Mn/(2*k*T));

[newE,mu]=getNewEnergy(v,gamma);

CS=getTotCS(E,CS,e);
FP=-1/CS*log(1-rand());


end