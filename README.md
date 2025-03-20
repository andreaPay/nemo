# nemo
MR data analyses for bipolar disorder

Please make sure to adapt the paths in the config.py file to your own disk configuration before using one of these scripts !

## Segmentation
Requirements to run the shell scripts:
- Singularity container of FreeSurfer 7.4.0
- Python 3.6+ (used to get config.py file paths)
They have been configured to run on the cluster of the MESOCENTRE, but can be adapted to run on any other cluster.

First steps on MESOCENTRE:
1) module load userspace/all
2) module load python3/3.12.0

To run freesurfer segmentation, use the following commands from the nemo root directory:
- On all new cases : sh run_freesurfer_newcases.sh
- On a single case (batch mode) : sbatch ./run_freesurfer.slurm SUBJECT
- On a single case (interactive mode) : sh ./run_freesurfer.sh SUBJECT

To run a specific freesurfer command on interactive mode, adapt the script run_freesurfer_usefull_commands.sh

To run any command (interactive or batch) on a group of subjects, adapt the script run_loop.sh

## Quality Control

## Statistics


