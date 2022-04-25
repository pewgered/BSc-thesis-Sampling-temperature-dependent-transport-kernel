n=100;
x=linspace(-12,2,n);
y=zeros(1,n);
MeV=1e6; %eV MeV �tv�lt�s
eV=1.602176e-19; %1 eV Joule �tv�lt�s
Mn=1.674927e-27; %AMU kg
k=1.380649e-23; %Boltzmann-�lland� J/K
for i=1:n
    x(i)=10^x(i);
    lambda=sqrt(16/(k*294))*sqrt(eV*MeV)*sqrt(x(i)); % �gy lesz SI
    y(i)=g(lambda);
end
loglog(x,y)