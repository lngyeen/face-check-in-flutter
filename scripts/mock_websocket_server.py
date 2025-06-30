#!/usr/bin/env python3
"""
Mock WebSocket Server for Face Check-in Flutter App
Simulates face detection backend for testing purposes
"""

import asyncio
import json
import logging
import time
import random
from datetime import datetime
import websockets
from websockets.server import WebSocketServerProtocol

# Configure logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s'
)
logger = logging.getLogger(__name__)

class MockFaceDetectionServer:
    def __init__(self, host='0.0.0.0', port=3009):
        self.host = host
        self.port = port
        self.clients = set()
        
    async def register_client(self, websocket: WebSocketServerProtocol):
        """Register a new client connection"""
        self.clients.add(websocket)
        client_ip = websocket.remote_address[0] if websocket.remote_address else 'unknown'
        logger.info(f"📱 New client connected from {client_ip} (Total: {len(self.clients)})")
        
        # Send welcome message
        welcome_msg = {
            'type': 'connection',
            'message': 'Connected to mock face detection server',
            'timestamp': datetime.now().isoformat()
        }
        await websocket.send(json.dumps(welcome_msg))
        
    async def unregister_client(self, websocket: WebSocketServerProtocol):
        """Unregister client connection"""
        self.clients.discard(websocket)
        client_ip = websocket.remote_address[0] if websocket.remote_address else 'unknown'
        logger.info(f"📱 Client disconnected from {client_ip} (Total: {len(self.clients)})")
        
    def generate_face_detection_response(self) -> dict:
        """Generate mock face detection response"""
        num_faces = random.choices([0, 1, 2], weights=[20, 70, 10])[0]  # 70% chance of 1 face
        
        faces = []
        for i in range(num_faces):
            # Random face position and size
            x = random.randint(50, 200)
            y = random.randint(100, 300)
            width = random.randint(80, 150)
            height = random.randint(80, 150)
            
            face = {
                'faceId': f'face_{int(time.time() * 1000)}_{i}',
                'box': [x, y, width, height],
                'confidence': round(0.75 + random.random() * 0.2, 3),  # 0.75-0.95
                'isRecognized': random.random() > 0.6,  # 40% recognition rate
                'personId': f'person_{random.randint(1, 100)}' if random.random() > 0.6 else None,
                'employeeName': f'Employee {random.randint(1, 100)}' if random.random() > 0.6 else None
            }
            faces.append(face)
        
        # Determine status based on number of faces
        if num_faces == 0:
            status = 'no_face'
        elif num_faces == 1:
            status = 'face_found'
        else:
            status = 'multiple_faces'
            
        return {
            'type': 'frameResult',
            'data': {
                'frameId': f'frame_{int(time.time() * 1000)}',
                'timestamp': datetime.now().isoformat(),
                'faces': faces,
                'status': status
            }
        }
        
    async def handle_message(self, websocket: WebSocketServerProtocol, message: str):
        """Handle incoming WebSocket messages"""
        try:
            data = json.loads(message)
            msg_type = data.get('type', 'unknown')
            logger.info(f"📥 Received message type: {msg_type}")
            
            if msg_type == 'frame':
                # Simulate processing delay
                await asyncio.sleep(random.uniform(0.1, 0.3))
                
                # Generate face detection response
                response = self.generate_face_detection_response()
                await websocket.send(json.dumps(response))
                
                face_count = len(response['data']['faces'])
                logger.info(f"📤 Sent face detection response with {face_count} faces")
                
            elif msg_type == 'ping':
                # Respond to heartbeat
                pong_response = {
                    'type': 'pong',
                    'timestamp': datetime.now().isoformat()
                }
                await websocket.send(json.dumps(pong_response))
                logger.info("💓 Responded to ping with pong")
                
            else:
                logger.warning(f"❓ Unknown message type: {msg_type}")
                
        except json.JSONDecodeError as e:
            logger.error(f"❌ Error parsing JSON: {e}")
            logger.error(f"Raw message: {message}")
        except Exception as e:
            logger.error(f"❌ Error handling message: {e}")
            
    async def handle_client(self, websocket: WebSocketServerProtocol, path: str):
        """Handle individual client connection"""
        await self.register_client(websocket)
        
        try:
            async for message in websocket:
                await self.handle_message(websocket, message)
        except websockets.exceptions.ConnectionClosed:
            logger.info("🔌 Client connection closed normally")
        except Exception as e:
            logger.error(f"❌ Client connection error: {e}")
        finally:
            await self.unregister_client(websocket)
            
    async def periodic_status_check(self):
        """Send periodic status messages to all connected clients"""
        while True:
            await asyncio.sleep(30)  # Every 30 seconds
            
            if self.clients:
                status_msg = {
                    'type': 'status',
                    'message': 'Server status check',
                    'timestamp': datetime.now().isoformat(),
                    'connectedClients': len(self.clients)
                }
                
                # Send to all connected clients
                disconnected_clients = set()
                for client in self.clients:
                    try:
                        await client.send(json.dumps(status_msg))
                    except Exception:
                        disconnected_clients.add(client)
                        
                # Remove disconnected clients
                for client in disconnected_clients:
                    self.clients.discard(client)
                    
    async def start_server(self):
        """Start the WebSocket server"""
        logger.info("🚀 Starting Mock WebSocket Server for Face Check-in App")
        logger.info("=" * 50)
        logger.info(f"🌐 Server starting on ws://{self.host}:{self.port}")
        logger.info("📱 Flutter app can connect to test streaming...")
        logger.info("")
        logger.info("ℹ️  To test with Flutter app:")
        logger.info("   1. Keep this server running")
        logger.info("   2. Run 'flutter run --debug' in another terminal")
        logger.info("   3. Check connection status in the app")
        logger.info("")
        logger.info("📊 Server will log all incoming messages and responses")
        logger.info("Press Ctrl+C to stop the server")
        logger.info("")
        
        # Start periodic status check task
        asyncio.create_task(self.periodic_status_check())
        
        # Start WebSocket server
        server = await websockets.serve(
            self.handle_client,
            self.host,
            self.port,
            ping_interval=20,
            ping_timeout=10
        )
        
        logger.info(f"✅ WebSocket server started successfully!")
        logger.info(f"🔗 Connection URL: ws://{self.host}:{self.port}")
        
        return server

async def main():
    """Main function"""
    server_instance = MockFaceDetectionServer()
    
    try:
        server = await server_instance.start_server()
        await server.wait_closed()
    except KeyboardInterrupt:
        logger.info("\n🛑 Shutting down WebSocket server...")
        logger.info("✅ Server closed successfully")
    except Exception as e:
        logger.error(f"❌ Server error: {e}")

if __name__ == "__main__":
    try:
        asyncio.run(main())
    except KeyboardInterrupt:
        print("\n👋 Goodbye!") 