# FaceCheckIn Employee Product Requirements Document (PRD) v1.1

**Change Log**
| Change | Date | Version | Description | Author |
| :--- | :--- | :--- | :--- | :--- |
| Initial Draft | June 12, 2025 | 1.0 | First version of the PRD created. | John (PM) |
| Pivot to Auto-Stream | June 12, 2025 | 1.1 | Pivoted from manual Start/Stop interaction to an automatic 'Always Streaming' model for the MVP based on design session. | John (PM) |


## 1.0 Goals and Background Context

### 1.1 Goals

* [cite_start]**Enhance Check-in Efficiency**: Reduce the average check-in time per employee to under 3 seconds. [cite: 5]
* [cite_start]**High Adoption Rate**: Achieve over 95% of all daily check-ins through the new system by the end of the first quarter after launch. [cite: 6]
* [cite_start]**MVP Completion**: Successfully develop and deploy the MVP version of the application within a 2-week timeframe. [cite: 7, 15]

### 1.2 Background Context

[cite_start]This project aims to build a real-time facial recognition time-keeping application for employees. [cite: 1] [cite_start]Traditional time-keeping methods, particularly fingerprint-based check-in, are often time-consuming and can cause congestion at the entrance during peak hours. [cite: 2] [cite_start]The current process lacks seamlessness, requires physical interaction, and can be affected by external factors like blurry or wet fingerprints, diminishing employee efficiency and experience. [cite: 2] [cite_start]The new system will utilize a Flutter frontend application that continuously streams video to a backend for processing, providing a faster and more seamless check-in method. [cite: 3, 10, 16]

## 2.0 Requirements

### 2.1 Functional Requirements

* [cite_start]**FR1**: The system must provide a real-time facial recognition time-keeping function for employees. [cite: 1]
* **FR2**: The application must feature an always-on camera that automatically and continuously streams video to the backend for recognition processing upon launch.
* [cite_start]**FR3**: After a successful recognition, the system must display a simple, personalized greeting to the employee via a Toast Notification. [cite: 11]
* [cite_start]**FR4**: When the backend cannot recognize the user, the system must display a failure notification via a Toast Notification. [cite: 11]

### 2.2 Non-Functional Requirements

* [cite_start]**NFR1**: The frontend application must be built with Flutter and run on a fixed device (e.g., a tablet). [cite: 9, 15]
* [cite_start]**NFR2**: The average check-in time, from when a face is in frame until a response is displayed, must be under 3 seconds. [cite: 5]
* [cite_start]**NFR3**: The MVP must be developed and deployed within a 2-week timeframe. [cite: 7, 15]
* **NFR4**: The system depends on the availability of backend systems and APIs for video stream processing and recognition.
* [cite_start]**NFR5**: It is assumed that the facial recognition AI service meets the required accuracy and speed. [cite: 17]
* [cite_start]**NFR6**: All administrative functions for HR/Management are explicitly out of scope for this application. [cite: 8]
* [cite_start]**NFR7**: The application will not include any backup check-in methods (like PIN or QR code) for the MVP. [cite: 14]
* [cite_start]**NFR8**: The application will not include a "Not me" button or any mechanism to report incorrect recognition for the MVP. [cite: 14]

## 3.0 User Interface Design Goals

### 3.1 Overall UX Vision

The vision is to create a fast, efficient, and seamless check-in experience. The user interface should be clean, minimalist, and focused on providing immediate and clear feedback automatically.

### 3.2 Key Interaction Paradigms

The core interaction is "zero-touch". The application automatically starts the recognition process upon launch (after permissions are granted), requiring no manual action from the user.

### 3.3 Core Screens and Views

* **Main Screen (Live Camera View)**: The default and only screen. It displays the live camera preview and a simple, non-interactive text area at the bottom for debug information (to be removed in production).
* **Success Feedback**: Displayed as an auto-hiding Toast Notification (e.g., "Welcome, [User Name]!").
* **Failure Feedback**: Displayed as an auto-hiding Toast Notification (e.g., "Recognition Failed. Please try again.").

### 3.4 Accessibility

* **WCAG 2.1 AA**: Feedback needs to be accessible, using high-contrast text. Audible feedback is a post-MVP consideration.

### 3.5 Branding

* The **red** color from the company logo will be used as an accent color.

### 3.6 Target Device and Platforms

* [cite_start]A Flutter application running on a fixed device (e.g., a tablet). [cite: 9]

## 4.0 Technical Assumptions

### 4.1 Repository Structure

* **Polyrepo**: This project's repository will focus solely on the Flutter application, as the backend exists in a separate repo.

### 4.2 Service Architecture

* **Client-Server**: The Flutter application will act as a client, communicating with the existing backend system.

### 4.3 Testing Requirements

* **Manual Testing**: To check the overall workflow.
* **Unit Testing**: For business logic and critical components (BLoCs).
* **Widget Testing**: To test UI components in isolation.
* **End-to-End (E2E) Testing**: Out of scope for the MVP.

### 4.4 Additional Technical Assumptions and Requests

* [cite_start]**Framework**: The use of **Flutter** is mandatory. [cite: 15]
* **Communication Protocol**: Communication with the backend will be handled via **WebSocket**.
* **State Management**: The use of **BLoC** is mandatory.
* **Target Devices**: Tablets and phones with minimum OS versions of **Android API level 28** and **iOS 15**.

## 5.0 Epics

### Epic 1: Project Foundation & Core UI Shell

**Epic Goal**: To establish a solid technical foundation for the Flutter application, including project creation, backend integration setup, BLoC structure, and building the main UI that displays a live camera feed automatically upon launch.

#### **Story 1.1: Project Initialization & BLoC Structure**
* **As a** developer, **I want** to set up a new Flutter project with the required BLoC architecture and dependencies, **so that** we have a clean, structured foundation.
* **Acceptance Criteria**:
    1.  A new Flutter project is created.
    2.  The folder structure for BLoC is established.
    3.  Required dependencies (`flutter_bloc`, `web_socket_channel`) are added to `pubspec.yaml`.
    4.  The main screen is created with a top area for the camera and a bottom area for the debug view.
    5.  The app runs successfully, showing the placeholder layout.

#### **Story 1.2: Implement Live Camera Preview & Auto-Start**
* **As a** user, **I want** the application to show a live video feed from the camera immediately after granting permission, **so that** the check-in process can begin automatically.
* **Acceptance Criteria**:
    1.  The application correctly requests and handles camera permissions on startup.
    2.  If permission is granted, the live camera preview is displayed and the app transitions to a "streaming" state.
    3.  If permission is denied, a message is shown asking the user to grant camera permissions.

#### **Story 1.3: Implement Debug View**
* **As a** developer, **I want** a simple, scrollable text view on the main screen, **so that** I can log and observe internal states and messages during development.
* **Acceptance Criteria**:
    1.  A non-interactive, scrollable text area is present at the bottom of the main screen.
    2.  A logging utility is available that can append messages to this view.
    3.  This entire view must be built in a way that it can be completely removed from the production build using compile-time flags.

### Epic 2: Real-time Recognition & Feedback

**Epic Goal**: To implement the two-way communication flow with the backend via WebSocket, sending camera frames and displaying success/failure feedback to the user via Toast Notifications.

#### **Story 2.1: Establish WebSocket Connection Automatically**
* **As a** developer, **I want** to automatically establish a WebSocket connection to the backend server as soon as the app is ready, **so that** video data can be streamed for recognition without user interaction.
* **Acceptance Criteria**:
    1.  A WebSocket service is created to manage connection logic.
    2.  After the camera is initialized, the app automatically attempts to connect to the WebSocket URL.
    3.  Connection status ("Connecting...", "Established", "Failed") is logged to the debug view.
    4.  The connection is gracefully closed when the app is terminated.

#### **Story 2.2: Stream Camera Frames via WebSocket**
* **As a** developer, **I want** to capture frames from the live camera feed and send them through the active WebSocket connection, **so that** the backend can perform facial recognition.
* **Acceptance Criteria**:
    1.  When the app is in the "streaming" state, it begins capturing and processing frames.
    2.  Frames are formatted as required by the backend API (e.g., Base64 encoded).
    3.  Frames are sent via the WebSocket at a regular interval.
    4.  Frame streaming is handled efficiently to avoid performance issues.

#### **Story 2.3: Process Backend Responses & Display Toasts**
* **As a** user, **I want** to see immediate feedback via a Toast notification when the backend sends a recognition result, **so that** I know if my check-in was successful or not.
* **Acceptance Criteria**:
    1.  The app listens for incoming WebSocket messages.
    2.  On a "success" message, a success Toast is displayed with the user's name.
    3.  On a "failure" message, a failure Toast is displayed.
    4.  All Toasts automatically disappear after 3 seconds.

## Design Architect Prompt

This PRD for 'FaceCheckIn Employee' is complete. Please review it, paying close attention to the 'User Interface Design Goals' section. Your next task is to use this document to create the detailed 'UI/UX Specification' for the project.

## Architect Prompt

This PRD for 'FaceCheckIn Employee' is complete. Please review it, paying close attention to the 'Technical Assumptions' and the full set of requirements and stories. Your task is to use this document to create the overall 'Architecture Document' for the project.
