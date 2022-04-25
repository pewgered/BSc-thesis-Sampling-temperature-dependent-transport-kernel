load('O16_SigmaE_SigmaT_energy.mat')
load('U235_SigmaE_SigmaT_energy.mat')

y=zeros(1,size(O16_0K_e,1));

MeV=1e6; %eV MeV �tv�lt�s
eV=1.602176e-19; %1 eV Joule �tv�lt�s
Mn=1.674927e-27; %AMU kg
k=1.380649e-23; %Boltzmann-�lland� J/K

for i=1:size(O16_0K_SigmaE,1)
    lambda=sqrt(16/(k*294))*sqrt(eV*MeV)*sqrt(O16_0K_e(i)); % �gy lesz SI
    y(i)=O16_0K_SigmaE(i)*g(lambda);
end

loglog(O16_0K_e,y,O16_294K_e,O16_294K_SigmaE,O16_0K_e,O16_0K_SigmaE)