#!/bin/bash

# Show info message
echo "Make sure that the directory you want to archive is located in a read-writeable path, if they aren't you may want to run this script as root."

# Select directory to archive
read -p "Enter the directory you want to archive: " save_archive
if [ ! -d "$save_archive" ]; then
  echo "Error: Directory to archive not set or does not exist."
  exit 1
fi
save_archive=$(realpath "$save_archive")

# Select save path
read -p "Enter the save path: " save_path
if [ ! -d "$save_path" ]; then
  echo "Error: Save path not set or does not exist."
  exit 1
fi
save_path=$(realpath "$save_path")

# Set archive name
read -p "Enter the archive name: " save_name

# Create archive with tar
tar cfp "$save_path/$save_name.tar" -C "$save_archive" .

# Find files and directories in selected directory
find "$save_archive" -type f > "$save_path/$save_name-files.txt"
find "$save_archive" -type d > "$save_path/$save_name-directories.txt"

# Move text files to corresponding directories
mv -n "$save_path/$save_name-files.txt" "$save_path"
mv -n "$save_path/$save_name-directories.txt" "$save_path"
