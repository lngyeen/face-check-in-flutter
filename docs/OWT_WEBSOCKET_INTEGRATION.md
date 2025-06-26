# OWT Production WebSocket Integration

**Date**: December 28, 2024  
**Target**: `wss://facedetection-ws.owt.vn`  
**Story**: 2.2 - Frame Streaming & Processing Phase 5  

## Configuration Update ✅

### **WebSocket Server Details**

**🌐 OWT Production Server:**
- **URL**: `wss://facedetection-ws.owt.vn`
- **Protocol**: WSS (WebSocket Secure)
- **Port**: 443 (HTTPS/WSS default)
- **IP Address**: `117.2.155.123`
- **Security**: SSL/TLS encrypted connection

### **Flutter App Configuration**

**File**: `lib/core/config/websocket_config.dart`

```dart
/// Alternative development config for real devices
static const WebSocketConfig developmentRealDevice = WebSocketConfig(
  url: 'wss://facedetection-ws.owt.vn', // OWT Production WebSocket server
  timeout: Duration(seconds: 30),
  maxRetries: 3,
  retryDelay: Duration(seconds: 3),
  enableLogging: true,
  enableHeartbeat: true,
  enableAutoReconnect: true,
  enableExponentialBackoff: true,
);
```

## Connection Verification ✅

### **Network Tests Completed:**

1. **🔍 DNS Resolution**
   ```bash
   ping -c 3 facedetection-ws.owt.vn
   # Result: 117.2.155.123 - 0.0% packet loss
   ```

2. **🔐 SSL/WSS Port Access**
   ```bash
   nc -z -v facedetection-ws.owt.vn 443
   # Result: Connection to facedetection-ws.owt.vn port 443 [tcp/https] succeeded!
   ```

3. **🔗 WebSocket Handshake**
   ```bash
   python3 scripts/test_owt_websocket.py
   # Result: ✅ WSS connection established successfully!
   # Connected to: ('117.2.155.123', 443)
   ```

## Integration Testing Status 🧪

### **Connection Results:**

✅ **WSS Handshake**: Successful SSL/TLS connection established  
✅ **Network Connectivity**: Server accessible from device network  
✅ **Port Availability**: Port 443 responding to connections  
⚠️ **Message Protocol**: Server accepts connections but response format needs verification  

### **Flutter App Testing:**

**Current Status**: App rebuilt and running with OWT configuration
- WebSocket URL updated to production server
- Debug mode enabled for comprehensive logging
- Real device testing on Samsung Galaxy S23

### **Expected Workflow:**

1. **Camera Initialization** → Front camera ready for capture
2. **WebSocket Connection** → Connect to `wss://facedetection-ws.owt.vn`
3. **Frame Streaming** → Send Base64 encoded frames every 33ms (30 FPS)
4. **Face Detection** → Receive frameResult with detected faces
5. **UI Updates** → Display face bounding boxes and recognition status

## Message Protocol Analysis 📊

### **Expected Frame Message Format:**

**Outbound (Flutter → OWT):**
```json
{
  "type": "frame",
  "data": {
    "frameId": "frame_1703792400000",
    "timestamp": "2024-12-28T15:00:00.000Z",
    "imageData": "base64_encoded_frame_data",
    "format": "jpeg",
    "width": 640,
    "height": 640
  }
}
```

**Expected Response (OWT → Flutter):**
```json
{
  "type": "frameResult",
  "data": {
    "frameId": "frame_1703792400000",
    "timestamp": "2024-12-28T15:00:00.000Z",
    "faces": [
      {
        "faceId": "face_abc123",
        "box": [x, y, width, height],
        "confidence": 0.95,
        "isRecognized": true,
        "personId": "emp_001",
        "employeeName": "John Doe"
      }
    ],
    "status": "face_found"
  }
}
```

## Testing Checklist 📋

### **Real Device Testing Goals:**

- [ ] **WebSocket Connection**: Verify successful connection to OWT server
- [ ] **SSL/TLS Security**: Confirm encrypted communication 
- [ ] **Frame Transmission**: Test 30 FPS Base64 frame streaming
- [ ] **Response Processing**: Parse frameResult messages correctly
- [ ] **Face Detection UI**: Display bounding boxes and recognition data
- [ ] **Error Handling**: Test connection failure and retry logic
- [ ] **Performance**: Monitor memory usage and network efficiency

### **Production Readiness Verification:**

- [ ] **Authentication**: Verify if OWT server requires auth tokens
- [ ] **Rate Limiting**: Test server response to high-frequency requests
- [ ] **Data Format**: Confirm server accepts JPEG/Base64 format
- [ ] **Response Times**: Measure frame processing latency
- [ ] **Connection Stability**: Test long-duration streaming sessions

## Troubleshooting Notes 🔧

### **Known Observations:**

1. **Connection Established**: OWT server accepts WSS connections
2. **Silent Response**: Server doesn't respond to ping/frame messages in test
3. **Protocol Differences**: May require specific message format or authentication

### **Next Steps:**

1. **Flutter App Logs**: Monitor WebSocket connection status in debug mode
2. **Message Format**: Verify if OWT expects different frame data structure
3. **Authentication**: Check if server requires API keys or tokens
4. **Documentation**: Request OWT server API documentation if available

### **Fallback Options:**

- Mock server available at `scripts/mock_websocket_server.py`
- Local development server configuration in `websocket_config.dart`
- Alternative test endpoints for offline development

## Security Considerations 🔐

### **Production Security:**

- ✅ **Encrypted Connection**: WSS ensures data encryption in transit
- ✅ **Certificate Validation**: SSL certificate properly verified
- ⚠️ **Authentication**: May need to implement auth tokens
- ⚠️ **Data Privacy**: Ensure face data handling complies with privacy policies

### **Development Security:**

- Debug logging enabled for troubleshooting
- Production server used in development (should consider staging environment)
- Network traffic potentially visible in development tools

---

## Summary ✅

**Current Status**: **CONFIGURED & TESTING**

- ✅ OWT production server configuration complete
- ✅ WebSocket connection capability verified
- ✅ Flutter app rebuilt and deployed to Samsung Galaxy S23
- 🧪 Real device testing in progress

**Next Milestone**: Verify end-to-end face detection pipeline with OWT backend

---

**Integration By**: Claude Sonnet 4 (Flutter Dev Specialist)  
**Configuration Date**: December 28, 2024  
**Status**: Ready for OWT Backend Testing 