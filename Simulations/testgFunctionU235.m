load('O16_SigmaE_SigmaT_energy.mat')
load('U235_SigmaE_SigmaT_energy.mat')

y=zeros(1,size(U235_0K_SigmaE,1));

MeV=1e6; %eV MeV �tv�lt�s
eV=1.602176e-19; %1 eV Joule �tv�lt�s
Mn=1.674927e-27; %AMU kg
k=1.380649e-23; %Boltzmann-�lland� J/K

for i=1:size(U235_0K_SigmaE,1)
    lambda=sqrt(235/(k*294))*sqrt(eV*MeV)*sqrt(U235_0K_e(i)); % �gy lesz SI
    y(i)=U235_0K_SigmaE(i)*g(lambda);
end

loglog(U235_0K_e,y,U235_294K_e,U235_294K_SigmaE)%,U235_0K_e,U235_0K_SigmaE)

legend('szamolt', 'valos','0K')