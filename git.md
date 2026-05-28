---
created: 2026-01-05
tags:
  - git
---

## Starting Out

| Description | Command |
| --- | --- |
| Starting a new repo locally | `git init` |
| Cloning an existing repo | `git clone <url>` |

## Preparing to commit

| Description | Command |
| --- | --- |
| Adding an untracked change or unstaged file | `git add <file>` |
| Adding all untracked changes or all files that are unstaged | `git add .` |
| Choosing which parts of the file to add | `git add -p` |
| Moving a file | `git mv <file>` |
| Delete a file | `git delete <file>` |
| Forgetting a file without deleting it | `git rm --cached <file>` |
| Unstage a single file | `git reset <file>` |
| Unstaging all files | `git reset` |
| Checking what has been added | `git status` |

## Making commits

| Description | Command |
| --- | --- |
| Make a commit (which also opens up a text editor to write a note) | `git commit` |
| Making a commit with message | `git commit -m 'message'` |
| Commit every unstaged change | `git commit -am 'message'` |

## Branches

| Description | Command |
| --- | --- |
| Switching to a different branch | `git switch <name>` or `<git checkout <name>` |
| Creating a branch | `git switch -c` or `git checkout -b` |
| Listing branches | `git branch` |
| Listing branches by the last that was committed to | `git branch --sort-committerdate` |
| Deleting a branch | `git branch -d <name>` |
| Force deleting a branch | `git branch -D <name>` |

## Diff Staged/Unstaged

| Description | Command |
| --- | --- |
| Diff staged and unchanged changed | `git diff HEAD` |
| Diff only staged changes | `git diff --staged` |
| Diff only unstaged changes | `git diff` |

## Diff committing

| Description | Command |
| --- | --- |
| Diff between commit and parent | `git show <commit>` |
| Diff of two commits | `git diff <commit> <commit>` |
| Diff of one file since making commit | `git diff <commit> <file>` |
| Summary of diff | `git diff <commit> --stat` or `git show <commit> --stat` |

## Discarding changes

| Description | Command |
| --- | --- |
| Deleting changes on a file that are unstaged | `git restore <file>` or `git checkout <file>` |
| Deleting all staged & unstaged changes to a single file | `git restore --staged --worktree <file>` or `git checkout HEAD <file>` |
| Deleting all staged & unstaged changes | `git reset --hard` |
| Deleting untracked files | `git clean` |
| Stashinng staged & unstaged changed | `git stash` |

## Editing the history

| Description | Command |
| --- | --- |
| Undo the latest commit while keeping workding directory the same | `git reset HEAD^` |
| Squash last 5 commits into one | `git rebase -i HEAD~6` |
| Undo failed rebase | `git reflog <branchename>` |
| Change commit message or add a file | `git commit --amend` | 

## Code History

| Description | Command |
| --- | --- |
| Checking out history of branch | `git log main` `git log --graph main` `git log --oneline` |
| Show commits that modified a file | `git log <file>` |
| Find commits that added/removed text | `git log -G *text*` |
| Display who last changed lines of a file | `git blame <file>` |

## Combining Branches

| Description | Command |
| --- | --- |
| Combine with rebase | `git switch <branch>` `git rebase main` |
| Combine with merge | `git switch main` `get merge <branche> |
| Combine with squash merge | `git switch main` `git merge --squash <branch>` `git commit` |
| Make one branch up to date with another branch | `git switch main` `git merge <branche>` |
| Copy commit onto current branch | `git cherry-pick <commit>` |

## Restoring an old file

| Description | Command |
| --- | --- |
| Get version of file from another commit | `git checkout <commit> <file>` or `git restore <file> --source <commit>` |

## Adding a remote

| Description | Command |
| --- | --- |
| Add remote | `git remote add <name> <url>` |

## Pushing changes

| Description | Command |
| --- | --- |
| Push `main` branch to remote `origin` | `git push origin main` |
| Push current branch to remote tracking branch | `git push` |
| Push branch that hasn't been pushed before | `git push -u origin <name>` |
| Force push | `git push --force-with-lease` |
| Push tags | `git push --tags` |

## Pulling changes

| Description | Command |
| --- | --- |
| Fetch changes without changing local branches | `git fetch origin main` |
| Fetch changes and rebase current branch | `git pull --rebase` |
| Fetch changes and merge into current branch | `git pull origin main` or `git pull` |

## Configuring Git

| Description | Command |
| --- | --- |
| Set a config option | `git config user.name <name>` |
| Set options globally | `git config --global` |
| Adding an alias | `git config alias.st status` |
| See all of the possible config options | `man git-config` |

## Important files

| Description | Command |
| --- | --- |
| Local git config | `.git/config` |
| Global git config | `~/.gitconfig |
| List of files Git ignores | `.gitignore` |
