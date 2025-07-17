File Janitor
Project Description
File Janitor is a simple and convenient bash script designed to automate routine file management and directory cleanup tasks. It helps maintain order in your file system by deleting old log files, temporary files, and organizing Python scripts into a dedicated subdirectory.

This script is ideal for developers, system administrators, or any user looking to quickly tidy up their working directories.

Features
Report Generation: Get a summary of the count and total size of .tmp, .log, and .py files in a specified directory.

Log File Cleanup: Deletes .log files older than 3 days.

Temporary File Deletion: Removes all .tmp files.

Python Script Organization: Moves all .py files into a newly created python_scripts subdirectory.

Intuitive Interface: Simple commands for executing various operations.

Safety Checks: Verifies directory existence and type before performing operations.

How to Install and Run
File Janitor is a bash script and does not require complex installation.

Clone the repository (or download the files):

git clone https://github.com/AlbedoGown/file-janitor.git
cd file-janitor

Make the script executable:

chmod +x file-janitor.sh

Create the help file:
Ensure that a file named file-janitor-help.txt with the following content is located in the same directory as file-janitor.sh:

Usage: file-janitor.sh [COMMAND] [PATH]

COMMANDS:
  help            Show this help message.
  list [PATH]     List files in the specified directory (or current if PATH is omitted).
  report [PATH]   Generate a report on .tmp, .log, and .py files in the specified directory (or current).
  clean [PATH]    Perform cleanup in the specified directory (or current).
                  - Deletes .log files older than 3 days.
                  - Deletes all .tmp files.
                  - Moves all .py files to a 'python_scripts' subdirectory.

Usage
Run the script from your command line, specifying the desired command and an optional path.

./file-janitor.sh [COMMAND] [PATH]

Command Examples:
Show help:

./file-janitor.sh help

List files in the current directory:

./file-janitor.sh list

List files in a specific directory:

./file-janitor.sh list /path/to/your/folder

Generate a report for the current directory:

./file-janitor.sh report

Generate a report for a specific directory:

./file-janitor.sh report /home/user/my_logs

Perform cleanup in the current directory:

./file-janitor.sh clean

(Outputs "Cleaning the current directory...")

Perform cleanup in a specific directory:

./file-janitor.sh clean ./

(Outputs "Cleaning ./...")

./file-janitor.sh clean /var/log/app

(Outputs "Cleaning /var/log/app...")

License
This project is licensed under the MIT License. See the LICENSE file for details.
