function [ maj, i, j ] = getMajorantCSO16( Eindex, T, An, O16_0K_SigmaT, O16_0K_e )
%Az energiát indexelvel kell átadni a függvénynek!!

MeV=1e6; %eV MeV átváltás
eV=1.602176e-19; %1 eV Joule átváltás
k=1.380649e-23; %Boltzmann-állandó J/K

lambda=sqrt((An)/(k*T));
temp=4/lambda/sqrt(eV*MeV);

E0=O16_0K_e(1);
if (sqrt(O16_0K_e(Eindex))-temp)<E0
    Emin=E0;
else
    Emin=(sqrt(O16_0K_e(Eindex))-temp)^2;
end
Emax=(sqrt(O16_0K_e(Eindex))+temp)^2;
%[Emin,Emax]

i=1;
while Emin>O16_0K_e(i+1)
    i=i+1; %Eminhez tartozó index keresése
end
j=size(O16_0K_e,1);
while Emax<O16_0K_e(j-1)
    j=j-1; %Emaxhez tartozó index keresése
end
%[i,j]
%j-i
%ha Emin Emax közé nem esik energia akkor a két legközelebbi közül a nagyobbik számít    
maj=max(O16_0K_SigmaT(i:j));

end