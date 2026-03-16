#!/bin/bash
# CASE 3: vx=0.1c (wind perpendicular to jet), rho=0.1*rho_peak

#SBATCH --job-name=Torus_case3
#SBATCH --nodes=1
#SBATCH --ntasks=2
#SBATCH --mem=100gb
#SBATCH --time=240:00:00
#SBATCH --partition=gpu_standard
#SBATCH --gres=gpu:volta:2
#SBATCH --account=chanc
#SBATCH --mail-type=ALL
#SBATCH --mail-user=ramadithya1771@arizona.edu
#SBATCH --output=/xdisk/chanc/ram/outputs/case3/athena_case3.out
#SBATCH --error=/xdisk/chanc/ram/outputs/case3/athena_case3.err
#SBATCH --verbose

# Load CUDA module
module load cuda11/11.8

# Navigate to run directory (create if it doesn't exist)
mkdir -p /xdisk/chanc/ram/outputs/case3
cd /xdisk/chanc/ram/outputs/case3

date
echo "Starting CASE 3: vx=0.1c, rho=0.1*rho_peak..."

srun -n 2 /xdisk/chanc/ram/AthenaK_research/gpu/puma/volta70/build-gpu-torus-mad-volta70/src/athena \
    -i /xdisk/chanc/ram/AthenaK_research/inputs/grmhd/gr_fm_torus_mad_long_case3.athinput

echo "Simulation completed."
date
