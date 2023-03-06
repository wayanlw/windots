# import os
# from tkinter import *
# from tkinter import filedialog
# from PIL import Image

# class App:
#     def __init__(self, master):
#         self.master = master
#         self.master.title("Image Cleaner")
#         self.file_path = StringVar()
#         self.threshold = DoubleVar()
#         self.percent = DoubleVar()

#         # Set default values for the threshold and pixel percentage
#         self.threshold.set(0.95)
#         self.percent.set(0.95)

#         # Create the GUI elements
#         Label(master, text="File path:").grid(row=0, column=0, sticky=W)
#         Entry(master, textvariable=self.file_path).grid(row=0, column=1)
#         Button(master, text="Browse", command=self.browse_files).grid(row=0, column=2)

#         Label(master, text="Darkness threshold:").grid(row=1, column=0, sticky=W)
#         Entry(master, textvariable=self.threshold).grid(row=1, column=1)

#         Label(master, text="Pixel percentage:").grid(row=2, column=0, sticky=W)
#         Entry(master, textvariable=self.percent).grid(row=2, column=1)

#         self.output_text = Text(master, width=50, height=10)
#         self.output_text.grid(row=3, columnspan=3)

#         Button(master, text="Clean images", command=self.clean_images).grid(row=4, column=1)

#     def browse_files(self):
#         # Open a file dialog to choose the file path
#         file_path = filedialog.askdirectory(initialdir=os.getcwd(), title="Select directory")
#         self.file_path.set(file_path)

#     def clean_images(self):
#         # Get the file path, threshold, and pixel percentage from the GUI elements
#         file_path = self.file_path.get()
#         threshold = self.threshold.get()
#         percent = self.percent.get()

#         # Check that a file path has been selected
#         if not file_path:
#             self.output_text.insert(END, "Please select a file path\n")
#             return

#         # Recursively search for image files in the directory
#         for dirpath, dirnames, filenames in os.walk(file_path):
#             for filename in filenames:
#                 # Check that the file is an image
#                 if filename.lower().endswith(('.png', '.jpg', '.jpeg', '.bmp')):
#                     file_full_path = os.path.join(dirpath, filename)

#                     # Load the image and calculate the percentage of dark pixels
#                     with Image.open(file_full_path) as img:
#                         pixels = img.getdata()
#                         dark_pixels = sum(sum(pixel <= int(255 * threshold) for pixel in row) for row in pixels)
#                         dark_pixel_percent = dark_pixels / (img.width * img.height)

#                     # If the percentage of dark pixels is greater than the specified threshold, print the filename and delete the file
#                     if dark_pixel_percent >= percent:
#                         self.output_text.insert(END, f"Deleting {file_full_path} ({dark_pixel_percent:.2%} dark pixels)\n")
#                         os.remove(file_full_path)
#                     else:
#                         self.output_text.insert(END, f"Not deleting {file_full_path} ({dark_pixel_percent:.2%} dark pixels)\n")

# if __name__ == "__main__":
#     root = Tk()
#     app = App(root)
#     root.mainloop()


# ──────────────────────────────────────────────────────────────────────────── #
from PIL import Image
import os
import tkinter as tk
from tkinter import filedialog

def check_image(image_path, threshold, percent, output_text):
    im = Image.open(image_path)
    pixels = im.load()
    dark_pixels = 0
    for i in range(im.size[0]):
        for j in range(im.size[1]):
            if sum(pixels[i, j]) <= threshold*3:
                dark_pixels += 1
    percent_dark = (dark_pixels / (im.size[0] * im.size[1])) * 100
    if percent_dark >= percent:
        os.remove(image_path)
        file_name = os.path.basename(image_path)
        output_text.insert(tk.END, f"Removed {file_name}, {percent_dark:.2f}% dark pixels\n")
    else:
        file_name = os.path.basename(image_path)
        output_text.insert(tk.END, f"Not Removed{file_name} is {percent_dark:.2f}% dark pixels\n")


def main(folder_path, threshold, percent, output_text):
    for root, dirs, files in os.walk(folder_path):
        for file in files:
            if file.endswith('.jpg') or file.endswith('.png'):
                file_path = os.path.join(root, file)
                # output_text.insert(tk.END, f"Checking {file_path}\n")
                check_image(file_path, threshold, percent, output_text)

def browse_button():
    global folder_path
    folder_path = filedialog.askdirectory()
    path_label.config(text=folder_path)

def run_script():
    threshold = int(threshold_entry.get())
    percent = int(percent_entry.get())
    output_text.delete(1.0, tk.END) # Clear previous output
    main(folder_path, threshold, percent, output_text)

root = tk.Tk()
root.title("Image Deleter")
root.geometry("500x300")

# Create widgets
folder_label = tk.Label(root, text="Choose Folder:")
path_label = tk.Label(root, text="")
browse_button = tk.Button(root, text="Browse", command=browse_button)
threshold_label = tk.Label(root, text="Darkness Threshold (0-255):")
threshold_entry = tk.Entry(root)
percent_label = tk.Label(root, text="% of Pixels Above Threshold:")
percent_entry = tk.Entry(root)
run_button = tk.Button(root, text="Run Script", command=run_script)
output_text = tk.Text(root, height=10, width=50)

# Add widgets to grid
folder_label.grid(row=0, column=0)
path_label.grid(row=0, column=1)
browse_button.grid(row=0, column=2)
threshold_label.grid(row=1, column=0)
threshold_entry.grid(row=1, column=1)
percent_label.grid(row=2, column=0)
percent_entry.grid(row=2, column=1)
run_button.grid(row=3, column=1)
output_text.grid(row=4, column=0, columnspan=3)

root.mainloop()
