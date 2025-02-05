# Auteur: adapted by Lucile Hashimoto (Adalab) from script of Guillaume Auzias
# Date: 2024

import glob
import sys; print('Python %s on %s' % (sys.version, sys.platform))
import os
from config import DIR_INPUTS, FREESURFER_SNAPSHOTS, FREESURFER_OUTPUTS
import nisnap


if __name__ == "__main__":
    freesurfer_outputs = FREESURFER_OUTPUTS
    dir_snapshots = FREESURFER_SNAPSHOTS
    dir_inputs = DIR_INPUTS

    subj_list = glob.glob(os.path.join(freesurfer_outputs, "sub-*"))
    subj_list = [os.path.basename(x) for x in subj_list]

    # check that dir_snapshots exists, else create it
    if not os.path.exists(dir_snapshots):
        os.makedirs(dir_snapshots)

    figsize = {'x': (18, 4), 'y': (18, 4), 'z': (18, 5)}

    for subject in subj_list[:1]:
        print(subject)
        # path_t1_vol = os.path.join(dir_inputs, subject, "ses-01/anat/"+subject+"_ses-01_T1w.nii.gz")
        path_t1_vol = os.path.join(freesurfer_outputs, subject, "mri/T1.nii.gz")
        path_seg = os.path.join(freesurfer_outputs, subject, "mri/brainmask.nii.gz")

        if not os.path.exists(path_seg):
            print(path_seg + " not found, skip!")
        else:
            figure = os.path.join(dir_snapshots, subject + "_contours_on_t1.png")
            if not os.path.exists(figure):
                done = 0
                d_max = 150
                step = 20
                while (done < 1) and (d_max > 20):
                    try:
                        slices = {'x': list(range(30, d_max, step)),
                                  'y': list(range(60, d_max, step)),
                                  'z': list(range(40, d_max, step))}
                        nisnap.plot_segment(
                            path_seg,
                            bg=path_t1_vol,
                            axes='z',
                            slices=slices,
                            figsize=figsize,
                            # opacity=0,
                            samebox=True,
                            # labels=[1],
                            contours=True,
                            savefig=figure,
                        )
                        done = 1
                    except Exception as e:
                        print(e)
                        done=1
                        # d_max = d_max - 20
                        # step = step-5
                        # print("d_max is now set to ", d_max)

