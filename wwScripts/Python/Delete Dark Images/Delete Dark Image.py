
# ───────────────────────────────── Option 1 ───────────────────────────────── #
# Has only one variable to define the threhold. ie. will remove images that has more than 80% of pixels with less than (1-80%) of the 255 brightness level.


# from PIL import Image
# import os

# Recursilvely Goes through the foldre in the folder_path and remove any filest that has

# folder_path = r"C:\Wayan\PS\00 MUST HAVE\autoscreenshot_1.8.2\test"

# threshold = 0.80  # Change this to adjust the darkness threshold

# for root, dirs, files in os.walk(folder_path):
#     for filename in files:
#         filepath = os.path.join(root, filename)
#         try:
#             with Image.open(filepath) as img:
#                 # Convert the image to grayscale
#                 gray_img = img.convert("L")
#                 # Calculate the percentage of dark pixels
#                 dark_pixels = sum(1 for p in gray_img.getdata() if p < 255 * (1 - threshold))
#                 dark_pct = dark_pixels / len(gray_img.getdata())
#                 # Check if the percentage of dark pixels exceeds the threshold
#                 if dark_pct > threshold:
#                     os.remove(filepath)
#                     print(f"Deleted solid dark image: {filepath} ({dark_pct*100:.2f}% dark)")
#                 else:
#                     print(f"Processed file: {filepath} ({dark_pct*100:.2f}% dark)")
#         except IOError:
#             print(f"Error processing file: {filepath}")





# ───────────────────────────────── Option 2 ───────────────────────────────── #
# Has two variables to define the darkdness threshold (0-255) and % of pixels that are less than darkness_threshold. And then deltes them
# If not already install PIL by running pip install pillow
# do note have to install os as it is a built in module
from PIL import Image
import os

# change the folder_path to the folder you want to delete the dark images from
folder_path = r"C:\WW\Automatic ScreenShots\Temp"

darkness_threshold = 50  # Change this to adjust the darkness threshold
dark_pixel_pct = 0.99  # Change this to adjust the minimum percentage of dark pixels

for root, dirs, files in os.walk(folder_path):
    for filename in files:
        filepath = os.path.join(root, filename)
        try:
            with Image.open(filepath) as img:
                # Convert the image to grayscale
                gray_img = img.convert("L")
                # Check if more than the threshold % of pixels are dark
                dark_pixels = sum(1 for p in gray_img.getdata() if p < darkness_threshold)
                dark_pixel_prop = dark_pixels / len(gray_img.getdata())
                if dark_pixel_prop > dark_pixel_pct:
                    os.remove(filepath)
                    print(f"Deleted solid dark image: {filepath} ({dark_pixel_prop*100:.2f}% dark)")
                else:
                    print(f"Processed file: {filepath} ({dark_pixel_prop*100:.2f}% dark)")
        except IOError:
            print(f"Error processing file: {filepath}")




# ───────────────────────────────── Option 3 ───────────────────────────────── #
# Has two variables to define the darkdness threshold (0-255) and % of pixels that are less than darkness_threshold and prints that.
# from PIL import Image
# import os

# folder_path = r"C:\Wayan\Automatic Screen Shots\2023-03-05"
# darkness_threshold = 45  # Change this to adjust the darkness threshold

# for root, dirs, files in os.walk(folder_path):
#     for filename in files:
#         filepath = os.path.join(root, filename)
#         try:
#             with Image.open(filepath) as img:
#                 # Convert the image to grayscale
#                 gray_img = img.convert("L")
#                 # Calculate the percentage of pixels over the threshold
#                 over_thresh_pixels = sum(1 for p in gray_img.getdata() if p < darkness_threshold)
#                 over_thresh_pct = over_thresh_pixels / len(gray_img.getdata())
#                 # Print the file path and percentage of pixels less than the threshold
#                 print(f"Processed file: {filepath} ({over_thresh_pct*100:.2f}% less than the threshold)")
#         except IOError:
#             print(f"Error processing file: {filepath}")
