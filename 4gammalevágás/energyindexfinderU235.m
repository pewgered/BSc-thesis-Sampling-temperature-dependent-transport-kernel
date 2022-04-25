function [ indexek0, indexek600 ] = energyindexfinderU235(  )
load('U235_SigmaE_SigmaT_energy.mat')

j=1;
k=1;
indexek=zeros(2,1);
CS=zeros(2,1);
for i=1:size(U235_600K_e,1)
    while U235_0K_e(j)<U235_600K_e(i)
        j=j+1;
    end
    if U235_0K_e(j)==U235_600K_e(i)
        indexek(:,k)=[j,i];
        CS(:,k)=[U235_0K_e(j),U235_600K_e(i)];
        k=k+1;
    elseif U235_0K_e(j+1)==U235_600K_e(i)
        indexek(:,k)=[j+1,i];
        CS(:,k)=[U235_0K_e(j+1),U235_600K_e(i)];
        k=k+1;
    end
end
indexek=indexek.';
CS=CS.';
size(indexek,1)
indexek0=indexek(:,1);
indexek600=indexek(:,2);
%CS

end