# Setting Up git, GitHub and RStudio

Follow these instructions to connect git, GitHub and RStudio, and clone your first repository.
Note: These instructions are for macOS. If you have a PC, follow other instructions in the brooklab-resource page.

If you've already cloned the repository, but are having trouble connecting your local repository to git and RStudio 
or having trouble with authentication, and if you haven't made any major changes to the repository, 
delete the repository locally before going forward. 

1. **Install git with homebrew** [linked here](https://formulae.brew.sh/formula/git ).

	- Install [homebrew](https://brew.sh/). Homebrew is a software management system that helps with package installations on MacOS and Linux.
	- See if you already have git: 
	```
git --version
```
	- Install git
		```
brew install git
```
	- Tell git your GitHub username and email:
		```
git config --global user.name {your username in quotes}
git config --global user.email {your email in quotes}
```
	

2. **In RStudio**: Make a new SSH key pairing directly in RStudio (Tools —> Global Options —> Git —> make note of whether it’s ed_25519 or id_rsa
	- Another option is to create a key in the terminal, but it’s more confusing and error prone
	- Make sure your file pathway to git is where it actually is on your computer)
		- Check the location of git on your local computer using the terminal: 
				```
which git
```
		- And then, the corresponding directory within RStudio for git (this is telling RStudio where to find git)
		My file pathway is /usr/local/bin/git. Some others I've seen are /usr/bin/git
		- Restart RStudio after this point!!
    - Copy the new key
        - copy it in RStudio pop up box OR find the ~/usr/.ssh/id_ed25519 file on your computer and open it in a text editor
        - copy the text from SHA256…all the way through your email
        
      
3. **On Github website**: Add the new SSH key to your Github account
    - Profile —> Settings —> Access —> SSH Keys and GPG Keys
    - Name it something like “Katherine personal laptop”


4. **In the terminal**: follow [these instructions](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/testing-your-ssh-connection) to connect git to the new key you just created: 
    - You might also have to tell the ssh agent what your key is + connect git to git hub in the terminal [(instructions here)](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)
	
	
5. **In RStudio**: Open a new R Project with Version Control
    - File —> New Project —> Version Control—> Git option
    - Take the SSH clone link from the Github repository website (under the green code button, select SSH) + (1) paste that into the popup box in R Studio for “Repository URL” (2) make sure the project directory name is the same as the repository name on Github (3) make sure the project subdirectory is your Developer folder or another file path where you want to save repositories
    - You might need to restart RStudio, but otherwise, it should be good to go!