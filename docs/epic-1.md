# Epic 1: Project Foundation & Core UI Shell

**Epic Goal**: To establish a solid technical foundation for the Flutter application, including project creation, backend integration setup, BLoC structure, and building the main UI that displays a live camera feed automatically upon launch.

## **Story 1.1: Project Initialization & BLoC Structure**
* **As a** developer, **I want** to set up a new Flutter project with the required BLoC architecture and dependencies, **so that** we have a clean, structured foundation.
* **Acceptance Criteria**:
    1.  A new Flutter project is created.
    2.  The folder structure for BLoC is established.
    3.  Required dependencies (`flutter_bloc`, `web_socket_channel`) are added to `pubspec.yaml`.
    4.  The main screen is created with a top area for the camera and a bottom area for the debug view.
    5.  The app runs successfully, showing the placeholder layout.

## **Story 1.2: Implement Live Camera Preview & Auto-Start**
* **As a** user, **I want** the application to show a live video feed from the camera immediately after granting permission, **so that** the check-in process can begin automatically.
* **Acceptance Criteria**:
    1.  The application correctly requests and handles camera permissions on startup.
    2.  If permission is granted, the live camera preview is displayed and the app transitions to a "streaming" state.
    3.  If permission is denied, a message is shown asking the user to grant camera permissions.

## **Story 1.3: Implement Debug View**
* **As a** developer, **I want** a simple, scrollable text view on the main screen, **so that** I can log and observe internal states and messages during development.
* **Acceptance Criteria**:
    1.  A non-interactive, scrollable text area is present at the bottom of the main screen.
    2.  A logging utility is available that can append messages to this view.
    3.  This entire view must be built in a way that it can be completely removed from the production build using compile-time flags. 