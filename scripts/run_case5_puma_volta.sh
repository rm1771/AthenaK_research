#!/bin/bash
# CASE 5: vx=0.1c (wind perpendicular to jet), rho_default (near-vacuum background)

#SBATCH --job-name=Torus_case5
#SBATCH --nodes=1
#SBATCH --ntasks=5
#SBATCH --mem=100gb
#SBATCH --time=240:00:00
#SBATCH --partition=gpu_standard
#SBATCH --gres=gpu:volta:1
#SBATCH --account=chanc
#SBATCH --mail-type=ALL
#SBATCH --mail-user=ramadithya1771@arizona.edu
#SBATCH --output=athena_case5.out
#SBATCH --error=athena_case5.err
#SBATCH --verbose

# Load CUDA module
module load cuda11/11.8

# Navigate to run directory (create if it doesn't exist)
mkdir -p /xdisk/chanc/home/ram/athenak/runs/case5
cd /xdisk/chanc/home/ram/athenak/runs/case5

date
echo "Starting CASE 5: vx=0.1c, rho_default..."

/xdisk/chanc/home/ram/athenak/gpu/puma/volta70/build-gpu-torus-mad-volta70/src/athena \
    -i /xdisk/chanc/home/ram/athenak/inputs/grmhd/gr_fm_torus_mad_long_case5.athinput

echo "Simulation completed."
date
