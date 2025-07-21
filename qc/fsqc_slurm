#!/bin/bash
#SBATCH -J fsqc
#SBATCH -p skylake
#SBATCH -n 1
#SBATCH -t 9:00:00
#SBATCH --mail-type=BEGIN,END
#SBATCH --mail-user=andrea.paysserand@univ-amu.fr

conda activate nemo
python /scratch/apaysserand/code/nemo/qc/qc_fsqc.py
