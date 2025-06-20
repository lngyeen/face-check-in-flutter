# Operational Guidelines

## Coding Standards

* **Linter Adherence**: Strictly follow the rules defined in the `flutter_lints` package.
* **Code Generation**: After changing any model or state file annotated with `@freezed`, the developer must run the command `flutter pub run build_runner build --delete-conflicting-outputs` to update the generated files.
* **Naming Conventions**: `PascalCase` for classes/enums, `camelCase` for variables/methods, `snake_case` for filenames.
* **BLoC Pattern**: The UI must only interact with a BLoC. States must be immutable (enforced by `freezed`).
* **Asynchronous Code**: Always use `async`/`await` and `Future` objects for asynchronous operations.

## Testing Strategy

### Unit Tests
* **Scope**: Focus on testing all business logic independently. This includes all logic within BLoCs, calculation functions, and data processing utilities.
* **Requirement**: All BLoCs and files containing critical logic must have corresponding unit tests.

### Widget Tests
* **Scope**: Focus on testing individual widgets to ensure they render correctly and react to state changes from their BLoC (e.g., verifying a Toast is displayed on a `Success` state).

### Test Coverage Target
* For this MVP, a minimum Unit Test coverage of **70%** is targeted for files containing business logic (especially BLoC files). The quality of test cases remains the top priority.

### Integration & E2E Tests
* These are out of scope for the MVP.

## Error Handling Strategy

### WebSocket Connection Management
* **Backend URL**: `wss://facedetection-ws.owt.vn` (Development Environment - Confirmed Ready)
* **Connection Failure**: The `WebSocketService` will automatically attempt to **reconnect 3 times**, with a 3-second delay between each attempt. If all retries fail, an error state will be triggered in the UI.
* **Connection Timeout**: If connection cannot be established within **30 seconds**, treat as timeout error.
* **Connection Loss During Streaming**: Automatically pause streaming, attempt reconnection, resume when connection restored.

### Backend Service Dependency Risks
* **Backend Unavailability**: 
  - **Development**: Backend confirmed available at `wss://facedetection-ws.owt.vn`
  - **Testing**: Real backend responses available for testing
  - **Graceful Degradation**: Show "Backend unavailable" status to user
  - **Backup Plan**: Use mock WebSocket server if needed
* **API Response Timeout**: If no response received within **30 seconds** of streaming start, stop streaming and reset state
* **Invalid Backend Responses**: Log malformed messages, continue operation without crashing
* **Backend Version Mismatch**: Implement version checking in WebSocket handshake
* **API Changes**:
  - **Monitoring**: Regular checks with the backend team for upcoming changes.
  - **Mitigation**: Use of data contracts (`freezed` models) to detect breaking changes early.

### Security Best Practices
* **Data Processing**: Ensure no persistent storage of sensitive image data
* **Memory Management**: Implement frame dropping and quality reduction under memory pressure
* **Network Security**: Handle SSL certificate validation for development environments
* **Privacy**: All image data is processed in real-time without local storage 