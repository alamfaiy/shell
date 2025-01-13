#!/bin/bash

# Assignment Owner: Fayiza Alam
# Below is my assignment, which is edited directly on top of the given template.
# I also commented out the original template for my own understanding 

set -x # This enables execution tracing. Essentially this is a debugging tool.

############################################
# DSI CONSULTING INC. Project setup script #
############################################
# This script creates standard analysis and output directories
# for a new project. It also creates a README file with the
# project name and a brief description of the project.
# Then it unzips the raw data provided by the client.

mkdir analysis output # Create two folders, one called "analysis", one "output"
touch README.md # Create a "read me" markdown file
touch analysis/main.py # Create a file called main.py inside the analysis folder 
echo "# Project Name: DSI Consulting Inc." > README.md

# download client data

# curl transfers data between a client and a server (that you link to)
# option "o" (output <file>) writes to file instead of standard output
# option "L" (location) follows redirects (the server you're going to might redirect)
curl -Lo rawdata.zip https://github.com/UofT-DSI/shell/raw/refs/heads/main/02_activities/assignments/rawdata.zip
# ^ so this line will transfer rawdata.zip from the https:// link to the current directory and save as "rawdata.zip"
unzip rawdata.zip # It is then unzipped in the current directory

###########################################
# Complete assignment here

# 1. Create a directory named data
mkdir data

# 2. Move the ./rawdata directory to ./data/raw
mv ./rawdata ./data/raw

# 3. List the contents of the ./data/raw directory
ls ./data/raw

# 4. In ./data/processed, create the following directories: server_logs, user_logs, and event_logs
# mkdir has a function called "-p" or "parents" which makes parent directories if they don’t exist
mkdir -p ./data/processed/server_logs ./data/processed/user_logs ./data/processed/event_logs

# 5. Copy all server log files (files with "server" in the name AND a .log extension) from ./data/raw to ./data/processed/server_logs
# Since I just want "server" ANYWHERE in the name, wildcards before AND after "server" allow for any characters around it
cp ./data/raw/*server*.log ./data/processed/server_logs

# 6. Repeat the above step for user logs and event logs
# User logs:
cp ./data/raw/*user*.log ./data/processed/user_logs
# Event logs:
cp ./data/raw/*event*.log ./data/processed/event_logs

# 7. For user privacy, remove all files containing IP addresses (files with "ipaddr" in the filename) from ./data/raw and ./data/processed/user_logs
# Since there can be many files, I will not use -i, which will become tedious
# I am inclined to use -f to force the removal just in case there are any errors (for example that no ipaddr files exist)
# These could be log or text files, so I will keep the extension unspecified 
rm -f ./data/raw/*ipaddr* ./data/processed/user_logs/*ipaddr*

# 8. Create a file named ./data/inventory.txt that lists all the files in the subfolders of ./data/processed
# I'm assuming this is ALL the files ONLY, NOT the folders
# I can use "brace expansion" to specify multiple directories in a single command
ls ./data/processed/{server_logs,user_logs,event_logs} > ./data/inventory.text
# I'm using ">" so it does not maintain a record of the past subfolder contents and only shows what the current subfolder contents look like

# This line was from my "coworker" and I am keeping it to remove "data" after it was generated
# This ensures only "assignment.sh" is committed
# When I was testing, I commented this so I could examine data
# In assignment_test_clean, I have my undeleted data folders
# For submission, I am uncommenting this
rm -rf ./data
###########################################

echo "Project setup is complete!"

# I ran this on my computer and manually checked everything, looks like it works! Wee!
