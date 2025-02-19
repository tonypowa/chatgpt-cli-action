#!/bin/bash
TYPE=$1
URL=$2
PROMPT=$3

echo "Hello $1 / $2"

# gh issue view https://whatever
gh "$TYPE" view "$URL" | tee github-context.txt

echo $PROMPT > context.txt

echo "Running client to see what the robot thinks...."
cat github-context.txt | chatgpt-cli -n --context context.txt 2>errors.txt | tee outputs.txt
echo output=\"`cat outputs.txt`\" >> $GITHUB_OUTPUT
echo errors=\"`cat errors.txt`\" >> $GITHUB_OUTPUT
