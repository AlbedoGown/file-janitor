# File Janitor

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## Project Description

`File Janitor` is a simple and convenient bash script designed to automate routine file management and directory cleanup tasks. It helps maintain order in your file system by deleting old log files, temporary files, and organizing Python scripts into a dedicated subdirectory.

This script is ideal for developers, system administrators, or any user looking to quickly tidy up their working directories.

## Features

* **Report Generation:** Get a summary of the count and total size of `.tmp`, `.log`, and `.py` files in a specified directory.
* **Log File Cleanup:** Deletes `.log` files older than 3 days.
* **Temporary File Deletion:** Removes all `.tmp` files.
* **Python Script Organization:** Moves all `.py` files into a newly created `python_scripts` subdirectory.
* **Intuitive Interface:** Simple commands for executing various operations.
* **Safety Checks:** Verifies directory existence and type before performing operations.

## How to Install and Run

`File Janitor` is a bash script and does not require complex installation.

1.  **Clone the repository (or download the files):**
    ```bash
    git clone [https://github.com/AlbedoGown/file-janitor.git](https://github.com/AlbedoGown/file-janitor.git)
    cd file-janitor
    ```

2.  **Make the script executable:**
    ```bash
    chmod +x file-janitor.sh
    ```

3.  **Create the help file:**
    Ensure that a file named `file-janitor-help.txt` with the following content is located in the same directory as `file-janitor.sh`:
    ```
    Usage: file-janitor.sh [COMMAND] [PATH]

    COMMANDS:
      help            Show this help message.
      list [PATH]     List files in the specified directory (or current if PATH is omitted).
      report [PATH]   Generate a report on .tmp, .log, and .py files in the specified directory (or current).
      clean [PATH]    Perform cleanup in the specified directory (or current).
                      - Deletes .log files older than 3 days.
                      - Deletes all .tmp files.
                      - Moves all .py files to a 'python_scripts' subdirectory.
    ```

## Usage

Run the script from your command line, specifying the desired command and an optional path.

```bash
./file-janitor.sh [COMMAND] [PATH]
