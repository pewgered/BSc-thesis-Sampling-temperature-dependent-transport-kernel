function [ ekvilogIndex0, ekvilogIndex900] = ekvilogIndexfinderU235()

load('U235_SigmaE_SigmaT_energy.mat')
[i0,i900]=energyindexfinderU235_900K();
x=1:1:size(i0,1);

a=10^(1/10);
ekvilogE(1)=U235_0K_e(1);
for i=2:121
    ekvilogE(i)=ekvilogE(i-1)*a;
end
ekvilogE(122)=15;
ekvilogE(123)=20;
j=1;
for i=2:size(i0,1)
    %ekvilogE(j)
    if ekvilogE(j)<=U235_0K_e(i0(i))
        ekvilogIndex0(j)=i0(i);
        ekvilogIndex900(j)=i900(i);

        j=j+1;
    end
    if j==124
        break
    end
end
ekvilogIndex0=ekvilogIndex0';
ekvilogIndex900=ekvilogIndex900';


%xx=1:1:size(ekvilogIndex0,1);
%semilogy(xx,U235_0K_e(ekvilogIndex0),xx,U235_900K_e(ekvilogIndex900))

end