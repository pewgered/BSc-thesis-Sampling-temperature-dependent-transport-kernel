load('O16_SigmaE_SigmaT_energy.mat')

loglog(O16_0K_e,O16_0K_SigmaT,O16_294K_e,O16_294K_SigmaT,O16_600K_e,O16_600K_SigmaT,O16_900K_e,O16_900K_SigmaT,O16_1200K_e,O16_1200K_SigmaT,O16_2500K_e,O16_2500K_SigmaT)
%loglog(O16_0K_e,O16_0K_SigmaE,O16_294K_e,O16_294K_SigmaE,O16_600K_e,O16_600K_SigmaE,O16_900K_e,O16_900K_SigmaE,O16_1200K_e,O16_1200K_SigmaE,O16_2500K_e,O16_2500K_SigmaE)

%title('U235 CSes')

legend('0K','294K','600K','900K','1200K','2500K')

axis([5e-12 200 1e-1 200])
xticks([1e-11 1e-10 1e-9 1e-8 1e-7 1e-6 1e-5 1e-4 1e-3 1e-2 1e-1 1 10 150])