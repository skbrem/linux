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
| 
