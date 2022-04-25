function [ indexek1, indexek2 ] = energyindexfinderO16(  )
load('O16_SigmaE_SigmaT_energy.mat')

j=1;
k=1;
indexek=zeros(2,1);
CS=zeros(2,1);
for i=1:size(O16_600K_e,1)
    while O16_0K_e(j)<O16_600K_e(i)
        j=j+1;
    end
    if O16_0K_e(j)==O16_600K_e(i)
        indexek(:,k)=[j,i];
        CS(:,k)=[O16_0K_e(j),O16_600K_e(i)];
        k=k+1;
    elseif O16_0K_e(j+1)==O16_600K_e(i)
        indexek(:,k)=[j+1,i];
        CS(:,k)=[O16_0K_e(j+1),O16_600K_e(i)];
        k=k+1;
    end
end
indexek=indexek.';
CS=CS.';
size(indexek,1);
indexek1=indexek(:,1);
indexek2=indexek(:,2);

end