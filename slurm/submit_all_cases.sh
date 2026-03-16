#!/bin/bash
# Submit all 6 cases sequentially on Puma Volta V100
# Each job waits for the previous one to finish before starting.
# Run this script from the repo root: bash slurm/submit_all_cases.sh

# Create output directories first (SLURM needs them to exist for log files)
for i in 1 2 3 4 5 6; do
  mkdir -p /xdisk/chanc/ram/outputs/case${i}
done
echo "Output directories created."

J1=$(sbatch --parsable slurm/run_case1_puma_volta.sh)
echo "Submitted CASE 1: job $J1"

J2=$(sbatch --parsable --dependency=afterok:$J1 slurm/run_case2_puma_volta.sh)
echo "Submitted CASE 2: job $J2 (depends on $J1)"

J3=$(sbatch --parsable --dependency=afterok:$J2 slurm/run_case3_puma_volta.sh)
echo "Submitted CASE 3: job $J3 (depends on $J2)"

J4=$(sbatch --parsable --dependency=afterok:$J3 slurm/run_case4_puma_volta.sh)
echo "Submitted CASE 4: job $J4 (depends on $J3)"

J5=$(sbatch --parsable --dependency=afterok:$J4 slurm/run_case5_puma_volta.sh)
echo "Submitted CASE 5: job $J5 (depends on $J4)"

J6=$(sbatch --parsable --dependency=afterok:$J5 slurm/run_case6_puma_volta.sh)
echo "Submitted CASE 6: job $J6 (depends on $J5)"

echo ""
echo "All 6 cases submitted. Chain: $J1 -> $J2 -> $J3 -> $J4 -> $J5 -> $J6"
echo "Monitor with: squeue -u $USER"
