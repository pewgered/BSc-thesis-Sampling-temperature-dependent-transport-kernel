load('U235_SigmaE_SigmaT_energy.mat', 'U235_0K_SigmaT')
load('U235_SigmaE_SigmaT_energy.mat', 'U235_0K_e')
a=100;
n=floor(size(U235_0K_e,1)/a);
x=zeros(1,n);
y1=zeros(1,n);
for i=1:n
    index=(i-1)*a+1;
    x(i)=U235_0K_e(index);
    y1(i)=getMajorantCSU235(index,294,235,U235_0K_SigmaT,U235_0K_e);
end

loglog(x,y1)