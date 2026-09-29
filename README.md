# TBSS Survival Simulation

This repository contains code to replicate the simulations in the paper "A tree-based scan statistic for database studies with time-to-event outcomes."

The simulations generate power curves across increasing values of the exposure effect under a variety of scenarios and methods, and are designed to run on a cluster using [Slurm](https://slurm.schedmd.com/overview.html). 

The functions implementing the proposed method build on the TBSS R package available at this [link](https://github.com/rMassimiliano/TBSS) and are located in the `Rscr/` folder. A broader implementation of the proposed methods is being integrated into the TBSS R package and will be available soon.

The folder `serverSimulation/` contains code to replicate the simulations on an HCP system, while the folder `paperSummaries/` contains precomputed summaries to reproduce the plots for the paper's simulation section.



