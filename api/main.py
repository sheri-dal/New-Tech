from fastapi import FastAPI, File, UploadFile
from fastapi.middleware.cors import CORSMiddleware
import uvicorn
import numpy as np
from io import BytesIO
from PIL import Image
import tensorflow as tf
from resizeimage import resizeimage
import matplotlib.pyplot as plt

app = FastAPI()

origins = [
    "http://localhost",
    "http://127.0.0.1:64109",
    "http://localhost:3000",
]
app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


MODEL =  tf.keras.models.load_model("../Train_Model/2")
CLASS_NAMES = ["Nevus Stage 1", "Nevus Stage 1","Nevus Stage 1","Skin","Wrong object"]

@app.get("/ping")
async def ping():
    return "Hello, I am alive"


def read_file_as_image(data) -> np.ndarray:
   return np.array(
        Image.open(BytesIO(data)).resize((256, 256)) # image resizing
    )
 

 
     


@app.post("/predict")
async def predict(
    file: UploadFile = File(...)
):
    MODEL =  tf.keras.models.load_model("../Train_Model/8")
    image = read_file_as_image(await file.read())
    
    img_batch = np.expand_dims(image, 0)

    predictions = MODEL.predict(img_batch)

    predicted_class = CLASS_NAMES[np.argmax(predictions[0])]
    confidence = (np.max(predictions[0]) )* 100
    return {
        'class': predicted_class,
        'confidence': float(confidence )
    }

if __name__ == "__main__":
    uvicorn.run(app, host='192.168.100.20', port=8087)
