export SUBJECTS_DIR="/scratch/lhashimoto/nemo_database/imaging_data"
echo $SUBJECTS_DIR
export FREESURFER_DIR="/scratch/lhashimoto/freesurfer"
echo $FREESURFER_DIR

singularity exec -B $SUBJECTS_DIR:/mnt -B $FREESURFER_DIR/outputs:/output -B $FREESURFER_DIR/license:/license --env FS_LICENSE=/license/license.txt /scratch/lhashimoto/freesurfer-7.4.1.sif bash -c "source /usr/local/freesurfer/SetUpFreeSurfer.sh && freeview -v mri/brainmask.mgz mri/wm.mgz:colormap=heat:opacity=0.4:visible=0 -f surf/lh.white:edgecolor=yellow surf/lh.pial:edgecolor=red surf/rh.white:edgecolor=yellow surf/rh.pial:edgecolor=red surf/lh.orig.nofix:visible=0"