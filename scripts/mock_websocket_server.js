const WebSocket = require('ws');

// Create WebSocket server on port 3009
const wss = new WebSocket.Server({ 
  port: 3009,
  host: '0.0.0.0' // Listen on all interfaces
});

console.log('🚀 Mock WebSocket server started on ws://0.0.0.0:3009');
console.log('📱 Flutter app can connect to test streaming...');

wss.on('connection', function connection(ws, req) {
  const clientIP = req.socket.remoteAddress;
  console.log(`📱 New client connected from ${clientIP}`);

  // Send welcome message
  ws.send(JSON.stringify({
    type: 'connection',
    message: 'Connected to mock face detection server',
    timestamp: new Date().toISOString()
  }));

  // Handle incoming messages
  ws.on('message', function incoming(message) {
    try {
      const data = JSON.parse(message);
      console.log(`📥 Received message type: ${data.type}`);

      // Handle different message types
      switch (data.type) {
        case 'frame':
          // Simulate face detection response
          setTimeout(() => {
            const response = {
              type: 'frameResult',
              data: {
                frameId: `frame_${Date.now()}`,
                timestamp: new Date().toISOString(),
                faces: [
                  {
                    faceId: `face_${Date.now()}`,
                    box: [100, 150, 200, 250], // x, y, width, height
                    confidence: 0.85 + Math.random() * 0.1, // Random confidence 0.85-0.95
                    isRecognized: Math.random() > 0.7, // 30% chance of recognition
                    personId: Math.random() > 0.7 ? `person_${Math.floor(Math.random() * 100)}` : null,
                    employeeName: Math.random() > 0.7 ? `Employee ${Math.floor(Math.random() * 100)}` : null
                  }
                ],
                status: 'face_found'
              }
            };
            
            ws.send(JSON.stringify(response));
            console.log(`📤 Sent face detection response with ${response.data.faces.length} faces`);
          }, 100 + Math.random() * 200); // Random delay 100-300ms
          break;

        case 'ping':
          // Respond to heartbeat
          ws.send(JSON.stringify({
            type: 'pong',
            timestamp: new Date().toISOString()
          }));
          console.log('💓 Responded to ping with pong');
          break;

        default:
          console.log(`❓ Unknown message type: ${data.type}`);
      }
    } catch (e) {
      console.log(`❌ Error parsing message: ${e.message}`);
      console.log(`Raw message: ${message}`);
    }
  });

  // Handle connection close
  ws.on('close', function close() {
    console.log(`📱 Client disconnected from ${clientIP}`);
  });

  // Handle errors
  ws.on('error', function error(err) {
    console.log(`❌ WebSocket error: ${err.message}`);
  });

  // Send periodic test messages
  const testInterval = setInterval(() => {
    if (ws.readyState === WebSocket.OPEN) {
      ws.send(JSON.stringify({
        type: 'test',
        message: 'Server status check',
        timestamp: new Date().toISOString(),
        connectedClients: wss.clients.size
      }));
    }
  }, 30000); // Every 30 seconds

  // Clean up interval on disconnect
  ws.on('close', () => {
    clearInterval(testInterval);
  });
});

// Handle server errors
wss.on('error', function error(err) {
  console.log(`❌ Server error: ${err.message}`);
});

// Graceful shutdown
process.on('SIGINT', () => {
  console.log('\n🛑 Shutting down WebSocket server...');
  wss.close(() => {
    console.log('✅ Server closed successfully');
    process.exit(0);
  });
});

console.log('ℹ️  To test connection:');
console.log('   1. Run "node scripts/mock_websocket_server.js"');
console.log('   2. Start Flutter app in debug mode');
console.log('   3. Check connection status in app');
console.log('');
console.log('📊 Server will log all incoming messages and responses'); 