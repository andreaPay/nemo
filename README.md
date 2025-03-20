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
Requirements:
- fsqc toolbox (https://github.com/Deep-MI/fsqc)
This package provides quality assurance / quality control scripts for FastSurfer- or FreeSurfer-processed structural MRI data. It will check outputs of these two software packages by means of quantitative and visual summaries. Prior processing of data using either FastSurfer or FreeSurfer is required, i.e. the software cannot be used on raw images.

To run the quality control, use the following commands from the nemo root directory:
1) python3 -m ./qc/check_log.py

This script will check the log files of the freesurfer segmentation and generate a csv file with segmentation errors and stats.
- Subject
- Number of folders generated
- Number of files generated
- Finished without error
- Processing time (hours)
- Euler number before topo correction LH
- Euler number after topo correction RH
- Euler number before topo correction LH
- Euler number after topo correction RH

2) python3 -m ./qc/qc_fsqc.py

Three configurations are available. Choose the one you want to use by uncommenting the corresponding lines in the qc_fsqc.py file.
- Run FSQC on a single subject
- Run FSQC on a group of subjects
- Run FSQC only on hippocampus and amygdala segmentations

This script will generate a report for each subject and a csv file for group statistics name 'fsqc-results.csv'.

3) python3 -m ./qc/qc_complete.py

This script will recompute the group statistics of aparc and aseg segmentations after normalization of volumes by ETIV.
A new aseg_stats_norm.csv is saved for each subject.
The number of outliers is updated and all QC statistics are merged and saved in the fsqc-results-complete.csv file.

## Statistics


