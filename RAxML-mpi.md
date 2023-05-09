# Running RAxML-mpi on Midway

To install RAxML on the cluster and be a part of your profile so you don't have to load it every time:

vi ~/.bash_profile

i to insert the following lines: 

module load openmpi

module load gcc/10.2.0

export PATH=/project2/cbrook/software/raxml-ng/bin:$PATH

So it should look like this: 

 .bash_profile

 Get the aliases and functions
if [ -f ~/.bashrc ]; then
        . ~/.bashrc
fi

 User specific environment and startup programs

PATH=$PATH:$HOME/bin

export PATH
module load openmpi
module load gcc/10.2.0
export PATH=/project2/cbrook/software/raxml-ng/bin:$PATH
~                                                                               
~                                                                               
~                                                                               
~                                                                               
~                                                                               
~                                                                               
~                                                                               
~                                                                               
"~/.bash_profile" 15L, 276C                                   2,0-1         All



press esc to edit insert mode, then type :wq to save and quit

check it works by requesting version (if it says ‘not found’, didn’t work):
raxml-ng-mpi --version


Below is an example of a SLURM script I ran for a very large (412 genera) 
picornavirus phylogeny, the max time alloted by the cluster (36 hours) was not
enough to finish so I just emailed the cluster to extend the job time to around
96 hours just to be safe: 

```
#!/bin/bash
#SBATCH --job-name=refseq_all_picorna_raxml
#SBATCH --partition=broadwl
#SBATCH --output=refseq_all_picorna_raxml.out
#SBATCH --nodes=1
#SBATCH --ntasks=
#SBATCH --ntasks-per-node=
#SBATCH --time=36:00:00

module load vim/7.4
module load emacs/25.1
module load python/3.6
module load java/1.8.0_121
module load cmake/3.15.1

raxml-ng-mpi --all --msa RAxML_aligned_all_refseq_picornaviruses.fasta --model GTR+G4 --prefix T18  --seed 6 --threads 10 --bs-metric fbp,tbe
```

Note that you need to have matching numbers for the -threads command in RAxML with the --ntasks command
call to SLURM


Great troubleshooting guide: https://github-wiki-see.page/m/amkozlov/raxml-ng/wiki/Tutorial
Note: if raxml-ng stops unexpectedly or does not converge, you may need to manually change internal cutoff value or number of bootstraps. info on how to do so in the link above

