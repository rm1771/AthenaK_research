#!/bin/bash
# CASE 6: v=0 (no wind), rho=0.1*rho_peak (dense background)

#SBATCH --job-name=Torus_case6
#SBATCH --nodes=1
#SBATCH --ntasks=2
#SBATCH --mem=100gb
#SBATCH --time=240:00:00
#SBATCH --partition=gpu_standard
#SBATCH --gres=gpu:volta:2
#SBATCH --account=chanc
#SBATCH --mail-type=ALL
#SBATCH --mail-user=ramadithya1771@arizona.edu
#SBATCH --output=athena_case6.out
#SBATCH --error=athena_case6.err
#SBATCH --verbose

# Load CUDA module
module load cuda11/11.8

# Navigate to run directory (create if it doesn't exist)
mkdir -p /xdisk/chanc/ram/outputs/case6
cd /xdisk/chanc/ram/outputs/case6

date
echo "Starting CASE 6: v=0, rho=0.1*rho_peak..."

srun -n 2 /xdisk/chanc/ram/AthenaK_research/gpu/puma/volta70/build-gpu-torus-mad-volta70/src/athena \
    -i /xdisk/chanc/ram/AthenaK_research/inputs/grmhd/gr_fm_torus_mad_long_case6.athinput

echo "Simulation completed."
date
