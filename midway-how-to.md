# Using Midway, the University of Chicago Computing Cluster

Before you ask a question, check out the wonderful resources compiled by the University of Chicago RCC Computing team [here](https://rcc.uchicago.edu/docs/using-midway/index.html). It is likely they may have already addressed your question -- or, if not, you can email them directly.

Their user guide is available [here](https://rcc.uchicago.edu/docs/).

First, request an account [here](https://rcc.uchicago.edu/accounts-allocations/request-account) using the PI Account name "pi-cbrook".

Next, follow these instructions for a quick-start 'step-by-step' 'how-to' after you have established a Midway account (note that all of these assume your account name is 'cbrook'):

1. Open Terminal and ssh into Midway: 

	ssh cbrook@midway2.rcc.uchicago.edu	 
	
Password is your cnet ID password with two-factor authentication.

2. Then, to copy the scripts you want to run from your local computer to the remote server. 	
	- Open a new (second) Terminal window to look at your computer (aka localdirectory) (cmd button + n)
	- Use 'ls' to see files and 'cd' to  move up in the directories to the folder you want or "cd -" to go down one or "cd~" to go down to the base
	- For example, cd Documents/R/R_repositories/brooklab-resources/
	- Navigate to the folder where the folder or file you want to transfer is. I stayed in 'brooklab-resources' because that contains the folder 'midway-test' which has the R scripts I want to run.
	- To transfer 'midway-test' to Midway (remote server), while in the Terminal window for your local computer and in the folder which the folder you want to transfer is in, type:

           scp -r midway-test cbrook@midway2.rcc.uchicago.edu:

	- Password will be your cnet ID password with two-factor authentication.
	- If you are transferring big data files (e.g. sequencing files) you will likely need another method. Details on data transfer are available on the Midway resources website.
	
3. Now, in your terminal window on Midway "cd" into the 'midway-test' folder, load R, and run the script:

```
module load R
Rscript midway-test.R
```

After a few seconds, type "ls". You should see that a "test-plot.png" plot file has appeared. That's great! Now delete it with the command.

```
rm -rf *png
```

The * means delete ALL of the png files in this folder. If you had several but only wanted to delete one, you could type the full name to specify:

```
rm -rf test-plot.png
```


4. Most of the time, however, you will not want to work directly with scripts on Midway. To make a SLURM script to schedule your job to run while you are not on Midway watching it, follow these directions:
	- After you have copied the script from your local directory to Midway (see step #2)...
	- Go to your Midway Terminal window and cd into the folder you just transferred. Type "ls" to see all your scripts and data there.
	- Now, make a SLURM script on vi/vim text editor	
	- To do this, in the Midway terminal window type: vim NameOfSLURMScript.sh
	- This opens your new SLURM script in the vim text editor window. Here, call it "test.sh"
	- type “i” to insert
	- paste in your SLURM directions (see below in step #5)
	- esc to escape from insert mode
	- :w to save
	- :x to exit and save 
	
5. There are [great directions](https://rcc.uchicago.edu/docs/running-jobs/index.html) for setting up your SLURM script on the Midway website. Visit there to learn more about what each entry tells the server. Here is what an example SLURM to run your "midway-test.R" file might look like:

```
#!/bin/bash
#SBATCH --job-name=midway-test
#SBATCH --account=pi-cbrook
#SBATCH --partition=broadwl
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --ntasks=1
#SBATCH --time=01:00:00

module load R

Rscript midway-test.R
```
For most jobs, you will allocate more time than 1 hour. This is the power of the computing cluster -- you can run multiple jobs that take 24+ hours all at once.

6. After making your SLURM script, you can run it with the following command:

```
	sbatch test.sh
```
 Or whatever you named your ".sh" file.
 
7. Helpful commands:
  - to check the entire queue: squeue
  - to check your spot in queue: squeue -u cbrook
  - to check what programs and packages are avaialble on Midway to load: module avail

8. To move output files on Midway into a folder on Midwy after job has finished:
 
	mv /home/cbrook/midway-test/*png /home/cbrook/out
	
	- the asterisk allows us to get all the png files and move them together.
	
	- or, to copy them instead of moving:
  cp /home/cbrook/midway-test/*png /home/cbrook/out
	
9. To copy your folder of results from Midway to local computer: 
- Go to a new window to look at your own computer in terminal and navigate to the folder you want to transfer the files to, then recursively copy (-r) which allows you to copy all the files in a directory. The (.) stands for “this directory” allowing us to copy the directory to the directory on the laptop we navigated to rather than having to type it all out:
	
	   scp -r cbrook@midway2.rcc.uchicago.edu:/home/cbrook/out/*png .

Try the above and download the "test-plot.png" folder into your local repository.

10. To delete a directory (folder) recursively (remove all folders/files inside too) 	without having to approve each deletion (note: risky!):
	rm -rf nameofdirectory

11. To submit many scripts at once as just one job to the scheduler (i.e. you have 10 Rscripts that run different models), see [here](https://rcc.uchicago.edu/docs/running-jobs/array/index.html).

12. Note that you can use the "scratch-midway/cbrook" platform instead of "home-cbrook" for large files (i.e. sequencing data).
