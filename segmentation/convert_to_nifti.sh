#!/bin/bash
# Script pour executer FreeSurfer via Singularity avec gestion des logs

export SUBJECTS_DIR="/scratch/lhashimoto/nemo_database/imaging_data"
echo $SUBJECTS_DIR
export FREESURFER_DIR="/scratch/lhashimoto/freesurfer"
echo $FREESURFER_DIR

# Dossier source contenant les fichiers .mgz
input_dir="/output/$1/mri"

# Exécute la boucle dans le conteneur Singularity
singularity exec -B $FREESURFER_DIR/outputs:/output -B $FREESURFER_DIR/license:/license --env FS_LICENSE=/license/license.txt /scratch/lhashimoto/freesurfer-7.4.1.sif bash -c "source /usr/local/freesurfer/SetUpFreeSurfer.sh && 
  for file in $input_dir/*.mgz; do
    if [ -f \"\$file\" ]; then
      output_file=\"\${file%.mgz}.nii.gz\"
	  if [ ! -f \"\$output_file\" ]; then
        mri_convert \"\$file\" \"\$output_file\"
        echo \"Conversion de \$file en \$output_file\"
	  fi
    fi
  done
"

# Executer une partie du pipeline seulement
#singularity exec -B $FREESURFER_DIR/outputs:/output -B $FREESURFER_DIR/license:/license --env FS_LICENSE=/license/license.txt /scratch/lhashimoto/freesurfer-7.4.1.sif bash -c "source /usr/local/freesurfer/SetUpFreeSurfer.sh && mri_convert /output/$1/mri/brainmask.mgz /output/$1/mri/brainmask.nii.gz"
#singularity exec -B $FREESURFER_DIR/outputs:/output -B $FREESURFER_DIR/license:/license --env FS_LICENSE=/license/license.txt /scratch/lhashimoto/freesurfer-7.4.1.sif bash -c "source /usr/local/freesurfer/SetUpFreeSurfer.sh && mri_convert /output/$1/mri/T1.mgz /output/$1/mri/T1.nii.gz"
