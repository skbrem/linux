#!/bin/bash

# Check the status of the local repo
echo "Checking status of the repo..."
git status -s

# Asking for commit message
echo "Enter commit message: "
read commit_msg

# Executing git add, commit, and push

git add .
git commit -m "$commit_msg"
git push
