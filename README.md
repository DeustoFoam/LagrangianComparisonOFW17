# Lagrangian Comparison: CFD-DEM vs MP-PIC (OFW17)

OpenFOAM case files for comparing two Eulerian-Lagrangian approaches, **CFD-DEM** and **MP-PIC**, in the pneumatic conveying of metal powder through a small channel of a Laser Metal Deposition (LMD) machine.

This repository contains the simulation setup used in the following paper:

> L. Pedrolli, B. Achiaga Menor, I. Martinez de Arenaza, A. López,
> **"Comparison of CFD-DEM and MP-PIC in the Simulation of Metal Powder Conveying for Laser Metal Deposition"**,
> *OpenFOAM® Journal*, vol. 4, pp. 26–40, 2024.
> DOI: [10.51560/ofj.v4.91](https://doi.org/10.51560/ofj.v4.91)

## Requirements

- [OpenFOAM v9](https://openfoam.org/version/9/) (openfoam.org). No other solvers or libraries are needed.
- `m4`, used to generate `blockMeshDict` from `system/blockMeshDict.m4`.
- An MPI environment, because the cases run in parallel (`decomposeParDict`).
- [ParaView](https://www.paraview.org/) (optional), for post-processing.

## Repository structure

| Folder | Content |
|--------|---------|
| `meshSensitivity/fluidOnly/` | Mesh sensitivity study for the gas phase only (`coarser_*`, `chosen`, `finer_*` meshes), with a results spreadsheet |
| `meshSensitivity/injectionMod/` | Steady gas-flow initialization used to test the injection setup |
| `initSteady/` | Steady-state gas flow (`simpleFoam`) used to initialize the transient cases |
| `CFD-DEM/` | Transient particle-laden simulations with `denseParticleFoam`, using `collidingCloud` (DEM `pairCollision`) |
| `MP-PIC/` | Transient particle-laden simulations with `denseParticleFoam`, using `MPPICCloud` (packing, damping and isotropy models) |
| `runCases/` | `runCase.sh`, the driver script; all cases are copied here and run in this folder |

Each case family has a `BASE/` folder with the shared setup and one folder per variant, which holds only the files that differ from `BASE`:

- `v5m_s/`: gas inlet velocity of 5 m/s
- `v10m_s/`: gas inlet velocity of 10 m/s

The case-specific parameters (velocity, end time, write interval, parcel injection rate, time step) are in `constant/variables` (Lagrangian cases) or `0/U` (`initSteady`).

## Workflow

1. **Steady initialization**: `simpleFoam` computes the steady gas flow for each inlet velocity (`initSteady`).
2. **Transient particle-laden flow**: the steady field is mapped (`mapFields`) onto the CFD-DEM and MP-PIC cases. Then `denseParticleFoam` runs with particle injection.
3. **Post-processing**: results are converted to VTK (`foamToVTK`). The particle flow rate escaping through the outlet is extracted from the solver log into `times.csv` and `escaped.csv`.

## Running the cases

Source your OpenFOAM v9 environment, then run:

```sh
cd runCases
./runCase.sh
```

Choose one of the options:

1. `meshSensitivity_fluid`: mesh sensitivity study (gas only)
2. `CFD-DEM`: CFD-DEM cases. Runs `initSteady` first if it has not been run yet.
3. `MP-PIC`: MP-PIC cases. Runs `initSteady` first if it has not been run yet.
4. `initSteady`: steady-state initialization only

For each case family, the script copies it into `runCases/` and merges `BASE` into every variant. Then it runs each variant's `Allrun`. The original case files in the repository are not modified.

The Lagrangian cases also provide:

- `Runhalf`: re-runs the transient part (decomposition, solver, reconstruction, VTK export, flow-rate extraction) on an already meshed and mapped case.
- `Allcomplete`: only runs `reconstructPar` and `foamToVTK`, for example after an interrupted parallel run.

## Post-processing

`CFD-DEM/BASE/State1.pvsm` and `MP-PIC/BASE/State1.pvsm` are ParaView state files for visualizing the results. After loading a state, select the correct VTK sets (Eulerian and Lagrangian) of the current case. Only one state configuration is included, to avoid clutter.

## Citation

If you use these case files, please cite the paper:

```bibtex
@article{Pedrolli2024,
  author  = {Pedrolli, Lorenzo and Achiaga Menor, Beatriz and Martinez de Arenaza, Inger and L{\'o}pez, Alejandro},
  title   = {Comparison of {CFD-DEM} and {MP-PIC} in the Simulation of Metal Powder Conveying for Laser Metal Deposition},
  journal = {OpenFOAM{\textregistered} Journal},
  volume  = {4},
  pages   = {26--40},
  year    = {2024},
  doi     = {10.51560/ofj.v4.91}
}
```
