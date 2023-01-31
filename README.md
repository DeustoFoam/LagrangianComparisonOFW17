# README for OFW17_caseFilesREADME.txt

This work uses OpenFOAM v9. It does not require the installation of other resources.

All cases run in the dedicated folder /runCases, which contains the script runCase.sh.

The cases are initialized using a steady state simulation of the gas flow (simpleFoam). Then the simulation becomes transient, and the particle injection starts (denseParticleFoam). It is advisable to run the cases through the aforementioned script runCase.sh in the dedicated folder.

PVstate.psvm is the paraView state model used for the post-processing visualization. As it is loaded, select the correct vtk sets (eulerian + lagrangian sets) in the current case. Only one state configuration has been included, to avoid clutter.