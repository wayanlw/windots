# Moves the similar images to the sample image to a new folder named moved_files. if the folder exists it will create a new folder with a number appended to the end of the folder name. 
# create a description of what this does. 
# This script moves images that are similar to a sample image to a new folder named "moved_files". 
# The similarity is determined by comparing the grayscale values of the pixels in the images. 
# If the difference between the grayscale values of the sample image and the target image is below a certain threshold, the target image is moved to the "moved_files" folder. 
# The threshold can be adjusted to control the sensitivity of the comparison.

# folder_path: Path to the folder containing images to be checked.
# sample_image_path: Path to the sample image to compare against.
# threshold: Threshold value for image dissimilarity. Lower values mean stricter similarity comparison. 185 was identified as a good threshold for the sample image provided.
# if it is exact make it 5.

from PIL import Image, ImageChops
import os

folder_path = r"C:\WW\Automatic ScreenShots\Temp"
sample_image_path = r"C:\WW\Automatic ScreenShots\Temp\2024-04-26 12.01.28.jpg"

def move_similar_images(folder_path, sample_image_path, threshold=5):
    with Image.open(sample_image_path) as sample_img:
        sample_gray_img = sample_img.convert("L")
        for root, dirs, files in os.walk(folder_path):
            for filename in files:
                filepath = os.path.join(root, filename)
                try:
                    with Image.open(filepath) as img:
                        gray_img = img.convert("L")
                        diff = ImageChops.difference(sample_gray_img, gray_img)
                        if diff.getextrema()[1] < threshold:
                            moved_folder = os.path.join(root, "moved_files")
                            if not os.path.exists(moved_folder):
                                os.makedirs(moved_folder)
                            new_filepath = os.path.join(moved_folder, filename)
                            os.rename(filepath, new_filepath)
                            print(f"Moved similar image: {filepath}")
                        else:
                            print(f"Processed file: {filepath}")
                except IOError:
                    print(f"Error processing file: {filepath}")

move_similar_images(folder_path, sample_image_path, threshold=185)
