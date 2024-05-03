from PIL import Image, ImageChops
import os

folder_path = r"C:\WW\Automatic ScreenShots\Temp"
sample_image_path = r"C:\WW\Automatic ScreenShots\Temp\2024-03-04 06.55.18.jpg"

# Recursively goes through the folder in the folder_path and removes any files that look like the sample image
def delete_similar_images(folder_path, sample_image_path, threshold=5):
    # Open the sample image
    with Image.open(sample_image_path) as sample_img:
        # Convert the sample image to grayscale
        sample_gray_img = sample_img.convert("L")

        # Loop through all the files in the folder
        for root, dirs, files in os.walk(folder_path):
            for filename in files:
                filepath = os.path.join(root, filename)
                try:
                    with Image.open(filepath) as img:
                        # Convert the image to grayscale
                        gray_img = img.convert("L")

                        # Compare the difference between the two grayscale images
                        diff = ImageChops.difference(sample_gray_img, gray_img)
                        if diff.getextrema()[1] < threshold:
                            os.remove(filepath)
                            print(f"Deleted similar image: {filepath}")
                        else:
                            print(f"Processed file: {filepath}")
                except IOError:
                    print(f"Error processing file: {filepath}")



delete_similar_images(folder_path, sample_image_path, threshold=5)
