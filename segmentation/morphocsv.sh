#!/bin/bash
###########################################################
# Execute any FreeSurfer command using Singularity
# Usage: ./run_freesurfer_usefull_commands.sh <subject_id>
###########################################################

# Set the path to config.py
CONFIG_FILE="./config.py"
# Read paths from config.py and export them as environment variables
eval $(PYTHONPATH=$CONFIG_DIR python3 -c 'import config; config.print_paths()')

export SUBJECTS_DIR=$DIR_INPUTS
echo $SUBJECTS_DIR
export FREESURFER_DIR=$DIR_FREESURFER
echo $FREESURFER_DIR

## Extract aseg volumes (subcortical structures)
singularity exec -B $FREESURFER_DIR/outputs:/output -B $FREESURFER_DIR/license:/license \
  --env FS_LICENSE=/license/license.txt /scratch/lhashimoto/freesurfer-7.4.1.sif \
  bash -c "source /usr/local/freesurfer/SetUpFreeSurfer.sh && \
  asegstats2table --subjects $1 --statsfile /output/$1/stats/aseg.stats --tablefile /output/$1/stats/aseg_volumes.csv"

## Extract cortical thickness (left hemisphere)
singularity exec -B $FREESURFER_DIR/outputs:/output -B $FREESURFER_DIR/license:/license \
  --env FS_LICENSE=/license/license.txt /scratch/lhashimoto/freesurfer-7.4.1.sif \
  bash -c "source /usr/local/freesurfer/SetUpFreeSurfer.sh && \
  aparcstats2table --subjects $1 --hemi lh --meas thickness --tablefile /output/$1/stats/lh_thickness.csv"

## Extract cortical thickness (right hemisphere)
singularity exec -B $FREESURFER_DIR/outputs:/output -B $FREESURFER_DIR/license:/license \
  --env FS_LICENSE=/license/license.txt /scratch/lhashimoto/freesurfer-7.4.1.sif \
  bash -c "source /usr/local/freesurfer/SetUpFreeSurfer.sh && \
  aparcstats2table --subjects $1 --hemi rh --meas thickness --tablefile /output/$1/stats/rh_thickness.csv"

## Extract cortical surface area (left hemisphere)
singularity exec -B $FREESURFER_DIR/outputs:/output -B $FREESURFER_DIR/license:/license \
  --env FS_LICENSE=/license/license.txt /scratch/lhashimoto/freesurfer-7.4.1.sif \
  bash -c "source /usr/local/freesurfer/SetUpFreeSurfer.sh && \
  aparcstats2table --subjects $1 --hemi lh --meas area --tablefile /output/$1/stats/lh_area.csv"

## Extract cortical surface area (right hemisphere)
singularity exec -B $FREESURFER_DIR/outputs:/output -B $FREESURFER_DIR/license:/license \
  --env FS_LICENSE=/license/license.txt /scratch/lhashimoto/freesurfer-7.4.1.sif \
  bash -c "source /usr/local/freesurfer/SetUpFreeSurfer.sh && \
  aparcstats2table --subjects $1 --hemi rh --meas area --tablefile /output/$1/stats/rh_area.csv"

## Extract cortical curvature (left hemisphere)
singularity exec -B $FREESURFER_DIR/outputs:/output -B $FREESURFER_DIR/license:/license \
  --env FS_LICENSE=/license/license.txt /scratch/lhashimoto/freesurfer-7.4.1.sif \
  bash -c "source /usr/local/freesurfer/SetUpFreeSurfer.sh && \
  aparcstats2table --subjects $1 --hemi lh --meas curv --tablefile /output/$1/stats/lh_curv.csv"

## Extract cortical curvature (right hemisphere)
singularity exec -B $FREESURFER_DIR/outputs:/output -B $FREESURFER_DIR/license:/license \
  --env FS_LICENSE=/license/license.txt /scratch/lhashimoto/freesurfer-7.4.1.sif \
  bash -c "source /usr/local/freesurfer/SetUpFreeSurfer.sh && \
  aparcstats2table --subjects $1 --hemi rh --meas curv --tablefile /output/$1/stats/rh_curv.csv"
