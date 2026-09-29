#!/bin/bash
#SBATCH --time=10:00:00
#SBATCH --job-name=power
#SBATCH --output=out/power/fdr.out
#SBATCH --error=out/power/fdr.err
#SBATCH --mail-type=BEGIN,END
#SBATCH --mail-user=russo.325@osu.edu
module load gnu/14 R

# Run job
Rscript fdr_curves.R
~                                                                                                                                                  
~                                                                                                                                                  
~                                                                                                                                                  
~                                                                                                                                                  
~                                                                                                                                                  
~                                                                                                                                                  
~                                                                       

