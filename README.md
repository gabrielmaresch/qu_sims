# qu_sims

Small quantum simulation experiments in Julia, focused on:

- Adiabatic two-level transition dynamics
- Bose-Hubbard model exploration

## Repository contents

- `adiabatic_transitions.jl`  
  Julia script that computes adiabatic transition probabilities and exports an interactive HTML plot to `adiabatic.html`.

- `adiabatic_simulation.ipynb`  
  Notebook version of the adiabatic transition workflow.

- `bose_hubbard.ipynb`  
  Notebook for Bose-Hubbard mean-field simulations and phase visualization.

- `Project.toml`  
  Julia project metadata.

## Requirements

- Julia 1.x

## Setup

From the repository root:

```bash
julia --project=. -e 'using Pkg; Pkg.instantiate()'
```

## Run

### Adiabatic transitions script

```bash
julia --project=. adiabatic_transitions.jl
```

This generates:

```text
adiabatic.html
```

### Notebooks

Start Jupyter with Julia support:

```bash
julia --project=. -e 'using IJulia; notebook()'
```

Then open:

- `adiabatic_simulation.ipynb`
- `bose_hubbard.ipynb`

## License

This project is licensed under the MIT License. See [`LICENSE`](LICENSE).
