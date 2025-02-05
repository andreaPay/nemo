# nemo
MR data analyses for bipolar disorder

## Segmentation
All these shell scripts use the Singularity container of FreeSurfer 7.4.0
Please make sure to adapt the paths inside each bash script to your own disk configuration !

To run freesurfer :
- On all new cases : sh run_freesurfer_newcases.sh
- On a single case (batch mode) : sbatch ./run_freesurfer.slurm SUBJECT
- On a single case (interactive mode) : sh ./run_freesurfer.sh SUBJECT

To run a specific freesurfer command on interactive mode, adapt the script run_freesurfer_t2.sh

To run any command (interactive or batch) on a group of subjects, adapt the script run_loop.sh

## Quality Control
Please make sure to adapt the paths in the config.py file to your own disk configuration before using one of these scripts !

## Statistics


