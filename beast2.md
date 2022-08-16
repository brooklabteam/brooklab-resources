# Running BEAST 2 on Midway

All versions of BEAST are already available and installed on Midway! So, you just have to load the correct modules in your SLURM script to run this program, including the version that calls the Beagle library. Note that with BEAST 2 it is possible to extend a job after it has timed out by simply "resuming" the run from the last MCMC chain. So you can ask for 36 hours on Midway but then just start it again from where it left off if that is not enough time.

Here is an example SLURM script: 


```

#!/bin/bash
#SBATCH --job-name=beasttree
#SBATCH --account=pi-cbrook
#SBATCH --partition=broadwl
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=8
#SBATCH --ntasks=8
#SBATCH --time=36:00:00

module load midway2
module load java/1.8
module load cuda/8.0
module load beagle/trunk
module load beast/2.6.2

beast -beagle_CPU -seed 777 /home/cbrook/ncov-mada/beast/mada_ncov.xml

```



