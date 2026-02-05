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
| Commit every unstaged changed | `git commit -am 'message'` |

## Switching branches

| Description | Command |
| --- | --- |
| Switching to a different branch | `git switch <name> or <git checkout <name>` |
| Creating a branch | 



