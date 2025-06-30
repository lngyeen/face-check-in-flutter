# Easy Check-in Face Recognition API Documentation

## Overview

The Easy Check-in Face Recognition system provides a comprehensive API for real-time face recognition, face registration, and video streaming. The system consists of two main components:

1. **Face Recognition Service** (Port 3000) - Main application with REST API endpoints
2. **InsightFace API** (Port 18080) - AI-powered face recognition engine

## Base URLs

- **Face Recognition Service**: `http://localhost:3000`
- **InsightFace API**: `http://localhost:18080`
- **WebSocket Signaling**: `ws://localhost:8081`

## Authentication

Currently, the API does not require authentication. All endpoints are publicly accessible.

## API Endpoints

### Health Check

#### GET /health
Check if the service is running.

**Response:**
```
OK
```

### Face Registration

#### POST /register
Register a new face for a person.

**Request Body:**
```json
{
  "personId": "string",
  "images": ["base64_image_1", "base64_image_2"],
  "threshold": 0.6
}
```

**Parameters:**
- `personId` (required): Unique identifier for the person
- `images` (required): Array of base64-encoded images
- `threshold` (optional): Detection threshold (default: 0.6)

**Response:**
```json
{
  "success": true,
  "message": "Registered 2 faces, failed: 0",
  "personId": "john_doe",
  "registeredFaces": [
    {
      "faceImageLink": "http://localhost:9000/faces/john_doe-2024-01-15T10-30-45-123Z.jpg",
      "confidence": 0.95
    }
  ],
  "failedFaces": []
}
```

**Example:**
```bash
curl -X POST http://localhost:3000/register \
  -H "Content-Type: application/json" \
  -d '{
    "personId": "john_doe",
    "images": ["/9j/4AAQSkZJRgABAQAAAQ..."],
    "threshold": 0.6
  }'
```

#### GET /registered_faces
List all registered faces.

**Response:**
```json
[
  {
    "personId": "john_doe",
    "faceImageLinks": [
      "http://localhost:9000/faces/john_doe-2024-01-15T10-30-45-123Z.jpg"
    ],
    "faceCount": 1
  }
]
```

**Example:**
```bash
curl -X GET http://localhost:3000/registered_faces
```

#### DELETE /registered_faces/:personId
Delete a registered face.

**Parameters:**
- `personId` (path): The ID of the person whose face should be deleted

**Response:**
```json
{
  "success": true
}
```

**Example:**
```bash
curl -X DELETE http://localhost:3000/registered_faces/john_doe
```

## Real-time Face Recognition

### WebSocket Connection

The system provides real-time face recognition results via WebSocket connections.

**Connection:**
```javascript
const ws = new WebSocket('ws://localhost:8081');
```

### WebSocket Message Types

#### 1. Frame Processing
Send a frame for processing:

```javascript
ws.send(JSON.stringify({
  type: 'processFrame',
  image: 'base64_encoded_image'
}));
```

#### 2. Frame Results
Receive processed frame results:

```javascript
ws.onmessage = (event) => {
  const message = JSON.parse(event.data);
  if (message.type === 'frameResult') {
    const result = message.data;
    console.log('Faces detected:', result.faces);
  }
};
```

**Frame Result Structure:**
```json
{
  "type": "frameResult",
  "data": {
    "faces": [
      {
        "faceId": "john_doe",
        "isRecognized": true,
        "confidence": 0.95,
        "gender": "male",
        "age": 30,
        "mask": "no_mask",
        "bbox": [100, 150, 200, 250],
        "face_data": "base64_face_crop"
      }
    ],
    "faceImagePath": "http://localhost:9000/faces/camera1-2024-01-15T10-30-45-123Z.jpg",
    "cameraId": "camera1",
    "timestamp": "2024-01-15T10:30:45.123Z",
    "processingTime": 150,
    "isCheckinSent": true,
    "originalSize": 1024000,
    "processedSize": 512000,
    "annotatedImage": "base64_annotated_image"
  }
}
```

### WebRTC Video Streaming

The system also supports WebRTC video streaming for real-time video feeds.

#### WebRTC Signaling Messages

1. **Get Router Capabilities:**
```javascript
ws.send(JSON.stringify({
  type: 'getRouterRtpCapabilities'
}));
```

2. **Create WebRTC Transport:**
```javascript
ws.send(JSON.stringify({
  type: 'createWebRtcTransport'
}));
```

3. **Connect Transport:**
```javascript
ws.send(JSON.stringify({
  type: 'connectWebRtcTransport',
  dtlsParameters: dtlsParameters
}));
```

4. **Consume Video:**
```javascript
ws.send(JSON.stringify({
  type: 'consume',
  rtpCapabilities: rtpCapabilities
}));
```

## InsightFace API Endpoints

The InsightFace API provides additional face recognition capabilities.

### Face Extraction

#### POST /extract
Extract face embeddings and detect faces.

**Request Body:**
```json
{
  "images": {
    "data": ["base64_image"]
  },
  "threshold": 0.6,
  "return_face_data": true,
  "extract_embedding": true,
  "match_faces": true
}
```

**Response:**
```json
{
  "took": {
    "total_ms": 150,
    "read_imgs_ms": 20,
    "embed_all_ms": 130
  },
  "data": [
    {
      "status": "ok",
      "took_ms": 150,
      "faces": [
        {
          "bbox": [100, 150, 200, 250],
          "prob": 0.95,
          "vec": [0.1, 0.2, ...],
          "gender": "male",
          "age": 30,
          "matched_person_id": "john_doe"
        }
      ]
    }
  ]
}
```

### Face Detection Visualization

#### POST /draw_detections
Draw detected faces on an image.

**Request Body:**
```json
{
  "images": {
    "data": ["base64_image"]
  },
  "threshold": 0.6,
  "draw_landmarks": true,
  "draw_scores": true
}
```

**Response:** PNG image with drawn detections

### System Information

#### GET /info
Get system configuration information.

**Response:**
```json
{
  "version": "0.9.0.0",
  "tensorrt_version": "8.6.1",
  "log_level": "INFO",
  "models": {
    "det_name": "scrfd_2.5g_gnkps",
    "rec_name": "w600k_r50"
  },
  "defaults": {
    "threshold": 0.6,
    "max_size": [640, 640]
  }
}
```

## Data Types

### Face Recognition Result
```typescript
interface FaceRecognitionResult {
  faceId?: string | null;
  isRecognized: boolean;
  bbox: [number, number, number, number]; // [x1, y1, x2, y2]
  confidence: number;
  gender?: string | null;
  age?: number | null;
  mask?: string | null;
  mask_probs?: number[] | null;
  face_data?: string | null;
}
```

### Processed Frame
```typescript
interface ProcessedFrame {
  faces: FaceRecognitionResult[];
  faceImagePath: string;
  cameraId: string;
  timestamp: string;
  processingTime: number;
  isCheckinSent: boolean;
  originalSize?: number;
  processedSize?: number;
  annotatedImage?: string;
}
```

## Error Handling

All API endpoints return appropriate HTTP status codes:

- `200`: Success
- `400`: Bad Request
- `500`: Internal Server Error

Error responses include a message:
```json
{
  "error": "Error description"
}
```

## Configuration

The system can be configured using environment variables:

| Variable | Description | Default |
|----------|-------------|---------|
| `RTSP_URL` | RTSP stream URL | `rtsp://admin:123456@192.168.3.92:8554/live` |
| `CAMERA_ID` | Camera identifier | `camera1` |
| `FRAME_INTERVAL_SECONDS` | Frame extraction interval | `1` |
| `INSIGHTFACE_ENDPOINT` | InsightFace API URL | `http://insightface:18080` |
| `MINIO_ENDPOINT` | MinIO server endpoint | `minio` |
| `MINIO_PORT` | MinIO server port | `9000` |
| `MINIO_ACCESS_KEY` | MinIO access key | `minioadmin` |
| `MINIO_SECRET_KEY` | MinIO secret key | `minioadmin` |
| `MINIO_BUCKET` | MinIO bucket name | `easy-checkin` |

## Examples

### Complete Face Registration Flow

```javascript
// 1. Register a new face
const response = await fetch('http://localhost:3000/register', {
  method: 'POST',
  headers: {
    'Content-Type': 'application/json'
  },
  body: JSON.stringify({
    personId: 'john_doe',
    images: [base64Image],
    threshold: 0.6
  })
});

const result = await response.json();
console.log('Registration result:', result);

// 2. List registered faces
const facesResponse = await fetch('http://localhost:3000/registered_faces');
const faces = await facesResponse.json();
console.log('Registered faces:', faces);
```

### Real-time Face Recognition

```javascript
// Connect to WebSocket
const ws = new WebSocket('ws://localhost:8081');

ws.onopen = () => {
  console.log('Connected to face recognition service');
};

ws.onmessage = (event) => {
  const message = JSON.parse(event.data);
  
  if (message.type === 'frameResult') {
    const result = message.data;
    
    result.faces.forEach(face => {
      if (face.isRecognized) {
        console.log(`Recognized: ${face.faceId} (confidence: ${face.confidence})`);
      } else {
        console.log('Unknown face detected');
      }
    });
  }
};

// Send a frame for processing
function processFrame(imageData) {
  ws.send(JSON.stringify({
    type: 'processFrame',
    image: imageData
  }));
}
```

## Rate Limits

Currently, there are no rate limits implemented. However, consider the following:

- Frame processing is limited by the `FRAME_INTERVAL_SECONDS` configuration
- InsightFace API has internal processing limits
- WebSocket connections are limited by server resources

## Troubleshooting

### Common Issues

1. **Connection refused**: Ensure all services are running
2. **Face not recognized**: Check if the face is properly registered
3. **High processing time**: Consider adjusting frame interval or image quality
4. **WebSocket disconnection**: Implement reconnection logic

### Logs

Check the application logs for detailed error information:
```bash
docker logs face-recognition
docker logs insightface
```

## Support

For technical support or questions, please refer to the project documentation or create an issue in the project repository. 