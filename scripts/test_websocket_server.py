#!/usr/bin/env python3
"""
Simple WebSocket test script to check OWT face detection server
"""
import asyncio
import websockets
import json
import base64
from datetime import datetime

async def test_owt_server():
    uri = "wss://facedetection-ws.owt.vn"
    
    try:
        print(f"🌐 Connecting to {uri}...")
        async with websockets.connect(uri) as websocket:
            print("✅ Connected successfully!")
            
            # Send a test frame
            test_frame = {
                "type": "frame",
                "data": "iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mNkYPhfDwAChwGA60e6kgAAAABJRU5ErkJggg==",
                "timestamp": int(datetime.now().timestamp() * 1000)
            }
            
            print("📤 Sending test frame...")
            await websocket.send(json.dumps(test_frame))
            print("✅ Test frame sent")
            
            # Wait for response with timeout
            try:
                response = await asyncio.wait_for(websocket.recv(), timeout=10.0)
                print(f"📥 Response received: {response}")
                
                # Try to parse response
                try:
                    parsed = json.loads(response)
                    print(f"📋 Parsed response: {json.dumps(parsed, indent=2)}")
                except json.JSONDecodeError:
                    print(f"❌ Response is not valid JSON: {response}")
                    
            except asyncio.TimeoutError:
                print("⏰ No response received within 10 seconds")
                
            # Send a ping
            print("📤 Sending ping...")
            await websocket.send(json.dumps({"type": "ping"}))
            
            try:
                response = await asyncio.wait_for(websocket.recv(), timeout=5.0)
                print(f"📥 Ping response: {response}")
            except asyncio.TimeoutError:
                print("⏰ No ping response within 5 seconds")
                
    except websockets.exceptions.ConnectionClosed:
        print("❌ Connection closed by server")
    except websockets.exceptions.InvalidHandshake:
        print("❌ Invalid handshake - server rejected connection")
    except Exception as e:
        print(f"❌ Connection failed: {e}")

if __name__ == "__main__":
    print("🧪 Testing OWT WebSocket Server...")
    asyncio.run(test_owt_server()) 