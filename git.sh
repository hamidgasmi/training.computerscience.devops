#1. Installation:
#1.1 First Installation:
sudo apt-get install git -y
#1.2 Upgrade:
sudo apt-get update

#2. Configuration:
#2.1 Configure the username
git config --global user.name "Hamid Gasmi"
#2.2 Configure the email @
git config --global user.email "mamid1706@hotmail.fr"

#3. GitHub
#3.1. SSH
#3.1.1. Checking for existing SSH keys:
#...... It should one of the following: id_rsa.pub, id_ecdsa.pub, id_ed25519.pub
ls -al ~/.ssh
#3.1.2. Generating a new SSH key and adding it to the ssh-agent:
ssh-keygen -t rsa -b 4096 -C "mamid1706@hotmail.fr"
# > Enter a file in which to save the key (/home/you/.ssh/id_rsa): [Press enter]
#......This accepts the default file location.
# > Enter passphrase (empty for no passphrase): [Type a secure passphrase]
# > Enter same passphrase again: [Type passphrase again]
#3.1.3. Adding my ssh key to the ssh-agent
#...... Start the ssh-agent in the background:
eval "$(ssh-agent -s)"
#...... Add your SSH private key to the ssh-agent:
ssh-add ~/.ssh/id_rsa
#3.1.4. Adding a new SSH key to your GitHub account:
#...... Copy the SSH key to my clipboard:
sudo apt-get install xclip
xclip -sel clip < ~/.ssh/id_rsa.pub
#...... Create new ssh key in GitHub and past the copied ssh key
#3.1.5. Switching remote URLs from HTTPS to SSH
#...... Change the current working directory to my local project
cd ~/source/training.computerscience.linux/
#...... Get the name of the remote repository and verify it is using https url:
git remote -v
#origin	https://github.com/hamidgasmi/training.computerscience.linux.git (fetch)
#origin	https://github.com/hamidgasmi/training.computerscience.linux.git (push)
git remote set-url origin git@github.com:hamidgasmi/training.computerscience.linux.git
#...... Verify that the remote URL has changed:
git remote -v
#origin	git@github.com:hamidgasmi/training.computerscience.linux.git (fetch)
#origin	git@github.com:hamidgasmi/training.computerscience.linux.git (push)

#4 Get started with repositories
#4.1 Clone a remote project: training.computerscience.linux.git
git clone https://github.com/hamidgasmi/training.computerscience.linux.git
#4.2 Fetch: Update local git with remote information: e.g., remote branches list (it does not include code)
#... It does not remove remote branches that no longer have a counterpart branch on the remote
git fetch
#4.3 Fetch + explicitly delete remote branches in local:
git fetch --prune
#4.4 Pull: Ensure our master branch is up-to-date:
git pull origin master

# 5. Branches:
# 5.1. Create a branch and switch to it: it is local at this point
git checkout -b getstartedbranch
# 5.2. Switch to branches:
# ... Switch to master:
git checkout master
# ... Switch to an existing remote branch: 
# ... track flag let the local branch to track the remote branch from origin
# ... If track is omitted then the local branch will be detached from the remote branch
git fetch
git checkout --track origin/remotebranch
# 5.3. List remote branches
git branch -r
# 5.4. List local branches
git branch -l
# 5.5. List All branches:
git branch -a
# 5.6. Delete a local branch
git branch -d gitgetstartedbranch
# 5.7. Rename a local branch:
git checkout <old_branch_name>
git branch -m <new_branch_name> # see 9.3: to push the new local branch + reset the upstream branch: git push origin -u <new_name>

# 6. Local changes:
# 6.1. Undo local changed (they're not stagged yet): Discarding local changes (permanently) to a file:
git checkout -- <file>
# 6.2. Discard all local changes to all files permanently: 
git reset --hard
# 6.3. Discard all local changes, but save them for possible re-use later:
git stash
git stash save  #enables including temporary commit message, which will help you identify changes, among with other options
git stash list  #lists all previously stashed commits (yes, there can be more) that were not poped
git stash pop   #redoes previously stashed changes and removes them from stashed list
git stash apply #redoes previously stashed changes, but keeps them on stashed list

# 7. Staging:
# 7.1. Check stagged files:
git status
# 7.2. Add all file of the directory to the Git staging area:
git add .
# 7.2 Add only 1 file:
git add ~/source/training.computerscience.linux/gitgetstarted.sh
# 7.3 Remove a file from stagging area:
git reset HEAD gitgetstarted.sh~
# 7.4 Get files that are stagged area:
git diff --staged

# 8. Commits
# 8.1. Commit staged files:
git commit -m "Get started files for linux repository"
# 8.2. Commit staged files with Subject and Body (empty line between subject and body)
git commit -m "Add subject" -m " " -m "- Add line 1 for body " -m "- Add line 2 for body"
# 8.3. Modify commit message
git commit --amend -m {new_message}
# 8.4. Check comitted items
# 8.5. Remove a file from a non-pushed commit:
#..... Solution 1: Undo commit and keep all files staged
#..... reset: it's most often used to make a few changes to the latest commit and/or fix its commit message 
#............ it leaves working tree as it was before.
#..... soft: it doesn't touch the index file or the working tree at all 
#........... it resets the head to the previous commit
git reset --soft HEAD~
#..... Solution 2: Undo commit and unstage all files 
git reset HEAD~
#................ mixed will reset the index but not the working tree:
#................ The changed files are preserved but not marked for commit 
#................ It reports what has not been updated.
git reset --mixed HEAD~
# 8.6. Fix merging conflits:
cd repository-folder
#.... list all files which has marker special marker '<<<<<<<'
grep -lr '<<<<<<<' .
#.... If solution is to accept local/our version:
git checkout --ours ./FILE
git add ./FILE
git commit -m "..."
#.... If solution is to accept remote/other-branch version:
git checkout --theirs PATH/FILE

# 9. Pushing:
# 9.1. Push all committed files into a tracked remote branch
git push origin <getstartedbranch>
# 9.2. Push all committed files into a detached remote branch
#..... assumption: local branch is created without track flag: git checkout origin/remotebranch
git push origin HEAD:<remotebranch>
# 9.3. Push all committed files from a local new branch into a remote repository and Track it too
#..... "-u" short for "--set-upstream" option
git push -u origin <branch>
# 9.4. Delete a remote branch from the branch's local git repository:
git push -d origin getstartedbranch
# 9.5. Delete a remote branch from any local git location
git push -d https://github.com/hamidgasmi/training.computerscience.linux.git get 
# 9.6. Delete a remote branch
git push origin --delete gitgetstartedbranch

#10. Merging:
#10.1 Merge a remote branch to a remote master branch
git checkout master
git pull origin master
git merge getstartedbranch
git push origin master
git push origin --delete gitgetstartedbranch
