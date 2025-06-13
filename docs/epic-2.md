# Epic 2: Real-time Recognition & Feedback

**Epic Goal**: To implement the two-way communication flow with the backend via WebSocket, sending camera frames and displaying success/failure feedback to the user via Toast Notifications.

## **Story 2.1: Establish WebSocket Connection Automatically**
* **As a** developer, **I want** to automatically establish a WebSocket connection to the backend server as soon as the app is ready, **so that** video data can be streamed for recognition without user interaction.
* **Acceptance Criteria**:
    1.  A WebSocket service is created to manage connection logic.
    2.  After the camera is initialized, the app automatically attempts to connect to the WebSocket URL.
    3.  Connection status ("Connecting...", "Established", "Failed") is logged to the debug view.
    4.  The connection is gracefully closed when the app is terminated.

## **Story 2.2: Stream Camera Frames via WebSocket**
* **As a** developer, **I want** to capture frames from the live camera feed and send them through the active WebSocket connection, **so that** the backend can perform facial recognition.
* **Acceptance Criteria**:
    1.  When the app is in the "streaming" state, it begins capturing and processing frames.
    2.  Frames are formatted as required by the backend API (e.g., Base64 encoded).
    3.  Frames are sent via the WebSocket at a regular interval.
    4.  Frame streaming is handled efficiently to avoid performance issues.

## **Story 2.3: Process Backend Responses & Display Toasts**
* **As a** user, **I want** to see immediate feedback via a Toast notification when the backend sends a recognition result, **so that** I know if my check-in was successful or not.
* **Acceptance Criteria**:
    1.  The app listens for incoming WebSocket messages.
    2.  On a "success" message, a success Toast is displayed with the user's name.
    3.  On a "failure" message, a failure Toast is displayed.
    4.  All Toasts automatically disappear after 3 seconds. 