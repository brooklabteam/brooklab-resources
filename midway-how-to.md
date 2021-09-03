# Using Midway, the University of Chicago Computing Cluster

Before you ask a question, check out the wonderful resources compiled by the University of Chicago RCC Computing team [here](https://rcc.uchicago.edu/docs/using-midway/index.html). It is likely they may have already addressed your question -- or, if not, you can email them directly.

There user guide is available [here](https://rcc.uchicago.edu/docs/).

For a quick-start 'step-by-step' 'how-to' after you have established a Midway account (note that all of these assume your account name is 'cbrook'):


1. Open Terminal and ssh into Midway: 

	ssh cbrook@midway2.rcc.uchicago.edu	 #for running jobs
	
Password is your cnet ID password with two-factor authentication.


2. Then, to copy the scripts you want to run from your local computer to the remote server. 	
	- Open a new (second) Terminal window to look at your computer (aka localdirectory) (cmd button + n)
	- Use 'ls' to see files and 'cd' to  move up in the directories to the folder you want or "cd -" to go down one or "cd~" to go down to the base
	— For example, cd Documents/R/R_repositories/brooklab-resources/
	— Navigate to the folder where the folder or file you want to transfer is. I stayed in bat_age_seroprev because that contains the folder 
	   uci_up which has the R scripts I want to run.
	—> To transfer uci_up to Savio (remote server), while in the Terminal window for 	   your local computer and in the folder which the folder you want to transfer is 	   in, type:

           scp -r SavioRun8_19_SANN cbrook@dtn.brc.berkeley.edu:/global/home/users/cbrook/


	—> Password will be your 4-digit pin + Google Authenticator
	-> Notice that the address after the @ sign is different for the data directory 	   than what you entered to run jobs in step #1

3) To make a SLURM script to run your Rscript on Savio: 
	—> After you have copied the script from your local directory to Savio (see step 	   #2)
	—> Go to your Savio Terminal window and cd into the folder you just transferred. 	   You should see all your scripts and data there.
	-> Make sure you are in the program server (@hpc.brc.berkeley.edu), not the data 	   server

	Make a SLURM script on vi/vim text editor	
	-> in Savio terminal window type: vim NameOfSLURMScript.sh
	-> This opens your new SLURM script inls the vim text editor window
	-> type “i” to insert
	—> paste in: 
	-> esc to escape from insert mode
	-> :w to save
	-> :x to exit and save 

4) To run your Rscript:	
	sbatch NameOfSLURMScript.sh
	
	—> to check the entire queue: squeue
	—> to check your spot in queue: squeue -u cbrook
	—> to check jobID #: scontrol

5) To move output files on Savio into a folder on Savio after job has finished:
 
	mv /global/home/users/cbrook/uci_up/*Rdata /global/home/users/cbrook/uci_out

	—> The asterisk allows us to get all the RData files and move them together.

	-> Or, to copy them:

	cp /global/home/users/cbrook/Pter_fits/Pter_refits_lci/combine.fit.Pter.uci.Rdata / /global/home/users/cbrook/Pter_out/
6) To copy your folder of results from Savio to local computer: 
	—> Go to a new window to look at your own computer in terminal and navigate to 		   the folder you want to transfer the files to, then 
	   recursively copy (-r) which allows you to copy all the files in a directory.    	   The (.) stands for “this directory” allowing us to copy the 	directory to the 	   directory on the laptop we navigated to rather than having to type it all out:
	
	   scp -r cbrook@dtn.brc.berkeley.edu:/global/home/users/cbrook/all.dat.Dec2019.Rdata .

7) To delete a directory (folder) recursively (remove all folders/files inside too) 	without having to approve each deletion:
	rm -rf nameofdirectory



8) To submit many scripts at once as just one job to the scheduler (also, see here:http://research-it.berkeley.edu/services/high-performance-computing/user-guide/hthelper-script):
