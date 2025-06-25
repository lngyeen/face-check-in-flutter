# API Reference

## WebSocket Communication Protocol

### Backend Configuration

* **Development Environment**: `wss://facedetection-ws.owt.vn`
* **Production Environment**: `wss://your_production_ws_url`
* **Protocols**: `WSS`
* **Connection Timeout**: 30 seconds
* **Retry Policy**: 3 attempts with 3-second delays
* **Authentication**: None (currently)
* **Status**: ✅ **Confirmed** - Backend ready at `wss://facedetection-ws.owt.vn`

### Client (Flutter App) to Server Message

* **Format**: The application sends a JSON string with a `type` and `image` field.
* **Payload Structure**:
  ```json
  {
    "type": "processFrame",
    "image": "<base64_encoded_image_string>"
  }
  ```

### Server to Client (Flutter App) Messages

The server will respond with a JSON message. The client will determine the outcome based on the contents of the `data.faces` array.

* **Client-Side Processing Logic**:
    * If `data.faces` array is **empty `[]`**: Treat as a **failure**.
    * If `data.faces` array **contains one or more objects**: Treat as a **success**. Use the first element (`data.faces[0]`) to display information.

* **Failure Response Structure**:
    ```json
    {
      "type": "frameResult",
      "data": {
        "faces": [],
        "faceImagePath": "",
        "cameraId": "1",
        "timestamp": "2025-06-12T09:00:00.000Z",
        "processingTime": 1000,
        "isCheckinSent": false
      }
    }
    ```

* **Success Response Structure** (Real Sample Data):
    ```json
    {
      "type": "frameResult",
      "data": {
        "faces": [
          {
            "faceId": "person_001",
            "isRecognized": true,
            "confidence": 0.92,
            "gender": "male",
            "age": 28,
            "mask": false,
            "bbox": [150, 120, 250, 220]
          }
        ],
        "faceImagePath": "https://storage.example.com/faces/camera1-2024-03-20T10:30:00.jpg",
        "cameraId": "camera_001",
        "timestamp": "2024-03-20T10:30:00.000Z",
        "processingTime": 250,
        "isCheckinSent": true,
        "originalSize": {"width": 1920, "height": 1080},
        "processedSize": {"width": 640, "height": 480},
        "annotatedImage": "base64_encoded_image_string_here"
      }
    }
    ```

### Key Events

* **Client-Side Processing Logic**:
    * If `data.faces` array is **empty `[]`**: Treat as a **failure**.
    * If `data.faces` array **contains one or more objects**: Treat as a **success**. Use the first element (`data.faces[0]`) to display information.

* **Failure Response Structure**:
    ```json
    {
      "type": "frameResult",
      "data": {
        "faces": [],
        "faceImagePath": "",
        "cameraId": "1",
        "timestamp": "2025-06-12T09:00:00.000Z",
        "processingTime": 1000,
        "isCheckinSent": false
      }
    }
    ```

* **Success Response Structure** (Real Sample Data):
    ```json
    {
      "type": "frameResult",
      "data": {
        "faces": [
          {
            "faceId": "person_001",
            "isRecognized": true,
            "confidence": 0.92,
            "gender": "male",
            "age": 28,
            "mask": false,
            "bbox": [150, 120, 250, 220]
          }
        ],
        "faceImagePath": "https://storage.example.com/faces/camera1-2024-03-20T10:30:00.jpg",
        "cameraId": "camera_001",
        "timestamp": "2024-03-20T10:30:00.000Z",
        "processingTime": 250,
        "isCheckinSent": true,
        "originalSize": {"width": 1920, "height": 1080},
        "processedSize": {"width": 640, "height": 480},
        "annotatedImage": "base64_encoded_image_string_here"
      }
    }
    ```

## Core Architecture

## HTTP Client & API Integration

### Dio HTTP Client
The app uses **Dio** as the primary HTTP client for all API communications.

#### Setup
```dart
final dio = Dio();
dio.options.baseUrl = 'https://your-api-base-url.com';
dio.options.connectTimeout = Duration(seconds: 5);
dio.options.receiveTimeout = Duration(seconds: 3);
```

#### Interceptors
The app includes several interceptors for enhanced functionality:

**1. Smart Retry Interceptor**
```dart
import 'package:dio_smart_retry/dio_smart_retry.dart';

dio.interceptors.add(RetryInterceptor(
  dio: dio,
  retries: 3,
  retryDelays: const [
    Duration(seconds: 1),
    Duration(seconds: 2), 
    Duration(seconds: 3),
  ],
));
```

**2. Refresh Token Interceptor**
```dart
import 'package:dio_refresh_token/dio_refresh_token.dart';

final tokenManager = TokenManagerImpl();
dio.interceptors.add(TokenInterceptor(
  tokenManager: tokenManager,
  tokenRefreshStrategy: tokenRefreshStrategy,
));
```

### Retrofit API Client Generator
For type-safe API client generation:

#### Define API Interface
```dart
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: 'https://api.example.com')
abstract class ApiClient {
  factory ApiClient(Dio dio, {String? baseUrl}) = _ApiClient;

  @GET('/face-detection')
  Future<FaceDetectionResponse> detectFace(@Body() FrameData frame);

  @POST('/auth/login')
  Future<AuthResponse> login(@Body() LoginRequest request);
}
```

#### Generate Code
```bash
dart run build_runner build --delete-conflicting-outputs
```

### Package Usage Summary

| Package | Purpose | Category |
|---------|---------|----------|
| `dio` | Modern HTTP client with interceptors | Main dependency |
| `dio_smart_retry` | Intelligent retry logic for failed requests | Main dependency |
| `dio_refresh_token` | Automatic token refresh on auth failures | Main dependency |
| `retrofit` | Type-safe REST API client generation | Main dependency |
| `retrofit_generator` | Code generator for Retrofit interfaces | Dev dependency |
| `dartz` | Functional programming tools (Either, Option, etc.) | Main dependency |

### Integration with Existing Architecture

The HTTP clients integrate seamlessly with the existing BLoC architecture:

```dart
class ApiRepository {
  final ApiClient _apiClient;
  
  ApiRepository(this._apiClient);
  
  Future<Either<Failure, FaceDetectionResponse>> detectFace(FrameData frame) async {
    try {
      final response = await _apiClient.detectFace(frame);
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
```

## Environment Configuration & Deployment

### Environment Variables with flutter_dotenv
The app uses **flutter_dotenv** for managing environment variables across different environments.

#### Setup
1. Create a `.env` file in the project root:
```bash
# API Configuration
API_BASE_URL=https://api.staging.example.com
API_KEY=your-api-key-here
DEBUG_MODE=true

# WebSocket Configuration
WS_BASE_URL=wss://ws.staging.example.com
WS_TIMEOUT=30000

# Feature Flags
ENABLE_DEBUG_PANEL=true
ENABLE_MOCK_DATA=false
```

2. Add the `.env` file to assets in `pubspec.yaml`:
```yaml
flutter:
  assets:
    - .env
```

3. Load environment variables in `main.dart`:
```dart
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Load environment variables
  await dotenv.load(fileName: ".env");
  
  runApp(MyApp());
}
```

4. Access variables throughout the app:
```dart
import 'package:flutter_dotenv/flutter_dotenv.dart';

final apiBaseUrl = dotenv.env['API_BASE_URL'] ?? 'https://api.default.com';
final isDebugMode = dotenv.getBool('DEBUG_MODE', fallback: false);
final apiTimeout = dotenv.getInt('API_TIMEOUT', fallback: 5000);
```

### App Flavors with flutter_flavorizr
The app uses **flutter_flavorizr** to manage different app flavors (development, staging, production).

#### Configuration
Create a `flavorizr.yaml` file in the project root:
```yaml
flavors:
  development:
    app:
      name: "Face Check-In Dev"
    android:
      applicationId: "com.owt.facecheckin.dev"
    ios:
      bundleId: "com.owt.facecheckin.dev"
    
  staging:
    app:
      name: "Face Check-In Staging"
    android:
      applicationId: "com.owt.facecheckin.staging"
    ios:
      bundleId: "com.owt.facecheckin.staging"
    
  production:
    app:
      name: "Face Check-In"
    android:
      applicationId: "com.owt.facecheckin"
    ios:
      bundleId: "com.owt.facecheckin"
```

#### Usage
1. Generate flavors:
```bash
flutter pub run flutter_flavorizr
```

2. Run specific flavors:
```bash
# Development
flutter run --flavor development

# Staging  
flutter run --flavor staging

# Production
flutter run --flavor production
```

3. Access current flavor in code:
```dart
import 'flavors.dart';

final currentFlavor = F.appFlavor;
final appName = F.title;

// Use different configurations based on flavor
String getApiBaseUrl() {
  switch (F.appFlavor) {
    case Flavor.development:
      return 'https://api.dev.example.com';
    case Flavor.staging:
      return 'https://api.staging.example.com';
    case Flavor.production:
      return 'https://api.example.com';
  }
}
```

#### Best Practices
- Use different `.env` files for each flavor (`.env.dev`, `.env.staging`, `.env.prod`)
- Different app icons and names for easy identification
- Separate Firebase projects for each flavor
- Different API endpoints and configurations per environment

### Environment Integration with Existing Architecture

#### DI Configuration
```dart
// lib/core/di/di.dart
@module
abstract class AppModule {
  @singleton
  Dio provideDio() {
    final dio = Dio();
    dio.options.baseUrl = dotenv.env['API_BASE_URL'] ?? 'https://api.default.com';
    dio.options.connectTimeout = Duration(
      milliseconds: dotenv.getInt('CONNECT_TIMEOUT', fallback: 5000),
    );
    return dio;
  }

  @singleton
  WebSocketService provideWebSocketService() {
    final wsUrl = dotenv.env['WS_BASE_URL'] ?? 'wss://ws.default.com';
    return WebSocketService(baseUrl: wsUrl);
  }
}
```

#### Debug Configuration
```dart
// lib/core/config/app_config.dart
class AppConfig {
  static bool get isDebugMode => dotenv.getBool('DEBUG_MODE', fallback: false);
  static bool get enableMockData => dotenv.getBool('ENABLE_MOCK_DATA', fallback: false);
  static bool get enableDebugPanel => dotenv.getBool('ENABLE_DEBUG_PANEL', fallback: false);
  
  static String get apiBaseUrl => dotenv.env['API_BASE_URL'] ?? _getDefaultApiUrl();
  
  static String _getDefaultApiUrl() {
    switch (F.appFlavor) {
      case Flavor.development:
        return 'https://api.dev.example.com';
      case Flavor.staging:
        return 'https://api.staging.example.com';
      case Flavor.production:
        return 'https://api.example.com';
    }
  }
}
```

## Functional Programming with Dartz

### Overview
The app uses **dartz** for functional programming patterns, providing robust error handling and data transformation capabilities.

### Core Concepts

#### Either<L, R> - Error Handling
`Either` represents a value that can be either a failure (Left) or success (Right):

```dart
import 'package:dartz/dartz.dart';

// API call result
Either<ApiError, UserData> result = await apiService.getUser();

result.fold(
  (error) => print('Error: ${error.message}'),
  (userData) => print('Success: ${userData.name}'),
);
```

#### Option<T> - Null Safety
`Option` represents a value that may or may not exist:

```dart
Option<String> userName = some('John Doe');
Option<String> emptyName = none();

userName.fold(
  () => print('No name provided'),
  (name) => print('Hello, $name'),
);
```

### Practical Usage in Face Check-In App

#### 1. API Response Handling
```dart
// Repository layer
Future<Either<CheckInError, CheckInResult>> submitCheckIn(
  CheckInRequest request,
) async {
  try {
    final response = await _apiService.submitCheckIn(request);
    return right(CheckInResult.fromJson(response.data));
  } catch (e) {
    return left(CheckInError.networkError(e.toString()));
  }
}

// BLoC layer
void _onSubmitCheckIn(SubmitCheckIn event, Emitter<CheckInState> emit) async {
  emit(state.copyWith(status: CheckInStatus.submitting));
  
  final result = await _repository.submitCheckIn(event.request);
  
  result.fold(
    (error) => emit(state.copyWith(
      status: CheckInStatus.failure,
      error: error,
    )),
    (success) => emit(state.copyWith(
      status: CheckInStatus.success,
      result: success,
    )),
  );
}
```

#### 2. Configuration Validation
```dart
Either<ConfigError, AppConfig> validateConfig() {
  final apiUrl = dotenv.env['API_BASE_URL'];
  if (apiUrl == null || apiUrl.isEmpty) {
    return left(ConfigError.missingApiUrl());
  }
  
  return right(AppConfig(apiUrl: apiUrl));
}
```

#### 3. Image Processing Pipeline
```dart
Either<ProcessingError, ProcessedImage> processImage(CameraImage image) {
  return validateImage(image)
    .flatMap(convertToBytes)
    .flatMap(compressImage)
    .flatMap(encodeBase64);
}

Either<ProcessingError, CameraImage> validateImage(CameraImage image) {
  if (image.width < 100 || image.height < 100) {
    return left(ProcessingError.imageTooSmall());
  }
  return right(image);
}
```

### Benefits in the App Architecture

1. **Type Safety**: Compile-time guarantees about error handling
2. **Explicit Error Paths**: No hidden exceptions, all errors are handled explicitly  
3. **Composability**: Chain operations safely with `flatMap` and `map`
4. **Immutability**: Functional data structures prevent accidental mutations
5. **Testing**: Easier to test pure functions with predictable inputs/outputs

### Integration with BLoC Pattern
Dartz works seamlessly with the existing BLoC architecture:

```dart
// Clean separation of concerns
class CheckInBloc extends Bloc<CheckInEvent, CheckInState> {
  final CheckInRepository _repository;
  
  CheckInBloc(this._repository) : super(CheckInInitial()) {
    on<SubmitCheckIn>(_onSubmitCheckIn);
  }
  
  void _onSubmitCheckIn(SubmitCheckIn event, Emitter<CheckInState> emit) async {
    final result = await _repository.submitCheckIn(event.request);
    
    // Functional error handling
    emit(result.fold(
      (error) => CheckInFailure(error),
      (success) => CheckInSuccess(success),
    ));
  }
}
``` 