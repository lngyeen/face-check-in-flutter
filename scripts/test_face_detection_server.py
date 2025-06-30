#!/usr/bin/env python3
"""
Test script to verify face detection server functionality
"""
import websocket
import json
import base64
import time
from PIL import Image
import io
import os

def create_test_image(width=640, height=480, orientation='portrait'):
    """Create a simple test image with a face-like rectangle"""
    from PIL import Image, ImageDraw
    
    if orientation == 'portrait':
        img = Image.new('RGB', (width, height), color='lightblue')
    else:
        img = Image.new('RGB', (height, width), color='lightblue')
    
    draw = ImageDraw.Draw(img)
    
    # Draw a simple face-like shape
    face_x = img.width // 4
    face_y = img.height // 4  
    face_w = img.width // 2
    face_h = img.height // 2
    
    # Face outline
    draw.ellipse([face_x, face_y, face_x + face_w, face_y + face_h], 
                fill='peachpuff', outline='black', width=2)
    
    # Eyes
    eye_size = 20
    left_eye_x = face_x + face_w // 3
    right_eye_x = face_x + 2 * face_w // 3
    eye_y = face_y + face_h // 3
    
    draw.ellipse([left_eye_x - eye_size//2, eye_y - eye_size//2,
                 left_eye_x + eye_size//2, eye_y + eye_size//2],
                fill='black')
    draw.ellipse([right_eye_x - eye_size//2, eye_y - eye_size//2,
                 right_eye_x + eye_size//2, eye_y + eye_size//2],
                fill='black')
    
    # Mouth
    mouth_y = face_y + 2 * face_h // 3
    mouth_width = face_w // 3
    mouth_x = face_x + face_w // 2 - mouth_width // 2
    draw.arc([mouth_x, mouth_y - 10, mouth_x + mouth_width, mouth_y + 10],
            start=0, end=180, fill='black', width=3)
    
    return img

def image_to_base64(img, quality=85):
    """Convert PIL image to base64 JPEG"""
    buffer = io.BytesIO()
    img.save(buffer, format='JPEG', quality=quality)
    img_bytes = buffer.getvalue()
    return base64.b64encode(img_bytes).decode('utf-8')

def test_face_detection():
    """Test face detection server with different orientations"""
    
    server_url = "wss://facedetection-ws.owt.vn"
    
    # Test images
    test_cases = [
        ("landscape_640x480", create_test_image(640, 480, 'landscape')),
        ("portrait_480x640", create_test_image(480, 640, 'portrait')),
        ("landscape_1280x720", create_test_image(1280, 720, 'landscape')),
        ("portrait_720x1280", create_test_image(720, 1280, 'portrait')),
    ]
    
    def on_message(ws, message):
        print(f"✅ Server response: {message}")
        try:
            data = json.loads(message)
            if data.get('type') == 'frameResult':
                faces = data.get('data', {}).get('faces', [])
                print(f"🎯 Detected {len(faces)} faces")
                for i, face in enumerate(faces):
                    confidence = face.get('confidence', 0)
                    bbox = face.get('bbox', [])
                    print(f"   Face {i+1}: confidence={confidence:.3f}, bbox={bbox}")
        except json.JSONDecodeError:
            print(f"❌ Failed to parse JSON: {message}")
    
    def on_error(ws, error):
        print(f"❌ WebSocket error: {error}")
    
    def on_close(ws, close_status_code, close_msg):
        print(f"🔴 WebSocket closed: {close_status_code} - {close_msg}")
    
    def on_open(ws):
        print("🟢 WebSocket connected")
        
        for test_name, test_img in test_cases:
            print(f"\n🧪 Testing {test_name} ({test_img.width}x{test_img.height})")
            
            base64_data = image_to_base64(test_img)
            print(f"📸 Base64 length: {len(base64_data)} chars")
            
            message = {
                "type": "frameData",
                "data": {
                    "image": base64_data,
                    "timestamp": int(time.time() * 1000),
                    "cameraId": "test-camera"
                }
            }
            
            ws.send(json.dumps(message))
            print(f"📤 Sent {test_name}")
            time.sleep(3)  # Wait for response
        
        # Close after tests
        time.sleep(2)
        ws.close()
    
    # Run test
    print(f"🚀 Testing face detection server: {server_url}")
    ws = websocket.WebSocketApp(
        server_url,
        on_open=on_open,
        on_message=on_message,
        on_error=on_error,
        on_close=on_close
    )
    
    ws.run_forever()

if __name__ == "__main__":
    try:
        test_face_detection()
    except KeyboardInterrupt:
        print("\n⏹️  Test interrupted")
    except Exception as e:
        print(f"❌ Test failed: {e}") 