# Butadiene Polymerization Parameter Estimation ⚛️🐍

Access the paper at: https://4spepublications.onlinelibrary.wiley.com/doi/full/10.1002/pen.25232


This repository contains a modern, Python-based computational framework for estimating kinetic and thermodynamic parameters of a dynamic Butadiene Polymerization model. 

Originally written in Fortran, this project has been fully refactored into a highly modular, **Universal Python ecosystem**. It utilizes the power of `numpy` for high-performance matrix operations and `scipy.integrate` (BDF method) for solving complex, stiff Differential-Algebraic Equations (DAEs). The parameter estimation is driven by a Particle Swarm Optimization (PSO) algorithm, designed to find the global minimum of the Maximum Likelihood objective function.

---

## 🚀 Key Features

* **Universal Compatibility:** A single, unified codebase that automatically adapts to different experimental setups (60°C, 70°C, 80°C, or UA Estimation) by dynamically reading the `.dat` files. No hardcoding required!
* **Robust Fail-Safes (Runaway Protection):** Built-in physical boundaries (preventing negative concentrations/temperatures) and `try...except` integration airbags. If the PSO algorithm tests a physically impossible parameter that causes a Thermal Runaway, the system gracefully penalizes the particle instead of crashing.
* **Particle Swarm Optimization (PSO):** A derivative-free global search algorithm for highly non-linear chemical systems.
* **Legacy Data Support:** Custom parsers seamlessly read and interpret the original Fortran `.dat` files, completely ignoring inline text comments (`!`) and mixed delimiters (commas/spaces).

---

## 🧪 Experiment Modes

The system automatically detects the type of experiment based on the data provided in `dadosbusca.dat` and `exp.dat`:

1. **Kinetic Estimation (60°C, 70°C, 80°C):** If the optimizer receives 5 or more parameters, the system unlocks the kinetic constants ($k_{1c}$, $k_{pt}$, $k_{pc}$, etc.) and automatically selects the correct Heat Transfer Coefficient (`UA`) based on the initial reactor temperature ($T_0$).
2. **Heat Transfer Estimation (UA Version):** If the optimizer receives exactly 1 parameter, the system automatically locks the kinetic constants to their optimal reference values and uses the PSO solely to estimate the global heat transfer coefficient (`UA`).

---

## 📂 Project Structure

* `principal.py`: The main orchestrator. Run this file to start the estimation.
* `enxame0.py`: The Particle Swarm Optimization (PSO) core algorithm.
* `modelo.py` & `taxa.py`: The mathematical modeling of the chemical reactor, the mass/energy balances, and the fail-safe integration mechanisms.
* `calcula.py`: Evaluates the objective function comparing experimental data vs. model predictions.
* `leitura.py`: Safely parses the experimental data files (`.dat`), emulating Fortran's strict read behavior.
* Modules (`monomero.py`, `solvente_n_hexano.py`, `psat.py`, etc.): Built-in functions for thermodynamic calculations, vapor pressures, and heat capacities.

### 📄 Experimental Data (Required)
Ensure the following files are placed in the root directory before running the model:
* `dadosexp.dat` (Dimensions and setup)
* `exp.dat` (Raw experimental measurements)
* `dadosbusca.dat` (Search boundaries, hyperparameters, and initial parameter guesses)

---

## ⚙️ Environment Setup & Installation

To ensure consistency across the engineering team, we use **[pyenv](https://github.com/pyenv/pyenv)** to manage our Python versions. 

### 1. Set up the Python Version
Ensure you have `pyenv` installed on your machine. We recommend using Python 3.10 or higher.

```bash
# Install the required Python version
pyenv install 3.11.7
```
# Set the local Python version for this specific repository
```bash
pyenv local 3.11.7
```

2. Create a Virtual Environment
It is highly recommended to isolate the project dependencies.

```bash
# Create a virtual environment named '.venv'
python -m venv .venv


# Activate the virtual environment
# On Windows:
.venv\Scripts\activate
# On macOS/Linux:
source .venv/bin/activate

# Clone the repository
git clone https://github.com/gaappucrio/ButadienePolym.git
cd ButadienePolym
```
3. Install Dependencies
Install the required scientific libraries:

```bash
pip install numpy scipy
```

▶️ How to Run
With the virtual environment activated and the .dat files in the root folder, simply execute the main script:

Warning: Remember to get to the correct folder you want, example with 60°C:
```bash
cd 60°C
cd Estimacao
python principal.py
```

📊 Expected Output
During execution, the terminal will display the optimization progress in real-time:

Plaintext
Iniciando Estimação de Parâmetros...
Fim Leitura dos dados experimentais
Iniciando otimização PSO com 50 partículas e 1 parâmetros...
ITERACAO 1 Fobj 1.543210E+04
...
Upon completion, the script generates the following report files in the root directory:

relatorioenxame.dat: Final optimized parameters and the lowest objective function value.

Saida_bom.dat: The convergence history of the global bests (perfect for plotting).

Saida_tudo.dat: Raw data of all particles across all iterations (useful for confidence region plotting and variance analysis).

🤝 Version Control Practice for the Engineering Team
This repository serves as a collaborative training ground for our team to practice Git and version control.

Workflow Guidelines:

Never commit directly to main. Always create a new branch for your tests or feature additions:
git checkout -b feature/update-thermo-params

Make your modifications (e.g., adjusting the PSO hyperparameters in dadosbusca.dat).

Commit your changes with clear, descriptive messages:
```bash
git commit -m "Adjusted heat capacity constants for n-hexane"
```

Push your branch to the repository:
git push origin feature/update-thermo-params

Open a Pull Request (PR) on GitHub for the team to review and merge.
