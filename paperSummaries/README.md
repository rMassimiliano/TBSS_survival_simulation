
This folder contains code to reproduce the figures presented in section 4 of the main paper and the supplementary materials.

The folder `resultSummaries/` contains summarized results that can be produced using the code in the `../serverSimulation/` folder. In the folder `resultSummaries/power/`, there are two files for each method and scenario: one with the suffix `_power` containing global power results, and the other with the suffix `_fdr` containing true positive and false positive rates. The folder `resultSummaries/computingTimes/` contains results on computing times.

The folders `plotGlobalPower/`, `plotFDR/`, and `plotTPR/` contain a `plot.r` script that produces a plot for each of the 9 settings considered in the paper. The plots are linked to a grid defined in Adobe Illustrator that aligns them and creates the final plot for the paper, including the legend.


The script `simulationTree/plotSimulationTree.r` plots the tree used to generate simulated data in section 4 of the main manuscript. An edited version of this figure appears in the supplementary material. The edits (made in Adobe Illustrator) add colors to some nodes to describe the mechanisms used to inject signals in the simulation and their effect on the node hierarchy, along with a legend.
