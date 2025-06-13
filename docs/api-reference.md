# API Reference

## WebSocket Communication Protocol

### Backend Configuration

* **Development Environment**: `ws://192.168.1.234:3009`
* **Connection Timeout**: 30 seconds
* **Retry Policy**: 3 attempts with 3-second delays
* **Protocol**: Raw WebSocket communication

### Client (Flutter App) to Server Message

* **Format**: The application will send the raw **base64 string of the image frame** directly over the WebSocket connection, with no JSON wrapping.
* **Status**: ✅ **Confirmed** - Backend ready at `ws://192.168.1.234:3009`

### Server to Client (Flutter App) Messages

The server will respond with a JSON message. The client will determine the outcome based on the contents of the `data.faces` array.

* **Client-Side Processing Logic**:
    * If `data.faces` array is **empty `[]`**: Treat as a **failure**.
    * If `data.faces` array **contains one or more objects**: Treat as a **success**. Use the first element (`data.faces[0]`) to display information.

* **Failure Response Structure**:
    ```json
    {
      "type": "frameResult",
      "data": {
        "faces": [],
        "faceImagePath": "",
        "cameraId": "1",
        "timestamp": "2025-06-12T09:00:00.000Z",
        "processingTime": 1000,
        "isCheckinSent": false
      }
    }
    ```

* **Success Response Structure** (Real Sample Data):
    ```json
    {
      "type": "frameResult",
      "data": {
        "faces": [
          {
            "faceId": "person_001",
            "isRecognized": true,
            "confidence": 0.92,
            "gender": "male",
            "age": 28,
            "mask": false,
            "bbox": [150, 120, 250, 220]
          }
        ],
        "faceImagePath": "https://storage.example.com/faces/camera1-2024-03-20T10:30:00.jpg",
        "cameraId": "camera_001",
        "timestamp": "2024-03-20T10:30:00.000Z",
        "processingTime": 250,
        "isCheckinSent": true,
        "originalSize": {"width": 1920, "height": 1080},
        "processedSize": {"width": 640, "height": 480},
        "annotatedImage": "base64_encoded_image_string_here"
      }
    }
    ``` 