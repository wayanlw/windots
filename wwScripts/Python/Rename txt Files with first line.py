import os
import re


# Reanmes the files looking at the first line of the file.
# Further, if the first style starts with a non-alpha numeric charater, script will remove those.


# Set the directory containing the text files
directory = r"C:\Users\auwwaya\OneDrive - Essity\Desktop\New folder"

# Iterate over each file in the directory
for filename in os.listdir(directory):
    # Check if the file is a text file
    if filename.endswith(".txt"):
        # Create the full file path by joining the directory path and the filename
        filepath = os.path.join(directory, filename)

        # Open the file and read the first line
        with open(filepath) as f:
            first_line = f.readline().strip()

            # Remove any non-alphanumeric characters from the beginning of the first line
            first_line = re.sub(r"^\W+", "", first_line)

        # Create the new filename by using the first line of the file
        new_filename = first_line + ".txt"

        # Create the full path for the new filename by joining the directory path and the new filename
        new_filepath = os.path.join(directory, new_filename)

        # Rename the file by moving it to the new filepath
        os.rename(filepath, new_filepath)

        # Print a message to confirm the file has been renamed
        print(f"Renamed {filename} to {new_filename}")
