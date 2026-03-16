#!/bin/bash
# CASE 4: vz=0.1c (wind aligned with jet), rho_default (near-vacuum background)

#SBATCH --job-name=Torus_case4
#SBATCH --nodes=1
#SBATCH --ntasks=2
#SBATCH --mem=100gb
#SBATCH --time=240:00:00
#SBATCH --partition=gpu_standard
#SBATCH --gres=gpu:volta:2
#SBATCH --account=chanc
#SBATCH --mail-type=ALL
#SBATCH --mail-user=ramadithya1771@arizona.edu
#SBATCH --output=athena_case4.out
#SBATCH --error=athena_case4.err
#SBATCH --verbose

# Load CUDA module
module load cuda11/11.8

# Navigate to run directory (create if it doesn't exist)
mkdir -p /xdisk/chanc/ram/outputs/case4
cd /xdisk/chanc/ram/outputs/case4

date
echo "Starting CASE 4: vz=0.1c, rho_default..."

srun -n 2 /xdisk/chanc/home/ram/athenak/gpu/puma/volta70/build-gpu-torus-mad-volta70/src/athena \
    -i /xdisk/chanc/home/ram/athenak/inputs/grmhd/gr_fm_torus_mad_long_case4.athinput

echo "Simulation completed."
date
