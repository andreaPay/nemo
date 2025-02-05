# Auteur: Lucile Hashimoto (Adalab)
# Date: 2025

import os
import re
import csv
import glob
import numpy as np
from config import DIR_FREESURFER, FREESURFER_OUTPUTS


def extract_info_from_log(log_file):
    """
    Extrait le statut de fin de calcul du fichier log et d'autres informations
    :param stdout_file:
    :return:
    """
    finished_pattern = re.compile(r"finished without error")
    runtime_pattern = re.compile(r"#@#%# recon-all-run-time-hours (\d+\.\d+)")
    topo_before_pattern_lh = re.compile(r"#@# Fix Topology lh.*?before topology correction, eno=([^\(]+)", re.DOTALL)
    topo_before_pattern_rh = re.compile(r"#@# Fix Topology rh.*?before topology correction, eno=([^\(]+)", re.DOTALL)
    topo_after_pattern_lh = re.compile(r"#@# Fix Topology lh.*?after topology correction, eno=([^\(]+)", re.DOTALL)
    topo_after_pattern_rh = re.compile(r"#@# Fix Topology rh.*?after topology correction, eno=([^\(]+)", re.DOTALL)

    # Lire le fichier
    with open(log_file, 'r') as file:
        log_content = file.read()

    # Vérifier si "finished without error" est présent
    finished_status = "Success" if finished_pattern.search(log_content) else "Error"

    # Extraire le temps de calcul
    runtime_match = runtime_pattern.search(log_content)
    runtime = runtime_match.group(1) if runtime_match else "Not found"

    # Extraire le nombre d'Euler avant correction topologique
    topo_match = topo_before_pattern_lh.search(log_content)
    eno_before_lh = topo_match.group(1) if topo_match else np.nan
    topo_match = topo_before_pattern_rh.search(log_content)
    eno_before_rh = topo_match.group(1) if topo_match else np.nan

    # Extraire le nombre d'Euler après correction topologique
    topo_match = topo_after_pattern_lh.search(log_content)
    eno_after_lh = topo_match.group(1) if topo_match else np.nan
    topo_match = topo_after_pattern_rh.search(log_content)
    eno_after_rh = topo_match.group(1) if topo_match else np.nan

    return finished_status, runtime, eno_before_lh, eno_before_rh, eno_after_lh, eno_after_rh


def count_dirs_in_directory(directory):
    """
    Compte le nombre de répertoires dans un répertoire donné (non récursivement)
    :param directory:
    :return: int
    """
    return sum([1 for item in os.listdir(directory) if os.path.isdir(os.path.join(directory, item))])


def count_files_in_directory(directory):
    """
    Compte le nombre de fichiers dans un répertoire donné
    :param directory:
    :return: int
    """
    return sum([len(files) for _, _, files in os.walk(directory)])


def check_log_and_generate_csv(subj_list, output_csv):
    """
    Parcours les sujets et enregistre les informations dans un fichier CSV
    :param subj_list:
    :param output_csv:
    :return:
    """

    with open(output_csv, 'w', newline='') as csvfile:
        writer = csv.writer(csvfile)

        # Écrire les en-têtes du fichier CSV
        writer.writerow(["Subject",
                         "Number of folders generated",
                         "Number of files generated",
                         "Finished without error",
                         "Processing time (hours)",
                         "Euler number before topo correction LH",
                         "Euler number after topo correction RH",
                         "Euler number before topo correction LH",
                         "Euler number after topo correction RH"])

        # Parcourir tous les fichiers log
        for subj in subj_list:
            log_file = os.path.join(FREESURFER_OUTPUTS, subj, "scripts", "recon-all.log")
            print(log_file)
            if os.path.exists(log_file):
                info = extract_info_from_log(log_file)
                dir_count = count_dirs_in_directory(os.path.join(FREESURFER_OUTPUTS, subj))
                file_count = count_files_in_directory(os.path.join(FREESURFER_OUTPUTS, subj))
                # Écrire les informations dans le fichier CSV
                writer.writerow([subj, dir_count, file_count] + list(info))
            else:
                print(f"Le fichier log pour le sujet {subj} n'existe pas.")


if __name__ == "__main__":
    # Récupérer la liste des sujets dans le dossier outputs
    subj_list = glob.glob(os.path.join(FREESURFER_OUTPUTS, "sub-*"))
    subj_list = [os.path.basename(x) for x in subj_list]

    output_csv = os.path.join(DIR_FREESURFER, "check_log.csv")  # Le fichier CSV de sortie

    # Traitement des fichiers et génération du CSV
    check_log_and_generate_csv(subj_list, output_csv)

    print(f"Les informations ont été enregistrées dans {output_csv}.")
