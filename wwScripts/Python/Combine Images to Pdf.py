from PIL import Image
import os

# Increase the maximum allowed image size
Image.MAX_IMAGE_PIXELS = None  # Be cautious with this setting in untrusted environments

def images_to_pdf(folder_path, output_pdf_path):
    # Retrieve all image files in the specified folder
    image_files = [f for f in os.listdir(folder_path) if f.endswith(('.png', '.jpg', '.jpeg', '.bmp'))]
    image_files.sort()  # Optional: sort files if necessary

    # Create Image object for the first image to start the PDF
    if not image_files:
        print("No images found in the folder.")
        return

    first_image_path = os.path.join(folder_path, image_files[0])
    first_image = Image.open(first_image_path).convert('RGB')

    # # Optionally resize if the image is too large
    # if first_image.width * first_image.height > 100000000:
    #     first_image = first_image.resize((int(first_image.width / 2), int(first_image.height / 2)))

    # List to hold the converted images except the first one
    img_list = []

    # Loop through the remaining images, open them, convert them, and append to the list
    for file in image_files[1:]:
        img_path = os.path.join(folder_path, file)
        img = Image.open(img_path).convert('RGB')

        # Optionally resize if the image is too large
        if img.width * img.height > 100000000:
            img = img.resize((int(img.width / 2), int(img.height / 2)))

        img_list.append(img)

    # Save all images in a PDF file
    first_image.save(output_pdf_path, save_all=True, append_images=img_list)
    print(f"PDF file has been created: {output_pdf_path}")

# Example usage:
folder_path = r"C:\Users\auwwaya\Downloads\Jessy V - Copy"
output_pdf_path = 'output_file.pdf'
images_to_pdf(folder_path, output_pdf_path)