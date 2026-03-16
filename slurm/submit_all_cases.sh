#!/bin/bash
# Submit 6 cases in pairs on Puma Volta V100 (2 GPUs each, 4 GPU group limit)
# Pair 1 (cases 1+2) runs immediately
# Pair 2 (cases 3+4) starts after both cases 1 and 2 finish
# Pair 3 (cases 5+6) starts after both cases 3 and 4 finish
# Run this script from the repo root: bash slurm/submit_all_cases.sh

# Create output directories first (SLURM needs them to exist for log files)
for i in 1 2 3 4 5 6; do
  mkdir -p /xdisk/chanc/ram/outputs/case${i}
done
echo "Output directories created."

# Pair 1: run immediately
J1=$(sbatch --parsable slurm/run_case1_puma_volta.sh)
echo "Submitted CASE 1: job $J1"

J2=$(sbatch --parsable slurm/run_case2_puma_volta.sh)
echo "Submitted CASE 2: job $J2"

# Pair 2: start after both J1 and J2 finish
J3=$(sbatch --parsable --dependency=afterok:$J1:$J2 slurm/run_case3_puma_volta.sh)
echo "Submitted CASE 3: job $J3 (depends on $J1,$J2)"

J4=$(sbatch --parsable --dependency=afterok:$J1:$J2 slurm/run_case4_puma_volta.sh)
echo "Submitted CASE 4: job $J4 (depends on $J1,$J2)"

# Pair 3: start after both J3 and J4 finish
J5=$(sbatch --parsable --dependency=afterok:$J3:$J4 slurm/run_case5_puma_volta.sh)
echo "Submitted CASE 5: job $J5 (depends on $J3,$J4)"

J6=$(sbatch --parsable --dependency=afterok:$J3:$J4 slurm/run_case6_puma_volta.sh)
echo "Submitted CASE 6: job $J6 (depends on $J3,$J4)"

echo ""
echo "All 6 cases submitted."
echo "Pair 1: $J1, $J2"
echo "Pair 2: $J3, $J4  (after pair 1)"
echo "Pair 3: $J5, $J6  (after pair 2)"
echo "Monitor with: squeue -u $USER"
