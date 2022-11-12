# README for OFW17_caseFilesREADME.txt

This work uses OpenFOAM v9. It does not require the installation of other resources.

All cases run in the dedicated folder /runCases, which contains the script runCase.sh.
Editing the scipr it is possible to view the list of availabe cases: meshSensitivity, [...].

The cases are initialized as a steady state simulation of the gas flow (simpleFoam). Then the simulation becomes trnsient, and the particle injection starts (denseParticleFoam). To run the case, use the script Allrun. It is advisable to run the cases through the aforementioned script runCase.sh in the dedicated folder.

PVstate.psvm is the paraView state model used for the post-processing visualization. As it is loaded, select the correct vtk sets (eulerian + lagrangian sets) in the current case. Only one state configuration has been included, to avoid clutter.

## Old description
This work uses OpenFOAM v9. It does not require the installation of other resources.

The runs are initialized: the folder 0/ contains the steady state conditions for the gas flow only, initialized through the same solver, increasing the timestep, and disabling particle injection. The script to run this is Allrun. The initial conditions are contained in BASE_0/

To run the CFD-DEM or MP-PIC cases using the initialized pipe, use the Runhalf script.

State1.psvm is the ParaView state for postprocessing; choose the correct vtk dataseries.