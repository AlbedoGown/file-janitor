#!/usr/bin/env bash

NAME=$(basename "$0")

HELP_FILE="file-janitor-help.txt"

generate_report_summary() {
    local target_dir="$1"

    local tmp_file_sizes=$(find "$target_dir" -maxdepth 1 -name '*.tmp' -type f -printf "%s\n")
    local tmp_count=0
    if [ -n "$tmp_file_sizes" ]; then
        tmp_count=$(echo "$tmp_file_sizes" | wc -l)
    fi
    local tmp_total_size=$(echo "$tmp_file_sizes" | awk '{s+=$1} END {print s}')
    if [ -z "$tmp_total_size" ]; then
        tmp_total_size=0
    fi
    echo "$tmp_count tmp file(s), with total size of $tmp_total_size bytes"

    local log_file_sizes=$(find "$target_dir" -maxdepth 1 -name '*.log' -type f -printf "%s\n")
    local log_count=0
    if [ -n "$log_file_sizes" ]; then
        log_count=$(echo "$log_file_sizes" | wc -l)
    fi
    local log_total_size=$(echo "$log_file_sizes" | awk '{s+=$1} END {print s}')
    if [ -z "$log_total_size" ]; then
        log_total_size=0
    fi
    echo "$log_count log file(s), with total size of $log_total_size bytes"

    local py_file_sizes=$(find "$target_dir" -maxdepth 1 -name '*.py' -type f -printf "%s\n")
    local py_count=0
    if [ -n "$py_file_sizes" ]; then
        py_count=$(echo "$py_file_sizes" | wc -l)
    fi
    local py_total_size=$(echo "$py_file_sizes" | awk '{s+=$1} END {print s}')
    if [ -z "$py_total_size" ]; then
        py_total_size=0
    fi
    echo "$py_count py file(s), with total size of $py_total_size bytes"
}

perform_cleanup() {
    local target_dir="$1"

    local files_to_delete_log=$(find "$target_dir" -maxdepth 1 -type f -name "*.log" -mtime +3 -print)
    local count_log=0
    if [ -n "$files_to_delete_log" ]; then
        count_log=$(echo "$files_to_delete_log" | wc -l)
        echo "$files_to_delete_log" | xargs -r rm
    fi
    echo "Deleting old log files...  done! $count_log files have been deleted"

    local files_to_delete_tmp=$(find "$target_dir" -maxdepth 1 -type f -name "*.tmp" -print)
    local count_tmp=0
    if [ -n "$files_to_delete_tmp" ]; then
        count_tmp=$(echo "$files_to_delete_tmp" | wc -l)
        echo "$files_to_delete_tmp" | xargs -r rm
    fi
    echo "Deleting temporary files...  done! $count_tmp files have been deleted"

    local python_files=$(find "$target_dir" -maxdepth 1 -type f -name "*.py" -print)
    local count_py=0
    if [ -n "$python_files" ]; then
        count_py=$(echo "$python_files" | wc -l)
    fi

    if [ "$count_py" -gt 0 ]; then
        mkdir -p "$target_dir/python_scripts"
        echo "$python_files" | xargs -r -I {} mv {} "$target_dir/python_scripts"
    fi
    echo "Moving python files...  done! $count_py files have been moved"
}

echo -e "File Janitor, $(date +%Y)\nPowered by Bash"

case "$1" in
    "help")
        cat "$HELP_FILE"
    ;;

    "list")
        DIR="${2:-.}"
        if [ ! -e "$DIR" ]; then
            echo ""$DIR" is not found"
        elif [ ! -d "$DIR" ]; then
            echo ""$DIR" is not a directory"
        else
            if [ "$DIR" = "." ]; then
                echo "Listing files in the current directory"
            else
                echo "Listing files in $DIR"
            fi
            ls -A1 "$DIR" | sort -f
        fi
    ;;

    "report")
        DIR="${2:-.}"
        if [ ! -e "$DIR" ]; then
            echo ""$DIR" is not found"
        elif [ ! -d "$DIR" ]; then
            echo ""$DIR" is not a directory"
        else
            if [ "$DIR" = "." ]; then
                echo "The current directory contains:"
            else
                echo ""$DIR" contains:"
            fi
            generate_report_summary "$DIR"
        fi
    ;;

    "clean")
        TARGET_PATH="${2:-.}"
        LOCAL_CLEAN_MESSAGE="Cleaning the current directory..."
        OTHER_PATH_CLEAN_MESSAGE="Cleaning "$TARGET_PATH"..."

        if [ "$TARGET_PATH" = "." ] || [ -z "$2" ]; then
            INITIAL_MESSAGE="$LOCAL_CLEAN_MESSAGE"
            FINAL_MESSAGE="Clean up of the current directory is complete!"
        else
            INITIAL_MESSAGE="$OTHER_PATH_CLEAN_MESSAGE"
            FINAL_MESSAGE="Clean up of "$TARGET_PATH" is complete!"
        fi

        if [ ! -e "$TARGET_PATH" ]; then
            echo "$TARGET_PATH is not found"
        elif [ ! -d "$TARGET_PATH" ]; then
            echo "$TARGET_PATH is not a directory"
        else
            echo "$INITIAL_MESSAGE"
            perform_cleanup "$TARGET_PATH"
            echo "$FINAL_MESSAGE"
        fi
    ;;

    *)
        echo "Type $NAME help to see available options"
    ;;
esac
