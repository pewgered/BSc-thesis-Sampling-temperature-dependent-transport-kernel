function [ ekvilogIndex0, ekvilogIndex600] = ekvilogIndexfinderO16()

load('O16_SigmaE_SigmaT_energy.mat')
[i0,i600]=energyindexfinderO16();
x=1:1:size(i0,1);

a=10^(1/10);
ekvilogE(1)=O16_0K_e(1);
for i=2:121
    ekvilogE(i)=ekvilogE(i-1)*a;
end
ekvilogE(122)=15;
ekvilogE(123)=20;
j=1;
for i=2:size(i0,1)
    %ekvilogE(j)
    if ekvilogE(j)<=O16_0K_e(i0(i))
        ekvilogIndex0(j)=i0(i);
        ekvilogIndex600(j)=i600(i);

        j=j+1;
    end
    if j==124
        break
    end
end
ekvilogIndex0=ekvilogIndex0';
ekvilogIndex600=ekvilogIndex600';


%xx=1:1:size(ekvilogIndex0,1);
%semilogy(xx,O16_0K_e(ekvilogIndex0),xx,O16_600K_e(ekvilogIndex600))

end