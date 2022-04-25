function [ maj, i, j ] = getMajorantCSU235( Eindex, T, An, U235_0K_SigmaT, U235_0K_e )
%Az energi�t indexelvel kell �tadni a f�ggv�nynek!!

MeV=1e6; %eV MeV �tv�lt�s
eV=1.602176e-19; %1 eV Joule �tv�lt�s
k=1.380649e-23; %Boltzmann-�lland� J/K

lambda=sqrt((An)/(k*T));
cutoff=4/lambda/sqrt(eV*MeV);

E0=U235_0K_e(1);
if (sqrt(U235_0K_e(Eindex))-cutoff)<E0
    Emin=E0;
else
    Emin=(sqrt(U235_0K_e(Eindex))-cutoff)^2;
end
Emax=(sqrt(U235_0K_e(Eindex))+cutoff)^2;
%[Emin,Emax]

i=1;
while Emin>U235_0K_e(i+1)
    i=i+1; %Eminhez tartoz� index keres�se
end
j=size(U235_0K_e,1);
while Emax<U235_0K_e(j-1)
    j=j-1; %Emaxhoz tartoz� index keres�se
end
%[i,j]
%j-i
%ha Emin Emax k�z� nem esik energia akkor a k�t legk�zelebbi k�z�l a nagyobbik sz�m�t    
maj=max(U235_0K_SigmaT(i:j));
end