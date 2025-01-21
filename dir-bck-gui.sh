#!/bin/bash

# Show info message
zenity --info --text="Make sure that the directory you want to archive is located in a read-writeable path, if they aren't you may want to run this script as root."

# Select directory to archive
if save_archive=$(zenity --file-selection --title="Select the folder you want to archive." --directory); then
  # Select save path
  if save_path=$(zenity --file-selection --title="Save to..." --directory); then
    # Set archive name
    if save_name=$(zenity --entry --text="" --title="Set the archive name:"); then
      # Create archive with tar
      tar cfp "$save_path/$save_name.tar" -C "$save_archive" .

      # Find files and directories in selected directory
      find "$save_archive" -type f > "$save_path/$save_name-files.txt"
      find "$save_archive" -type d > "$save_path/$save_name-directories.txt"

      # Move text files to corresponding directories
      mv -n "$save_path/$save_name-files.txt" "$save_path"
      mv -n "$save_path/$save_name-directories.txt" "$save_path"
    else
      zenity --error --text="Error: Archive name not set."
      exit 1
    fi
  else
    zenity --error --text="Error: Save path not set."
    exit 1
  fi
else
  zenity --error --text="Error: Directory to archive not set."
  exit 1
fi
