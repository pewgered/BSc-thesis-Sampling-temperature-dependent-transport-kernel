function [ indexek600K, indexek1200K ] = energyindexfinder600_900_1200_U(  )
load('U235_SigmaE_SigmaT_energy.mat')

j=1;
k=1;
indexek=zeros(2,1);
CS=zeros(2,1);
for i=1:size(U235_1200K_e,1)
    while U235_600K_e(j)<U235_1200K_e(i)
        j=j+1;
    end
    if U235_600K_e(j)==U235_1200K_e(i)
        indexek(:,k)=[j,i];
        k=k+1;
    elseif U235_600K_e(j+1)==U235_1200K_e(i)
        indexek(:,k)=[j+1,i];
        k=k+1;
    end
end
indexek=indexek.';
size(indexek,1)
indexek600K=indexek(:,1);
indexek1200K=indexek(:,2);
end