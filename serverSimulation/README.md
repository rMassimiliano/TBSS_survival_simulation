The code in this folder is designed to run a cluster using [Slurm](https://slurm.schedmd.com/overview.html). 

The folder `Rscr/` contains utility functions for running the various methods.

The folders `Scenario1/`, `Scenario2/`, `Scenario3/`, `ScenarioH1/`, `ScenarioH2/`, `ScenarioH3/`, `ScenarioPS1/`, `ScenarioPS2/`, and `ScenarioPS3/` contain code to replicate results from the simulation scenarios. Each of these folders contains the following files.

* `1.generate_data.R` generates replicates of the study data and saves them in the `data/` folder. This is executed via `run_gen_dat.sh`.

* The files `2.bernoulliTBSS.R`, `3.poissonTBSS.R`, `4.poissonSTBSS.R`, `5.robustTBSS.R`, and `6.coxTBSS.R` apply the testing procedures described in Section 4 of the main manuscript. These scripts are executed via `run_all.sh`.

* The files `power_curve.R` and `fdr_curves.R` compute the global power, the false discovery rate, and the true discovery rate. They are executed via `run_fdr.sh`.

Finally, the file `get_computing_time.R` extracts information on computing time.


