from ultralytics import YOLO
from PIL import Image
import cv2

# Load a larger YOLOv8 model for better accuracy
model = YOLO('yolov8l.pt')  # Largest YOLOv8 model

# Load the image
image_path = "dogandcat.jpeg"
input_image = cv2.imread(image_path)

# Resize the image for better detection
input_image_resized = cv2.resize(input_image, (640, 640))

# Run detection with adjusted confidence and IoU thresholds
results = model(input_image_resized, conf=0.4, iou=0.3)  # Lower thresholds to improve sensitivity

# Initialize parameters
dog_class_id = 16  # COCO class ID for "dog"

# Annotate detections
for detection in results[0].boxes:  # Iterate through detected objects
    class_id = int(detection.cls[0])  # Class ID
    confidence = float(detection.conf[0])  # Confidence score
    if class_id == dog_class_id and confidence > 0.4:  # Only keep dogs with moderate confidence
        # Extract bounding box coordinates
        x1, y1, x2, y2 = map(int, detection.xyxy[0])
        # Scale coordinates back to original image size if resized
        height_ratio = input_image.shape[0] / 640
        width_ratio = input_image.shape[1] / 640
        x1, y1, x2, y2 = int(x1 * width_ratio), int(y1 * height_ratio), int(x2 * width_ratio), int(y2 * height_ratio)

        # Draw a green rectangle for detected dogs
        cv2.rectangle(input_image, (x1, y1), (x2, y2), (0, 255, 0), thickness=3)
        # Add confidence score text
        cv2.putText(
            input_image,
            f"Dog: {confidence:.2f}",
            (x1, y1 - 10),
            cv2.FONT_HERSHEY_SIMPLEX,
            0.6,
            (0, 255, 0),
            2,
        )

# Save the output image
output_path = "highlighted_dogs_yolo_improved.jpeg"
cv2.imwrite(output_path, input_image)
print(f"Processed image saved as {output_path}")

# Display the output image
output_image = Image.open(output_path)
output_image.show()
