# Auteur: Lucile Hashimoto (Adalab)
# Date: 2024

import os
import re
import csv
import glob
from config import FREESURFER_STDOUT, DIR_FREESURFER


def extract_info_from_stdout(stdout_file):
    """
    Extrait le nom du sujet et le statut de fin de calcul du fichier stdout
    :param stdout_file:
    :return:
    """
    subject_pattern = re.compile(r"sub-\d+")
    finished_pattern = re.compile(r"finished without error")

    # Lire le fichier
    with open(stdout_file, 'r') as file:
        content = file.read()

    # Extraire le nom du sujet
    subject_match = subject_pattern.search(content)
    subject = subject_match.group(0) if subject_match else "Not found"

    # Vérifier si "finished without error" est présent
    finished_status = "Success" if finished_pattern.search(content) else "Error"

    return subject, finished_status


def process_files_and_generate_csv(stdout_files, output_csv):
    """
    Parcours les fichiers stdout et enregistre les informations dans un fichier CSV
    :param stdout_files:
    :param output_csv:
    :return:
    """
    # Écrire les en-têtes du fichier CSV
    with open(output_csv, 'w', newline='') as csvfile:
        writer = csv.writer(csvfile)
        writer.writerow(["File Name", "Subject", "Finished without error"])

        # Parcourir tous les fichiers stdout
        for stdout_file in stdout_files:
            if os.path.exists(stdout_file):
                subject, finished_status = extract_info_from_stdout(stdout_file)
                # Écrire les informations dans le fichier CSV
                writer.writerow([stdout_file, subject, finished_status])
            else:
                print(f"Le fichier {stdout_file} n'existe pas.")


if __name__ == "__main__":
    # Récupérer tous les fichiers .out dans le dossier /stdout
    stdout_files = glob.glob(os.path.join(FREESURFER_STDOUT, "*.out"))

    output_csv = os.path.join(DIR_FREESURFER, "output.csv")  # Le fichier CSV de sortie

    # Traitement des fichiers et génération du CSV
    process_files_and_generate_csv(stdout_files, output_csv)

    print(f"Les informations ont été enregistrées dans {output_csv}.")
