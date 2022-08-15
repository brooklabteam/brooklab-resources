# Running modeltest-ng on Midway

Sophia got the RCC team at Midway to install modestest-ng (see https://github.com/ddarriba/modeltest)
In a conda environment for our lab. In order to run this script to test different substitution models on your alignment data, structure your SLURM script something like this:



```
#!/bin/bash
#SBATCH --job-name=modeltest
#SBATCH --account=pi-cbrook
#SBATCH --partition=broadwl
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=8
#SBATCH --ntasks=8
#SBATCH --time=36:00:00

module load python
conda activate /project2/cbrook/software/modeltest_env

modeltest-ng -i /home/cbrook/ncov-mada/mada_ncov_align.fasta -d nt -t ml -p 8
```

Note that you probably don't actually need 36 hours (most alignments will run within 12). Also note that you need to have matching numbers for the -p (parse) command in the modestest call and for the -ntasks and -ntasks-per-node call to SLURM

