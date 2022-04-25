load('O16_SigmaE_SigmaT_energy.mat', 'O16_0K_SigmaT')
load('O16_SigmaE_SigmaT_energy.mat', 'O16_0K_e')

n=size(O16_0K_e,1);
x=zeros(1,n);
y1=zeros(1,n);
for i=1:n
    x(i)=O16_0K_e(i);
    y1(i)=getMajorantCSO16(i,294,16,O16_0K_SigmaT,O16_0K_e);
end

loglog(x,y1)