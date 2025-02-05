#!/bin/bash
# Script pour executer la 3e partir autorecon3 de FreeSurfer avec la T2

export SUBJECTS_DIR="/scratch/lhashimoto/nemo_database/imaging_data"
echo $SUBJECTS_DIR
export FREESURFER_DIR="/scratch/lhashimoto/freesurfer"
echo $FREESURFER_DIR

# reconstruct surfaces using T2
#singularity exec -B $SUBJECTS_DIR:/mnt -B $FREESURFER_DIR/outputs:/output -B $FREESURFER_DIR/license:/license --env FS_LICENSE=/license/license.txt /scratch/lhashimoto/freesurfer-7.4.1.sif bash -c "source /usr/local/freesurfer/SetUpFreeSurfer.sh && recon-all -s $1 -T2 /mnt/$1/ses-01/anat/$1_ses-01_T2w.nii.gz -T2pial -autorecon3 -sd /output"

# hippo-amygdala segmentation using PYTHON version beta
#singularity exec -B $SUBJECTS_DIR:/mnt -B $FREESURFER_DIR/outputs:/output -B $FREESURFER_DIR/license:/license --env FS_LICENSE=/license/license.txt /scratch/lhashimoto/freesurfer-7.4.1.sif bash -c "source /usr/local/freesurfer/SetUpFreeSurfer.sh && segment_subregions hippo-amygdala --sd /output --cross $1"

# hippo-amygdala segmentation using MATLAB RUNTIME
# Installation du runtime
#singularity exec -B $SUBJECTS_DIR:/mnt -B $FREESURFER_DIR/outputs:/output -B $FREESURFER_DIR/license:/license --env FS_LICENSE=/license/license.txt /scratch/lhashimoto/freesurfer-7.4.1.sif bash -c "source /usr/local/freesurfer/SetUpFreeSurfer.sh && fs_install_mcr R2019b"
#singularity exec -B $SUBJECTS_DIR:/mnt -B $FREESURFER_DIR/outputs:/output -B $FREESURFER_DIR/license:/license --env FS_LICENSE=/license/license.txt /scratch/lhashimoto/freesurfer-7.4.1.sif bash -c "source /usr/local/freesurfer/SetUpFreeSurfer.sh && segmentHA_T1.sh $1 --sd /output"