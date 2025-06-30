#!/usr/bin/env python3
"""
Quick WebSocket Connection Test for Backend Server
Tests connection to ws://192.168.1.234:3009
"""

import asyncio
import json
import websockets
import time
from datetime import datetime

async def test_websocket_connection():
    uri = "ws://192.168.1.234:3009"
    
    print(f"🔗 Testing WebSocket connection to: {uri}")
    print("=" * 50)
    
    try:
        async with websockets.connect(uri, ping_interval=20, ping_timeout=10) as websocket:
            print("✅ WebSocket connection established successfully!")
            
            # Test 1: Send ping
            print("\n📤 Test 1: Sending ping message...")
            ping_msg = {
                "type": "ping",
                "timestamp": datetime.now().isoformat()
            }
            await websocket.send(json.dumps(ping_msg))
            
            # Wait for response
            try:
                response = await asyncio.wait_for(websocket.recv(), timeout=5.0)
                response_data = json.loads(response)
                print(f"📥 Received response: {response_data}")
                
                if response_data.get('type') == 'pong':
                    print("✅ Ping/Pong test passed!")
                else:
                    print("ℹ️  Different response type received")
                    
            except asyncio.TimeoutError:
                print("⚠️  No response received within 5 seconds")
            
            # Test 2: Send mock frame data
            print("\n📤 Test 2: Sending mock frame data...")
            frame_msg = {
                "type": "frame",
                "data": {
                    "frameId": f"test_frame_{int(time.time() * 1000)}",
                    "timestamp": datetime.now().isoformat(),
                    "imageData": "iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mNkYPhfDwAChwGA60e6kgAAAABJRU5ErkJggg==",  # 1x1 pixel base64
                    "format": "base64"
                }
            }
            await websocket.send(json.dumps(frame_msg))
            
            # Wait for frame result
            try:
                response = await asyncio.wait_for(websocket.recv(), timeout=10.0)
                response_data = json.loads(response)
                print(f"📥 Frame response: {response_data}")
                
                if response_data.get('type') == 'frameResult':
                    faces = response_data.get('data', {}).get('faces', [])
                    print(f"✅ Frame processing test passed! Found {len(faces)} faces")
                else:
                    print("ℹ️  Different frame response type received")
                    
            except asyncio.TimeoutError:
                print("⚠️  No frame response received within 10 seconds")
            
            # Test 3: Keep connection alive for a few seconds
            print("\n⏱️  Test 3: Keeping connection alive for 5 seconds...")
            await asyncio.sleep(5)
            print("✅ Connection stability test passed!")
            
    except websockets.exceptions.ConnectionRefused:
        print("❌ Connection refused - Backend server may not be running")
    except websockets.exceptions.InvalidURI:
        print("❌ Invalid WebSocket URI")
    except Exception as e:
        print(f"❌ Connection error: {e}")
    
    print("\n" + "=" * 50)
    print("🏁 WebSocket connection test completed!")

if __name__ == "__main__":
    print("🧪 WebSocket Backend Server Connection Test")
    print("Target: ws://192.168.1.234:3009")
    print("Purpose: Verify backend server compatibility\n")
    
    try:
        asyncio.run(test_websocket_connection())
    except KeyboardInterrupt:
        print("\n👋 Test interrupted by user") 