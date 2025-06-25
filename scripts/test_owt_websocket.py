#!/usr/bin/env python3
"""
OWT WebSocket Connection Test
Tests connection to wss://facedetection-ws.owt.vn
"""

import asyncio
import json
import websockets
import ssl
import time
from datetime import datetime

async def test_owt_websocket():
    uri = "wss://facedetection-ws.owt.vn"
    
    print(f"🔗 Testing WSS connection to: {uri}")
    print("=" * 60)
    
    # SSL context for secure connection
    ssl_context = ssl.create_default_context()
    ssl_context.check_hostname = True
    ssl_context.verify_mode = ssl.CERT_REQUIRED
    
    try:
        async with websockets.connect(
            uri, 
            ssl=ssl_context,
            ping_interval=20, 
            ping_timeout=10,
            close_timeout=10
        ) as websocket:
            print("✅ WSS connection established successfully!")
            print(f"📍 Connected to: {websocket.remote_address}")
            
            # Test 1: Send ping message
            print("\n📤 Test 1: Sending ping message...")
            ping_msg = {
                "type": "ping",
                "timestamp": datetime.now().isoformat(),
                "source": "flutter_app_test"
            }
            await websocket.send(json.dumps(ping_msg))
            print(f"   Sent: {ping_msg}")
            
            # Wait for response
            try:
                response = await asyncio.wait_for(websocket.recv(), timeout=5.0)
                response_data = json.loads(response)
                print(f"📥 Received response: {response_data}")
                
                if response_data.get('type') == 'pong':
                    print("✅ Ping/Pong test PASSED!")
                else:
                    print("ℹ️  Different response type received (may be valid)")
                    
            except asyncio.TimeoutError:
                print("⚠️  No response received within 5 seconds")
            except json.JSONDecodeError as e:
                print(f"⚠️  Non-JSON response: {response}")
            
            # Test 2: Send frame data (like Flutter app would)
            print("\n📤 Test 2: Sending mock frame data...")
            frame_msg = {
                "type": "frame",
                "data": {
                    "frameId": f"test_frame_{int(time.time() * 1000)}",
                    "timestamp": datetime.now().isoformat(),
                    "imageData": "/9j/4AAQSkZJRgABAQEAYABgAAD/2wBDAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQH/2wBDAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQH/wAARCAABAAEDAREAAhEBAxEB/8QAFQABAQAAAAAAAAAAAAAAAAAAAAv/xAAUEAEAAAAAAAAAAAAAAAAAAAAA/8QAFQEBAQAAAAAAAAAAAAAAAAAAAAX/xAAUEQEAAAAAAAAAAAAAAAAAAAAA/9oADAMBAAIRAxEAPwA/wAuAAA=",  # Tiny JPEG base64
                    "format": "jpeg",
                    "width": 1,
                    "height": 1
                }
            }
            await websocket.send(json.dumps(frame_msg))
            print(f"   Sent frame with {len(frame_msg['data']['imageData'])} bytes of image data")
            
            # Wait for frame processing result
            try:
                response = await asyncio.wait_for(websocket.recv(), timeout=15.0)
                response_data = json.loads(response)
                print(f"📥 Frame response: {json.dumps(response_data, indent=2)}")
                
                if response_data.get('type') == 'frameResult':
                    faces = response_data.get('data', {}).get('faces', [])
                    status = response_data.get('data', {}).get('status', 'unknown')
                    print(f"✅ Frame processing test PASSED!")
                    print(f"   Status: {status}")
                    print(f"   Faces detected: {len(faces)}")
                    
                    if faces:
                        for i, face in enumerate(faces):
                            confidence = face.get('confidence', 0)
                            box = face.get('box', [])
                            print(f"   Face {i+1}: confidence={confidence:.3f}, box={box}")
                else:
                    print("ℹ️  Different frame response type received")
                    
            except asyncio.TimeoutError:
                print("⚠️  No frame response received within 15 seconds")
            except json.JSONDecodeError as e:
                print(f"⚠️  Non-JSON frame response: {response}")
            
            # Test 3: Connection stability
            print("\n⏱️  Test 3: Testing connection stability (10 seconds)...")
            for i in range(10):
                await asyncio.sleep(1)
                if websocket.closed:
                    print(f"❌ Connection closed after {i+1} seconds")
                    break
                print(f"   {i+1}/10 seconds - Connection stable")
            else:
                print("✅ Connection stability test PASSED!")
            
            # Test 4: Graceful close
            print("\n🔌 Test 4: Testing graceful connection close...")
            await websocket.close()
            print("✅ Connection closed gracefully")
            
    except websockets.exceptions.ConnectionRefused:
        print("❌ Connection refused - Server may not be accepting WebSocket connections")
    except websockets.exceptions.InvalidURI:
        print("❌ Invalid WebSocket URI")
    except websockets.exceptions.InvalidStatusCode as e:
        print(f"❌ Invalid status code: {e}")
    except ssl.SSLError as e:
        print(f"❌ SSL/TLS error: {e}")
    except Exception as e:
        print(f"❌ Connection error: {type(e).__name__}: {e}")
    
    print("\n" + "=" * 60)
    print("🏁 OWT WebSocket connection test completed!")

if __name__ == "__main__":
    print("🧪 OWT Production WebSocket Server Test")
    print("Target: wss://facedetection-ws.owt.vn")
    print("Purpose: Verify Flutter app compatibility with OWT backend")
    print("Security: WSS (WebSocket Secure) connection\n")
    
    try:
        asyncio.run(test_owt_websocket())
    except KeyboardInterrupt:
        print("\n👋 Test interrupted by user") 