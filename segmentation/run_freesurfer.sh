#!/bin/bash
# Script pour executer FreeSurfer via Singularity avec gestion des logs

export SUBJECTS_DIR="/scratch/lhashimoto/nemo_database/imaging_data"
echo $SUBJECTS_DIR
export FREESURFER_DIR="/scratch/lhashimoto/freesurfer"
echo $FREESURFER_DIR

# Creer les repertoires si necessaire
mkdir -p $FREESURFER_DIR
mkdir -p $FREESURFER_DIR/outputs

# Remove existing subject folder
rm -r $FREESURFER_DIR/outputs/$1

# Executer le conteneur avec Singularity
singularity exec -B $SUBJECTS_DIR:/mnt -B $FREESURFER_DIR/outputs:/output -B $FREESURFER_DIR/license:/license --env FS_LICENSE=/license/license.txt /scratch/lhashimoto/freesurfer-7.4.1.sif bash -c "source /usr/local/freesurfer/SetUpFreeSurfer.sh && recon-all -all -s $1 -i /mnt/$1/ses-01/anat/$1_ses-01_T1w.nii.gz -T2 /mnt/$1/ses-01/anat/$1_ses-01_T2w.nii.gz -T2pial -sd /output"