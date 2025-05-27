#!/bin/bash
#SBATCH -J freesurfer
#SBATCH -p skylake
#SBATCH -n 1
#SBATCH -t 9:00:00
#SBATCH -o ./%x_%j.out
#SBATCH -e ./%x_%j.err
#SBATCH --mail-type=BEGIN,END
#SBATCH --mail-user=lucile.hashimoto@adalab.fr

# chargement des modules
module purge
module load userspace/all

# déplacement sur le répertoire de travail
cd /scratch/$SLURM_JOB_USER/

sh ./segmentation/run_freesurfer.sh $1
