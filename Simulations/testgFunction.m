n=100;
x=linspace(-12,2,n);
y=zeros(1,n);
MeV=1e6; %eV MeV átváltás
eV=1.602176e-19; %1 eV Joule átváltás
Mn=1.674927e-27; %AMU kg
k=1.380649e-23; %Boltzmann-állandó J/K
for i=1:n
    x(i)=10^x(i);
    lambda=sqrt(16/(k*294))*sqrt(eV*MeV)*sqrt(x(i)); % így lesz SI
    y(i)=g(lambda);
end
loglog(x,y)