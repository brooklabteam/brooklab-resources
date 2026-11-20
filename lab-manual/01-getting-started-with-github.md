# Getting Started with GitHub (and Linking It to RStudio)

Welcome to the Brook Lab! Most of our code, data-analysis scripts, and manuscripts-in-progress live on GitHub under the [**brooklabteam**](https://github.com/brooklabteam) organization. This guide assumes you have **never used Git or GitHub before**. By the end you will be able to:

1. Understand what Git and GitHub are (and how they differ)
2. Make a GitHub account and join the lab organization
3. Install Git on your computer
4. Connect Git and GitHub to RStudio
5. Clone a lab repository, make changes, and push them back
6. Follow a few lab conventions that keep everyone's work safe
7. Do a test run by making your own `welcome-<name>` repo

Budget about **1–2 hours** for the first-time setup. If you get stuck, ask in the lab Slack or grab another lab member — everyone has fought with this at least once.

---

## Contents

- [Part 1: Key concepts](#part-1-key-concepts)
- [Part 2: Create a GitHub account and join the lab](#part-2-create-a-github-account-and-join-the-lab)
- [Part 3: Install Git, R, and RStudio](#part-3-install-git-r-and-rstudio)
- [Part 4: Introduce yourself to Git](#part-4-introduce-yourself-to-git)
- [Part 5: Link GitHub to RStudio (authentication)](#part-5-link-github-to-rstudio-authentication)
- [Part 6: Clone a repository into an RStudio project](#part-6-clone-a-repository-into-an-rstudio-project)
- [Part 7: The everyday workflow — pull, commit, push](#part-7-the-everyday-workflow--pull-commit-push)
- [Part 8: Starting a brand-new project](#part-8-starting-a-brand-new-project)
- [Part 9: Lab conventions](#part-9-lab-conventions)
- [Part 10: Test run — make your welcome repo](#part-10-test-run--make-your-welcome-repo)
- [Troubleshooting](#troubleshooting)
- [Further reading](#further-reading)

---

## Part 1: Key concepts

| Term | What it means |
|---|---|
| **Git** | Free software that runs **on your computer** and tracks every change you make to files in a folder. Think "Track Changes" for an entire project. |
| **GitHub** | A **website** that hosts copies of Git-tracked folders online so you can back them up, share them, and collaborate. |
| **Repository ("repo")** | A project folder tracked by Git. Each paper or analysis usually gets its own repo. |
| **Clone** | Download a copy of a repo from GitHub to your computer (you only do this once per repo). |
| **Commit** | A saved snapshot of your changes, with a short message describing what you did. Commits live on your computer until you push. |
| **Push** | Send your commits from your computer **up** to GitHub. |
| **Pull** | Bring other people's commits **down** from GitHub to your computer. |
| **Remote / origin** | The GitHub copy of your repo. `origin` is the default nickname for it. |
| **Branch** | A parallel line of work. `main` is the default branch. |
| **Merge conflict** | What happens when two people edit the same lines of the same file. Git asks you to choose which version to keep. |
| **`.gitignore`** | A text file listing files Git should **not** track (large data, passwords, temporary files). |

The basic loop is:

```
  GitHub (online)
      ▲        │
 push │        │ pull
      │        ▼
  Your computer:  edit files → stage → commit
```

---

## Part 2: Create a GitHub account and join the lab

1. Go to [github.com](https://github.com) and **Sign up**.
   - Pick a professional username (you will likely keep it for your whole career — it shows up on papers and CVs).
   - You can use any email; you can add your university email later under *Settings → Emails*.
2. **Turn on two-factor authentication** (*Settings → Password and authentication*). GitHub requires it.
3. **Optional but recommended:** apply for [GitHub Education](https://education.github.com/) benefits with your university email — free GitHub Pro and other tools.
4. **Send your GitHub username to Cara** so she can invite you to the [brooklabteam](https://github.com/brooklabteam) organization.
5. Accept the invitation from the email GitHub sends you (or from the notification at [github.com/orgs/brooklabteam/invitation](https://github.com/orgs/brooklabteam/invitation)).

---

## Part 3: Install Git, R, and RStudio

Install in this order: **R → RStudio → Git**.

### R and RStudio
- **R:** download from [CRAN](https://cran.r-project.org/).
- **RStudio Desktop:** download from [Posit](https://posit.co/download/rstudio-desktop/).

### Git

**macOS**

Open the **Terminal** app (Applications → Utilities → Terminal) and check whether Git is already there:

```bash
git --version
```

If you see a version number, you're done. If not, either:
- accept the pop-up offering to install the **Xcode Command Line Tools** (easiest), or
- install [Homebrew](https://brew.sh/) and then run:

```bash
brew install git
```

**Windows**

- Download and install [Git for Windows](https://gitforwindows.org/).
- During installation, **accept the defaults**, but when asked about the default branch name, choose **"Override… main"**.
- This also installs **Git Bash**, a terminal you can use for the commands in this guide.

**Linux**

```bash
sudo apt-get install git
```

(or `sudo dnf install git` on Fedora/RHEL).

> 💡 **Tip:** Restart RStudio after installing Git so it can find it.

---

## Part 4: Introduce yourself to Git

Git stamps every commit with a name and email. Use the **same email as your GitHub account** so your commits are linked to your profile.

The easiest way is from inside **RStudio**, using the `usethis` package. In the RStudio **Console**:

```r
install.packages(c("usethis", "gitcreds", "gh"))

usethis::use_git_config(
  user.name  = "Jane Doe",          # your real name
  user.email = "jane@example.com"   # the email on your GitHub account
)
```

(Alternatively, in a terminal: `git config --global user.name "Jane Doe"` and `git config --global user.email "jane@example.com"`.)

Also set the default branch name to `main`:

```r
usethis::git_default_branch_configure()
```

---

## Part 5: Link GitHub to RStudio (authentication)

GitHub needs proof that you are you before it will accept a push. There are two options. **Pick one.**

| | **Option A: HTTPS + Personal Access Token** | **Option B: SSH key** |
|---|---|---|
| Best for | Beginners; works everywhere | People who already use SSH (e.g., for Savio) |
| Setup | All inside RStudio, ~5 min | Some terminal steps, ~10–15 min |
| Repo URLs look like | `https://github.com/brooklabteam/repo.git` | `git@github.com:brooklabteam/repo.git` |
| Expires? | Yes — renew the token periodically | No |

If you aren't sure, **use Option A**.

### Option A (recommended): HTTPS + Personal Access Token (PAT)

A PAT is a long password-like string that GitHub generates for you. You store it once and RStudio uses it automatically.

1. **Create a token.** In the RStudio Console:

   ```r
   usethis::create_github_token()
   ```

   This opens GitHub in your browser with sensible settings pre-selected (`repo`, `workflow`, `user`, `gist`).
   - Give it a description like *"RStudio – my laptop"*.
   - Set an expiration (90 days is a reasonable balance; you'll get an email before it expires).
   - Click **Generate token** and **copy it immediately** — GitHub will only show it once.

2. **Store the token.** Back in the RStudio Console:

   ```r
   gitcreds::gitcreds_set()
   ```

   Paste the token when prompted and press Enter. It's saved in your operating system's secure keychain (not in any file in your project).

3. **Check that everything worked:**

   ```r
   usethis::git_sitrep()
   ```

   Look for your name, email, and a line saying your token is discovered for user *your-username*. Any red ✖ items point to what still needs fixing.

> ⚠️ **Never** paste your token into an R script, a `.Rprofile` that gets committed, Slack, or email. Treat it like a password.

**When the token expires:** run `usethis::create_github_token()` again (or click *Regenerate* on the token's page on GitHub), then `gitcreds::gitcreds_set()` and choose to replace the old one.

### Option B: SSH key

An SSH key is a pair of files on your computer: a **private** key (keep secret, never share) and a **public** key (give to GitHub).

1. **Check RStudio can see Git.** *Tools → Global Options → Git/SVN*. The **Git executable** box should show a path such as `/usr/bin/git` or `/opt/homebrew/bin/git` (Mac) or `C:/Program Files/Git/bin/git.exe` (Windows). If it's blank, find Git with `which git` (Mac/Linux) or `where git` (Windows) in a terminal, enter that path, and **restart RStudio**.

2. **Create a key.** In the same Git/SVN panel, click **Create SSH Key…**
   - Key type: **ED25519**.
   - A passphrase is optional but recommended.
   - Click **Create**. If a key already exists, RStudio will tell you — you can reuse it.

3. **Copy the public key.** Click **View public key** and copy the whole line (it starts with `ssh-ed25519` and ends with your email or computer name).

4. **Give the public key to GitHub.** On GitHub: profile picture → **Settings → SSH and GPG keys → New SSH key**.
   - Title: something like *"Jane – personal MacBook"*.
   - Paste the key and click **Add SSH key**.

5. **Add the key to your SSH agent** (so you don't type the passphrase every time). Follow GitHub's [instructions for your operating system](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent#adding-your-ssh-key-to-the-ssh-agent).

6. **Test the connection** in a terminal (RStudio has one: *Tools → Terminal → New Terminal*):

   ```bash
   ssh -T git@github.com
   ```

   Type `yes` if asked about authenticity. Success looks like: *"Hi your-username! You've successfully authenticated…"*

When cloning with SSH, always copy the **SSH** URL from GitHub (see Part 6).

See also: [Katherine's step-by-step SSH directions for macOS](../Setting-up-Git-GitHub-RStudio.md).

---

## Part 6: Clone a repository into an RStudio project

Cloning creates a local copy of a GitHub repo, set up as an **RStudio Project** (`.Rproj`) so your working directory and Git pane are configured automatically.

1. **Decide where repos live on your computer.** Pick one folder and keep all repos there, e.g. `~/Developer/` or `~/Documents/GitHub/`.
   - ⚠️ **Avoid** putting repos inside Dropbox, Box, Google Drive, or iCloud-synced folders — the syncing fights with Git and can corrupt the repo.
   - 💡 **Suggested setup:** create a folder called `Developer` directly inside your **home folder** (also called your home directory). This is the top level of your personal files, the folder that holds `Desktop`, `Documents`, and `Downloads`. In the terminal and in R it's written as `~`, so `~/Developer` always means "the Developer folder in my home folder."
     - **Mac:** your home folder is `/Users/<your-username>`, so your repos folder will be `/Users/<your-username>/Developer` (e.g. `/Users/CaraBrook/Developer`). In Finder, press **Shift + Cmd + H** (or *Go → Home*) to open your home folder, then *File → New Folder* and name it `Developer`. macOS recognizes this name and gives the folder a special hammer icon. Or, in the terminal: `mkdir ~/Developer`
     - **Windows:** the equivalent home folder is `C:\Users\<your-username>`, so make `C:\Users\<your-username>\Developer`. In File Explorer, type `%USERPROFILE%` in the address bar and press Enter to open your home folder, then create a new folder named `Developer`. Putting it here (not inside `Documents` or `Desktop`) also keeps it out of **OneDrive**, which on many Windows computers syncs those folders automatically. In Git Bash, `~` also means your home folder, so `mkdir ~/Developer` works there too.

2. **Copy the repo URL from GitHub.** On the repo's page, click the green **`<> Code`** button and copy the URL from the **HTTPS** tab (Option A) or the **SSH** tab (Option B).

3. **In RStudio:** *File → New Project… → Version Control → Git*.
   - **Repository URL:** paste the URL.
   - **Project directory name:** fills in automatically — keep it the same as the repo name.
   - **Create project as subdirectory of:** browse to your repos folder from step 1.
   - Click **Create Project**.

   *Shortcut:* from the Console you can instead run

   ```r
   usethis::create_from_github("brooklabteam/brooklab-resources", destdir = "~/Developer")
   ```

4. RStudio reopens inside the new project. You'll see a **Git** tab in the top-right pane — that's where you'll work with Git from now on.

> 💡 Practice on this repo! Clone `brooklabteam/brooklab-resources`, and when you're comfortable, add yourself or a useful link to it.

---

## Part 7: The everyday workflow — pull, commit, push

Every time you sit down to work on a project, follow this loop. All of it can be done from the **Git** tab in RStudio.

```
Pull  →  Edit  →  Stage  →  Commit  →  Pull  →  Push
```

1. **Pull first** (blue ⬇ arrow in the Git tab). This grabs anything collaborators pushed since you last worked, so you start from the latest version.

2. **Edit** your files as normal and save them. Changed files appear in the Git tab with a status icon:
   - **M** (blue) = modified
   - **?** (yellow) = new, untracked file
   - **A** (green) = added / staged
   - **D** (red) = deleted

3. **Stage** the files you want to include by ticking the **Staged** checkbox next to each one.

4. **Commit:** click **Commit**. A window opens showing exactly what changed (green = added lines, red = removed lines). Write a short, informative message, then click **Commit**.
   - ✅ Good: *"Add bat roost map to Figure 2"*, *"Fix date parsing in serology cleaning script"*
   - ❌ Unhelpful: *"update"*, *"stuff"*, *"asdf"*

5. **Pull again** (in case someone pushed while you were working).

6. **Push** (green ⬆ arrow). Your commits are now on GitHub. Refresh the repo page in your browser to see them.

**How often?** Commit whenever you finish a small, logical chunk of work (several times a day is normal). Push at least at the end of every work session — unpushed work exists only on your laptop.

### The same thing from the command line

You'll eventually want to know these (they're also what you'll use on Savio):

```bash
git pull                      # get collaborators' changes
git status                    # see what has changed
git add path/to/file.R        # stage a file
git commit -m "Describe what you changed"
git push                      # send commits to GitHub
git log --oneline             # see recent history
```

---

## Part 8: Starting a brand-new project

If you're starting a new analysis that isn't on GitHub yet:

1. **Ask Cara** whether it should go under the `brooklabteam` organization (usually yes for lab projects) or your personal account.
2. **Create the repo on GitHub first:** on the org page click **New** (or **+ → New repository**).
   - Name it clearly (e.g. `madagascar-bat-serology`), lowercase with hyphens.
   - Choose **Private** unless told otherwise — it can be made public at publication.
   - Tick **Add a README** and choose the **R** `.gitignore` template.
3. **Clone it** into RStudio as in [Part 6](#part-6-clone-a-repository-into-an-rstudio-project).

*Already have a local RStudio project you want to put on GitHub?* Open it in RStudio and run:

```r
usethis::use_git()                                # start tracking with Git (restart when asked)
usethis::use_github(organisation = "brooklabteam", private = TRUE)
```

---

## Part 9: Lab conventions

- **Pull before you start, push before you stop.** This prevents most merge conflicts.
- **Don't commit large or sensitive data.** GitHub rejects files over 100 MB, and repos get slow well before that. Raw data, anything with personal or location-sensitive information, and passwords/tokens go in `.gitignore`. Ask Cara where large datasets should be stored.
- **Keep repos out of cloud-synced folders** (Dropbox, Box, Google Drive, iCloud).
- **Use RStudio Projects and set your home directory once, at the top of each script.** Every lab R script starts by clearing the environment and setting `homewd` to the repo's location on your computer (see the template in [Part 10](#part-10-test-run--make-your-welcome-repo)). Everywhere else in the script, use paths relative to that folder, e.g. `read.csv("data/samples.csv")`, never `read.csv("/Users/jane/Desktop/samples.csv")`. That way anyone can run your code by changing just the top line.
- **Write a README** in every repo explaining what the project is and how the folders are organized.
- **Write meaningful commit messages** — your future self will thank you.
- **Shared repos:** if several people are actively editing the same repo, talk to each other about who is working on which files, or use branches and pull requests (ask for a walkthrough the first time).

---

## Part 10: Test run — make your welcome repo

Time to put it all together. Every new lab member makes a small practice repo called `welcome-<yourname>` under `brooklabteam`. It's a safe place to try every step, and it lets us confirm your setup works before you start on real projects.

Throughout, replace `<yourname>` with your first name in lowercase (e.g. `welcome-cara`).

### Step 1: Create the repo on GitHub

1. Go to the [brooklabteam](https://github.com/brooklabteam) organization page and click **New** (or **+ → New repository** in the top-right corner).
2. Make sure the **Owner** is `brooklabteam`, not your personal account.
3. **Repository name:** `welcome-<yourname>`.
4. Choose **Private**.
5. Tick **Add a README file**.
6. Under **Add .gitignore**, choose the **R** template.
7. Click **Create repository**.

### Step 2: Clone it as an RStudio project

Follow [Part 6](#part-6-clone-a-repository-into-an-rstudio-project):

1. On your new repo's GitHub page, click the green **`<> Code`** button and copy the HTTPS or SSH URL (whichever matches how you set up authentication in Part 5).
2. In RStudio: *File → New Project… → Version Control → Git*. Paste the URL, keep the directory name `welcome-<yourname>`, and create it inside your `Developer` folder.
3. RStudio reopens in the new project. Check that you see the **Git** tab and a `welcome-<yourname>.Rproj` file in the Files pane.

### Step 3: Write a simple R script

1. Make a new script: *File → New File → R Script*.
2. **Every lab script opens with the same three lines.** Copy these to the top of your script and swap in your own username and repo name:

   ```r
   rm(list=ls())# to clear working directory
   homewd = "/Users/carabrook/Developer/welcome-cara" #(swap names for theirs)
   setwd(homewd)# this makes the whole script reproducible by just changing the top line
   ```

   - **Mac:** the path looks like `"/Users/<your-username>/Developer/welcome-<yourname>"`.
   - **Windows:** the path looks like `"C:/Users/<your-username>/Developer/welcome-<yourname>"`. Use forward slashes `/`, not backslashes `\`, because R treats a backslash as a special character.
   - Not sure of the exact path? Run `getwd()` in the Console while your project is open and copy what it prints.

3. Below those lines, add something simple. Anything works. Here's an example that uses only base R, so you don't need to install any packages:

   ```r
   # make a small data frame
   bats <- data.frame(
     species = c("Pteropus rufus", "Eidolon dupreanum", "Rousettus madagascariensis"),
     n_captured = c(12, 25, 18)
   )

   print(bats)

   # save a bar plot into the repo folder
   png("welcome-plot.png", width = 800, height = 500)
   barplot(bats$n_captured, names.arg = bats$species,
           ylab = "Number captured", main = "Welcome to the Brook Lab!")
   dev.off()
   ```

   Because `setwd(homewd)` ran at the top, `welcome-plot.png` is saved straight into your repo folder.

4. Save the script as `welcome.R` in the main repo folder.
5. Run the whole script (**Source** button, or **Cmd/Ctrl + Shift + S**) and check that it works without errors.

### Step 4: Personalize the README

Open `README.md` from the Files pane and add a couple of lines about yourself: your name, your role in the lab, and what you're excited to work on. Save it.

### Step 5: Commit and push

Use the workflow from [Part 7](#part-7-the-everyday-workflow--pull-commit-push):

1. In the **Git** tab, you should see `welcome.R`, `welcome-plot.png`, and `README.md`.
2. Tick **Staged** for all three.
3. Click **Commit**, write a message like *"Add welcome script, plot, and intro"*, and click **Commit**.
4. Click **Push** (green ⬆ arrow).

### Step 6: Check it worked

1. Refresh your repo's page on GitHub. You should see your script, your plot, and your updated README.
2. Click on `welcome-plot.png` to see your plot right on GitHub.
3. **Send the link to your repo to Cara** to show you're set up.

**Extra practice (optional):** edit something directly on the GitHub website (for example, fix a typo in the README using the ✏️ pencil icon and commit it there). Then go back to RStudio and **Pull**. You'll see the change arrive on your computer. This is exactly what happens when a collaborator pushes changes.

🎉 **You're done!** You've now done everything you'll need for day-to-day work in the lab.

---

## Troubleshooting

**No Git tab in RStudio.**
RStudio can't find Git, or the project isn't a Git repo. Check *Tools → Global Options → Git/SVN* for the Git executable path, then restart RStudio. For an existing project, try `usethis::use_git()`.

**"Support for password authentication was removed."**
GitHub no longer accepts your account password for Git. Set up a PAT (Option A) or SSH key (Option B).

**`Permission denied (publickey)`** (SSH).
GitHub doesn't have your public key, or your SSH agent isn't running. Redo Option B steps 3–6 and run `ssh -T git@github.com`.

**Push is greyed out / "Your branch is ahead of origin by N commits".**
You've committed but not pushed. Click Push. If Push is greyed out entirely, the project may not have a remote — run `usethis::git_sitrep()` to check.

**"Updates were rejected because the remote contains work that you do not have locally."**
Someone pushed while you were working. **Pull** first, then push.

**Merge conflict.**
Git found overlapping edits. Open the file(s) flagged with **U** in the Git tab and look for blocks like:

```
<<<<<<< HEAD
your version
=======
their version
>>>>>>> abc1234
```

Edit the file to keep what you want, delete the `<<<<<<<`, `=======`, and `>>>>>>>` marker lines, save, stage, commit, and push. If it looks scary, stop and ask for help — nothing is lost.

**I accidentally committed a huge file or a password.**
Don't push! Ask for help right away. If it's already pushed and it's a token or password, **revoke/change it immediately** on the relevant website, then ask for help cleaning the history.

**Everything is a mess and I just want a fresh start.**
If you have no unpushed changes you care about, it's fine to delete your local folder and clone again (Part 6).

**Still stuck?** Run `usethis::git_sitrep()` and share the output (it does not print your token) with a labmate.

---

## Further reading

- 📘 [*Happy Git and GitHub for the useR*](https://happygitwithr.com/) by Jenny Bryan — the definitive guide for R users. Most of this page is a condensed version of it.
- [GitHub Docs: Getting started](https://docs.github.com/en/get-started)
- [GitHub Skills](https://skills.github.com/) — free, interactive tutorials
- [Software Carpentry: Version Control with Git](https://swcarpentry.github.io/git-novice/)
- [Oh Shit, Git!?!](https://ohshitgit.com/) — plain-English fixes for common mistakes
- Lab-specific: [Setting up Git, GitHub & RStudio via SSH (macOS)](../Setting-up-Git-GitHub-RStudio.md)
