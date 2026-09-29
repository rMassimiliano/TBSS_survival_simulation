#!/bin/bash
#SBATCH --time=20:00:00
#SBATCH --array=1-1000
module load  R

# Run job
#
Rscript 2.bernoulliTBSS.R -r $SLURM_ARRAY_TASK_ID;
Rscript 3.poissonTBSS.R -r $SLURM_ARRAY_TASK_ID;
Rscript 4.poissonSTBSS.R -r $SLURM_ARRAY_TASK_ID;
Rscript 5.robustTBSS.R -r $SLURM_ARRAY_TASK_ID;                                                                                                            
Rscript 6.coxTBSS.R -r $SLURM_ARRAY_TASK_ID
~                                                                                                                                                  
~                                                                                                                                                  
~                                                                                                                                                  
~                                                                                                                                                  
~                                                                                                                                                  
~                                                                                                                                                  
~                                                                       

