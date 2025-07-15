DIR_INPUTS = "/scratch/lhashimoto/nemo_database/imaging_data"
DIR_FREESURFER = [
    "/scratch/apaysserand/freesurfer",
    "/scratch/lhashimoto/freesurfer"
]
FREESURFER_STDOUT = [d + "/stdout" for d in DIR_FREESURFER]
FREESURFER_OUTPUTS = [d + "/outputs" for d in DIR_FREESURFER]
FREESURFER_FSQC = [d + "/fsqc" for d in DIR_FREESURFER]

def print_paths():
    """
    Print paths to have access to them in a shell script
    """
    for i, d in enumerate(DIR_FREESURFER):
        print(f"DIR_FREESURFER_{i}={d}")
        print(f"FREESURFER_STDOUT_{i}={FREESURFER_STDOUT[i]}")
        print(f"FREESURFER_OUTPUTS_{i}={FREESURFER_OUTPUTS[i]}")
        print(f"FREESURFER_FSQC_{i}={FREESURFER_FSQC[i]}")

if __name__ == "__main__":
    print_paths()
