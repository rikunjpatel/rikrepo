#!/bin/bash
echo "Adding all last modified files to git commit queue"
git add --all
echo "Check all okay with the added files and press enter to commit"
sleep 10

git commit
git status
echo "if all good press en #ter to push tthe o Master Branch"
git push origin master

