This work uses OpenFOAM v9. It does not require the installation of other resources.

The runs are initialized: the folder 0/ contains the steady state conditions for the gas flow only, initialized through the same solver, increasing the timestep, and disabling particle injection. The script to run this is Allrun. The initial conditions are contained in BASE_0/

To run the CFD-DEM or MP-PIC cases using the initialized pipe, use the Runhalf script.

State1.psvm is the ParaView state for postprocessing; choose the correct vtk dataseries.
