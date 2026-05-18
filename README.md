# qu_sims

Small quantum simulation experiments in Julia, focused on:

- Adiabatic two-level transition dynamics
- Bose-Hubbard model exploration

## Repository contents

- `/home/runner/work/qu_sims/qu_sims/adiabatic_transitions.jl`  
  Julia script that computes adiabatic transition probabilities and exports an interactive HTML plot to `adiabatic.html`.
- `/home/runner/work/qu_sims/qu_sims/adiabatic_simulation.ipynb`  
  Notebook version of the adiabatic transition workflow.
- `/home/runner/work/qu_sims/qu_sims/bose_hubbard.ipynb`  
  Notebook for Bose-Hubbard mean-field simulations and phase visualization.
- `/home/runner/work/qu_sims/qu_sims/Project.toml`  
  Julia project metadata.

## Requirements

- Julia 1.x

## Setup

From the repository root (`/home/runner/work/qu_sims/qu_sims`):

```bash
julia --project=. -e 'using Pkg; Pkg.instantiate()'
```

## Run

### Adiabatic transitions script

```bash
julia --project=. /home/runner/work/qu_sims/qu_sims/adiabatic_transitions.jl
```

This generates `/home/runner/work/qu_sims/qu_sims/adiabatic.html`.

### Notebooks

Start Jupyter with Julia support:

```bash
julia --project=. -e 'using IJulia; notebook()'
```

Then open:

- `/home/runner/work/qu_sims/qu_sims/adiabatic_simulation.ipynb`
- `/home/runner/work/qu_sims/qu_sims/bose_hubbard.ipynb`

## License

MIT — see `/home/runner/work/qu_sims/qu_sims/LICENSE`.
