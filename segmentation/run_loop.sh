#!/bin/bash
input_dir = /scratch/lhashimoto/nemo_database/imaging_data
input_list=$(ls -d $input_dir/sub*)

cd /scratch/lhashimoto
for s in $input_list
do
    # Vérifier si le sujet est sub-1054001 ou sub-1054002
    #if [[ "$s" == "sub-1054001" ]]; then
    #if [[ "$s" == "sub-1054001" || "$s" == "sub-1054057" || "$s" == "sub-1054092" ]]; then
    #    echo "Skipping subject: $s"
    #    continue  # Passer à l'itération suivante de la boucle
	
	echo $s
	#sbatch ./run_freesurfer.slurm $s
	#sh nemo_segmentation/convert_to_nifti.sh $s
	cp freesurfer/logs/$s.log freesurfer/outputs/$s/scripts/recon-all.log
	echo ""
	echo ""
	
    #fi
done