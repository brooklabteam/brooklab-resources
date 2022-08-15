# Running RAxML-mpi on Midway

To install RAxML on the cluster:

module load openmpi/3.0.0+gcc-10.1.0
export PATH=/project2/cbrook/software/raxml-ng/bin:$PATH

check it works by requesting version (if it says ‘not found’, didn’t work):
raxml-ng-mpi --version

If this is not incorporated into the SLURM script, you will have to do the
above step every time you need to use RAxML on the cluster. 

Below is an example of a SLURM script I ran for a very large (412 genera) 
picornavirus phylogeny, the max time alloted by the cluster (36 hours) was not
enough to finish so I just emailed the cluster to extend the job time to around
96 hours just to be safe: 

```
#!/bin/bash
#SBATCH --job-name=RAxML-picorna
#SBATCH --partition=broadwl
#SBATCH --output=RAxML_picorna.out
#SBATCH --ntasks=13
#SBATCH --time=36:00:00

module load vim/7.4
module load emacs/25.1
module load python/3.6
module load java/1.8.0_121
module load cmake/3.15.1

module load openmpi/3.0.0+gcc-10.1.0
export PATH=/project2/cbrook/software/raxml-ng/bin:$PATH

raxml-ng-mpi --all --msa RAxML_alignment_fullgenomePicornas.fasta --model TVM+G4 --prefix T3  --seed 12 --threads 13 --bs-metric fbp,tb
```

Note that you need to have matching numbers for the -threads command in RAxML with the --ntasks command
call to SLURM

