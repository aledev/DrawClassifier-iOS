import turicreate as tc

# Path to images
data_path = "/Users/alejandro.aliaga/Workspace/github/CoreML/Models/draw-recognition/train"

# Load the image data
data = tc.image_analysis.load_images(data_path, with_path=True)
data['label'] = data['path'].apply(lambda path: 'ambulance' if '/ambulance' in path else 'cat')

# Split the data between the train data and the test one
(train_data, test_data) = data.random_split(0.8)

# Train an image classifier
model = tc.image_classifier.create(data, target='label')

# Predictions
predictions = model.predict(data)

# Save the coreml model
model.export_coreml('DrawClassifierV1.mlmodel')

print(data)