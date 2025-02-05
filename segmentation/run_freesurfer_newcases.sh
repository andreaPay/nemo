#!/bin/bash

input_dir = /scratch/lhashimoto/nemo_database/imaging_data
output_dir = /scratch/lhashimoto/freesurfer/outputs
input_list=$(ls -d $input_dir/sub*)

cd /scratch/lhashimoto
for s in $input_list
do
    # Vérifier si le sujet a déjà été traité
    if [ -d "$output_dir/$s" ]; then
        echo "Skipping subject already processed: $s"
    else
		echo "Processing subject: $s"
		sbatch ./run_freesurfer.slurm $s
		echo ""
		echo ""
	fi
done