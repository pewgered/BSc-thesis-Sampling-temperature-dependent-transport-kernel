# BSc-thesis-Sampling-temperature-dependent-transport-kernel

The documentation of this project is written in hungarian!

My BSc thesis project was Sampling temperature dependent transport kernel. The heart of every Monte Carlo reactor simulation code is the cross section library. Complex geometries can contain several materials, and the energy and temperature depentdent cross sections take up tens or hundreds gigabytes of space. I studied and implemented a method that can calculate the temperature dependent cross sections mid-flight for any given energy using only 0K (or arbitrary temperature) cross section data. This is possible by simulatig the Doppler-boardening for each individual neutrons. The method produced high precision temperature dependent cross section data.

The method is impemented in GUARDYAN code: http://awing.reak.bme.hu/GUARDYAN/wiki/WikiStart

GUARDYAN (GPU Assisted Reactor Dynamic Analysis) is a continuous energy Monte Carlo (MC) neutron transport code developed at Budapest University of Technology and Economics (BME). It targets to solve time-dependent problems related to fission reactors with the main focus on simulating and analyzing short transients. The key idea of GUARDYAN is a massively parallel execution structure making use of advanced programming possibilities available on CUDA (Compute Unified Device Architecture) enabled GPUs (Graphics Processing Units).
