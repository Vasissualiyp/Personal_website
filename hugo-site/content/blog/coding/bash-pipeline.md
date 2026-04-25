---
title: "Building a Data Analysis Pipeline with Bash"
date: 2025-10-05
draft: false
author: "Vasilii Pustovoit"
tags: ["bash", "automation", "data analysis"]
summary: "How I automated my simulation data analysis workflow with bash scripts"
---

# Building a Data Analysis Pipeline with Bash

Bash gets a bad rap as "just a scripting language," but it's incredibly powerful for gluing together analysis workflows. Here's how I use it.

## The Problem

I run GIZMO simulations that output hundreds of snapshots. For each snapshot, I need to:

1. Extract relevant particle data
2. Calculate physical quantities
3. Generate plots
4. Update a summary table
5. Archive results

Doing this manually is tedious and error-prone.

## The Solution: A Bash Pipeline

Here's my workflow automation script:

```bash
#!/bin/bash
set -euo pipefail  # Exit on error, undefined vars, pipe failures

SNAPSHOT_DIR="$1"
OUTPUT_DIR="$2"

# Ensure output directory exists
mkdir -p "$OUTPUT_DIR"

# Process each snapshot
for snapshot in "$SNAPSHOT_DIR"/snapshot_*.hdf5; do
    num=$(echo "$snapshot" | grep -oP 'snapshot_\K\d+')
    
    echo "Processing snapshot $num..."
    
    # Extract data (Python script)
    python3 extract_data.py "$snapshot" "$OUTPUT_DIR/data_${num}.csv"
    
    # Calculate derived quantities
    python3 calculate_properties.py "$OUTPUT_DIR/data_${num}.csv" \
        "$OUTPUT_DIR/properties_${num}.csv"
    
    # Generate plots
    python3 plot_snapshot.py "$OUTPUT_DIR/properties_${num}.csv" \
        "$OUTPUT_DIR/plots/snapshot_${num}.png"
    
    # Update summary
    awk -v num="$num" 'NR==2 {print num,$3,$5,$7}' \
        "$OUTPUT_DIR/properties_${num}.csv" \
        >> "$OUTPUT_DIR/summary.dat"
done

# Create final summary plot
python3 plot_evolution.py "$OUTPUT_DIR/summary.dat" \
    "$OUTPUT_DIR/evolution.png"

echo "Analysis complete!"
```

## Bash Features I Use Constantly

### 1. Error Handling
```bash
set -euo pipefail
```
This line is crucial - it makes your script fail fast instead of silently continuing with errors.

### 2. Parallel Processing
Process multiple snapshots at once:

```bash
parallel -j 8 process_snapshot.sh {} ::: snapshot_*.hdf5
```

GNU parallel is amazing for embarrassingly parallel tasks.

### 3. Conditional Execution
```bash
# Only regenerate if source is newer
if [ "$source" -nt "$output" ]; then
    python3 process.py "$source" "$output"
fi
```

### 4. Logging
```bash
exec 1> >(tee -a analysis.log)
exec 2>&1

echo "Started at $(date)"
# Your code here
echo "Finished at $(date)"
```

All output goes to both terminal and log file.

### 5. Cleanup on Exit
```bash
cleanup() {
    rm -f /tmp/analysis_$$_*
}
trap cleanup EXIT
```

Ensures temporary files are deleted even if script fails.

## Integration with SLURM

On our compute cluster, I wrap this in a SLURM submission script:

```bash
#!/bin/bash
#SBATCH --job-name=analyze
#SBATCH --time=24:00:00
#SBATCH --cpus-per-task=8
#SBATCH --mem=32G

module load python/3.9
module load hdf5

./analyze_pipeline.sh /scratch/snapshots /scratch/results
```

## Benefits

- **Reproducible**: Same commands every time
- **Documented**: The script IS the documentation
- **Traceable**: Logs show exactly what happened
- **Efficient**: Parallel processing saves hours

## When NOT to Use Bash

Bash is great for orchestration, but bad for:
- Complex logic with many conditionals
- Numerical computation
- Data structures beyond arrays
- Anything requiring maintainability by others

For those cases, use Python with `subprocess` module.

## Resources

- [Google Shell Style Guide](https://google.github.io/styleguide/shellguide.html)
- [ShellCheck](https://www.shellcheck.net/) - catches common bugs
- `man bash` - surprisingly readable

Bash isn't sexy, but it gets the job done!
