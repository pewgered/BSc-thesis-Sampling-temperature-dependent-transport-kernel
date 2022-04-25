load('U235_SigmaE_SigmaT_energy.mat')

loglog(U235_0K_e,U235_0K_SigmaT-U235_0K_SigmaE,U235_294K_e,U235_294K_SigmaT-U235_294K_SigmaE,U235_600K_e,U235_600K_SigmaT-U235_600K_SigmaE,U235_900K_e,U235_900K_SigmaT-U235_900K_SigmaE,U235_1200K_e,U235_1200K_SigmaT-U235_1200K_SigmaE,U235_2500K_e,U235_2500K_SigmaT-U235_2500K_SigmaE)

title('U235 tot-es')

legend('0K','294K','600K','900K','1200K','2500K')

axis([5e-12 50 1e-1 6e4])
xticks([1e-11 1e-10 1e-9 1e-8 1e-7 1e-6 1e-5 1e-4 1e-3 1e-2 1e-1 1 10 20])