# Medix - Medical Management System

<div align="center">

![Flutter](https://img.shields.io/badge/Flutter-3.8.1-02569B?style=for-the-badge&logo=flutter)
![Dart](https://img.shields.io/badge/Dart-3.8.1-0175C2?style=for-the-badge&logo=dart)
![GetX](https://img.shields.io/badge/GetX-4.6.6-8B5CF6?style=for-the-badge)
![Firebase](https://img.shields.io/badge/Firebase-4.1.0-FFCA28?style=for-the-badge&logo=firebase)
![License](https://img.shields.io/badge/License-Private-red?style=for-the-badge)

**A comprehensive medical management application for healthcare professionals and administrators**

[Features](#-key-features) • [Architecture](#-architecture) • [Installation](#-installation) • [Usage](#-usage) • [API Documentation](#-api-integration)

</div>

---

## 📋 Table of Contents

- [Overview](#-overview)
- [Key Features](#-key-features)
- [Architecture](#-architecture)
- [Tech Stack](#-tech-stack)
- [Project Structure](#-project-structure)
- [Installation](#-installation)
- [Configuration](#-configuration)
- [User Roles](#-user-roles)
- [Features Documentation](#-features-documentation)
- [API Integration](#-api-integration)
- [State Management](#-state-management)
- [Local Database](#-local-database)
- [Firebase Integration](#-firebase-integration)
- [Development Notes](#-development-notes)
- [Contributing](#-contributing)

---

## 🎯 Overview

**Medix** is a sophisticated medical management system built with Flutter, designed to streamline healthcare workflows for both trainees and administrators. The application provides comprehensive tools for managing Standard Operating Procedures (SOPs), creating medical reports, performing medical calculations, handling emergency protocols, and utilizing AI-powered triage assistance.

### Application Purpose

- **Medical Documentation**: Create, manage, and access SOPs and medical reports
- **Emergency Response**: Quick access to emergency protocols and procedures
- **Clinical Calculations**: Medical dose calculators with safety checks
- **AI Triage**: Intelligent chatbot for medical triage assistance
- **User Management**: Complete admin panel for user and content management
- **Offline Support**: Local database for draft management and offline functionality

---

## ✨ Key Features

### 👨‍⚕️ For Trainees

- **📱 Home Dashboard**
  - Recent activity tracking
  - Quick access to protocols and reports
  - Personalized user interface

- **📋 Protocol Management**
  - Browse and search medical protocols
  - Filter by jurisdiction, priority, and category
  - Detailed protocol view with step-by-step instructions
  - Equipment and contraindications information

- **📝 Report Creation**
  - Create incident reports with comprehensive details
  - Patient information management
  - Image attachment support
  - Draft system with local storage
  - Submit reports directly to backend

- **🧮 Medical Calculator**
  - Epinephrine dosage calculation
  - Hydrocortisone calculation
  - Chlorpheniramine calculation
  - Lidocaine calculation
  - Safety classification system
  - Quick reference medicine guide
  - Copy results functionality

- **🚨 Emergency Protocols**
  - Quick access to critical procedures
  - Category-based filtering (Anaphylaxis, Cardiac, Respiratory)
  - Step-by-step emergency instructions

- **🤖 AI Triage Assistant**
  - Real-time chat interface
  - Image upload support for symptoms
  - Complication detection
  - Emergency protocol suggestions
  - Chat history management

- **📊 Reports View**
  - View all submitted reports
  - Filter and search functionality
  - Detailed report information

### 👨‍💼 For Administrators

- **📊 Dashboard**
  - System statistics overview
  - Recent activity monitoring
  - User management metrics
  - Medicine database management

- **📋 SOP Management**
  - Create new SOPs with rich content
  - Edit existing SOPs
  - Publication status control (Draft, Published, Archived)
  - Priority management (Low, Medium, High, Critical)
  - Multi-jurisdiction support
  - Protocol steps builder
  - Medication association
  - Equipment and contraindications
  - Draft system with local storage
  - Bulk operations support

- **👥 User Management**
  - View all users (Trainees, Admins, Super Admins)
  - Create new user accounts
  - Edit user information
  - Approve/reject user registrations
  - Delete user accounts
  - Role-based access control
  - User status tracking

- **💊 Medicine Database**
  - Add new medications
  - Update medicine information
  - Dosage and administration details
  - Integration with calculator

---

## 🏗 Architecture

The application follows **Clean Architecture** principles with **MVC (Model-View-Controller)** pattern:

```
┌─────────────────────────────────────────────────────────────┐
│                      Presentation Layer                      │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐      │
│  │    Views     │  │  Controllers │  │   Widgets    │      │
│  │  (Screens)   │◄─┤   (GetX)     │  │  (Reusable)  │      │
│  └──────────────┘  └──────────────┘  └──────────────┘      │
└─────────────────────────────────────────────────────────────┘
                              │
┌─────────────────────────────────────────────────────────────┐
│                      Business Logic Layer                    │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐      │
│  │   Services   │  │   Managers   │  │   Helpers    │      │
│  │   (API)      │  │  (Network)   │  │  (Utilities) │      │
│  └──────────────┘  └──────────────┘  └──────────────┘      │
└─────────────────────────────────────────────────────────────┘
                              │
┌─────────────────────────────────────────────────────────────┐
│                         Data Layer                           │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐      │
│  │    Models    │  │  Local DB    │  │   Network    │      │
│  │   (Entities) │  │ (GetStorage) │  │  (HTTP API)  │      │
│  └──────────────┘  └──────────────┘  └──────────────┘      │
└─────────────────────────────────────────────────────────────┘
```

### Design Patterns Used

- **MVC Pattern**: Separation of concerns between UI, business logic, and data
- **Repository Pattern**: Abstract data sources
- **Singleton Pattern**: Single instances for services (NetworkManager, LocalDataService)
- **Observer Pattern**: Reactive state management with GetX
- **Factory Pattern**: Model serialization/deserialization

---

## 🛠 Tech Stack

### Frontend Framework
- **Flutter 3.8.1**: Cross-platform UI framework
- **Dart 3.8.1**: Programming language

### State Management
- **GetX 4.6.6**: Reactive state management, dependency injection, and routing
- **Get Storage 2.1.1**: Fast key-value storage

### Backend Integration
- **HTTP 1.1.0**: REST API communication
- **JSON Serialization**: Data parsing and serialization

### UI/UX
- **Flutter ScreenUtil 5.9.3**: Responsive design
- **Google Fonts 6.3.0**: Custom typography
- **Flutter SVG 2.2.0**: Vector graphics
- **Iconsax 0.0.8**: Icon library
- **Shimmer 3.0.0**: Loading animations
- **Flutter Easy Loading 3.0.5**: Loading indicators

### Local Storage
- **Get Storage 2.1.1**: Simple key-value database
- **Hive 2.2.3**: NoSQL database (draft system)
- **Shared Preferences 2.3.2**: Persistent storage

### Firebase Services
- **Firebase Core 4.1.0**: Firebase initialization
- **Firebase Messaging 16.0.1**: Push notifications
- **Flutter Local Notifications 19.4.2**: Local notification handling

### Utilities
- **Logger 2.0.1**: Advanced logging
- **Image Picker 1.2.0**: Camera and gallery access
- **URL Launcher 6.1.12**: External URL handling
- **Connectivity Plus 6.1.5**: Network connectivity monitoring
- **Intl 0.18.1**: Internationalization
- **Pin Code Fields 8.0.1**: OTP input
- **Package Info Plus 9.0.0**: App version info
- **Path Provider 2.1.5**: File system paths

### UI Components
- **Dropdown Model List 3.0.2**: Advanced dropdown widgets
- **Flutter Advanced Avatar 1.5.2**: Avatar components

### Development Tools
- **Build Runner 2.4.13**: Code generation
- **JSON Serializable 6.8.0**: JSON serialization
- **Hive Generator 2.0.1**: Hive type adapters
- **Flutter Launcher Icons 0.14.1**: App icon generation
- **Flutter Lints 5.0.0**: Code quality

---

## 📁 Project Structure

```
lib/
├── main.dart                       # Application entry point
├── app.dart                        # App widget configuration
├── firebase_options.dart           # Firebase configuration
│
├── core/                           # Core application modules
│   ├── api_service/
│   │   └── NetworkCaller.dart     # Centralized HTTP client
│   ├── bindings/
│   │   └── controller_binder.dart # Global GetX bindings
│   ├── services/
│   │   └── local_data_service.dart # Local storage service
│   ├── utils/
│   │   ├── constants/             # App constants
│   │   │   └── api_constants.dart # API endpoints
│   │   ├── theme/                 # App theming
│   │   ├── helpers/               # Helper functions
│   │   ├── validators/            # Form validators
│   │   ├── formatters/            # Data formatters
│   │   ├── manager/               # App managers
│   │   │   └── network_manager.dart # Network status
│   │   └── logging/               # Logging utilities
│
├── routes/
│   └── app_route.dart             # Route definitions
│
├── features/                       # Feature modules
│   │
│   ├── common/                    # Shared features
│   │   ├── authentication/        # Auth module
│   │   │   ├── login/
│   │   │   │   ├── controller/
│   │   │   │   │   ├── login_controller.dart
│   │   │   │   │   ├── signup_controller.dart
│   │   │   │   │   └── jurisdiction_controller.dart
│   │   │   │   ├── views/
│   │   │   │   │   ├── screens/
│   │   │   │   │   └── widgets/
│   │   │   │   └── models/
│   │   │   ├── forgot_password/
│   │   │   │   ├── controllers/
│   │   │   │   └── services/
│   │   │   └── services/
│   │   │       ├── auth_services.dart
│   │   │       └── storage_services.dart
│   │   │
│   │   ├── notification/          # Push notifications
│   │   │   └── notification_controller.dart
│   │   │
│   │   └── settings/              # App settings
│   │       ├── controllers/
│   │       ├── services/
│   │       └── views/
│   │
│   ├── trainee_flow/              # Trainee features
│   │   ├── bottom_nav_bar/        # Navigation
│   │   │   ├── ui/
│   │   │   └── controllers/
│   │   │
│   │   ├── home/                  # Home dashboard
│   │   │   ├── controllers/
│   │   │   │   └── home_controller.dart
│   │   │   ├── models/
│   │   │   └── ui/
│   │   │
│   │   ├── protocols/             # Protocol browsing
│   │   │   ├── controllers/
│   │   │   │   └── protocols_controller.dart
│   │   │   ├── models/
│   │   │   └── ui/
│   │   │
│   │   ├── create_report/         # Report creation
│   │   │   ├── controllers/
│   │   │   │   └── create_report_controller.dart
│   │   │   ├── models/
│   │   │   │   └── simple_draft_report_model.dart
│   │   │   └── views/
│   │   │
│   │   ├── reports/               # Report viewing
│   │   │   ├── controllers/
│   │   │   ├── models/
│   │   │   └── views/
│   │   │
│   │   ├── calculator/            # Medical calculator
│   │   │   ├── controllers/
│   │   │   │   └── calculator_controller.dart
│   │   │   ├── models/
│   │   │   └── views/
│   │   │
│   │   ├── emergency_protocols/   # Emergency procedures
│   │   │   ├── controllers/
│   │   │   ├── models/
│   │   │   └── views/
│   │   │
│   │   └── triage/                # AI triage assistant
│   │       ├── controllers/
│   │       │   └── triage_controller.dart
│   │       ├── models/
│   │       ├── services/
│   │       └── views/
│   │
│   └── admin_flow/                # Admin features
│       ├── bottom_nav_bar/        # Admin navigation
│       │   └── views/
│       │
│       ├── dashboard_section/     # Admin dashboard
│       │   ├── dashboard/
│       │   │   ├── controller/
│       │   │   │   └── dashboard_controller.dart
│       │   │   ├── models/
│       │   │   └── views/
│       │   │
│       │   ├── add_new_sop/       # SOP creation
│       │   │   ├── controller/
│       │   │   │   ├── add_new_sop_controller.dart
│       │   │   │   └── draft_sop_list_controller.dart
│       │   │   ├── models/
│       │   │   │   └── simple_draft_sop_model.dart
│       │   │   └── views/
│       │   │
│       │   └── add_new_user/      # User creation
│       │       ├── controller/
│       │       │   └── add_new_user_controller.dart
│       │       ├── models/
│       │       └── views/
│       │
│       ├── sops_section/          # SOP management
│       │   ├── sops/              # SOP list
│       │   │   ├── controller/
│       │   │   ├── models/
│       │   │   └── views/
│       │   │
│       │   └── sop_view/          # SOP details
│       │       ├── controller/
│       │       ├── models/
│       │       └── views/
│       │
│       └── user_section/          # User management
│           ├── user_management/   # User list
│           │   ├── controller/
│           │   │   └── user_management_controller.dart
│           │   ├── models/
│           │   └── views/
│           │
│           └── edit_user/         # User editing
│               ├── controller/
│               ├── models/
│               └── views/
│
├── assets/
│   ├── icons/                     # App icons
│   │   └── applogo.png
│   └── images/                    # Images
│
└── notes/                         # Development notes
    ├── add_new_sop_api_integration_complete.md
    ├── create_report_api_integration_implementation.md
    ├── medicine_api_integration_calculator.md
    └── ... (40+ documentation files)
```

---

## 🚀 Installation

### Prerequisites

- Flutter SDK 3.8.1 or higher
- Dart SDK 3.8.1 or higher
- Android Studio / VS Code with Flutter plugins
- Xcode (for iOS development on macOS)
- Git

### Setup Steps

1. **Clone the repository**
```bash
git clone <repository-url>
cd medix-main
```

2. **Install dependencies**
```bash
flutter pub get
```

3. **Generate required files**
```bash
# Generate Hive type adapters and JSON serialization
flutter pub run build_runner build --delete-conflicting-outputs
```

4. **Generate app icons**
```bash
flutter pub run flutter_launcher_icons
```

5. **Run the application**
```bash
# Run on connected device/emulator
flutter run

# Run in debug mode
flutter run --debug

# Run in release mode
flutter run --release

# Run on specific device
flutter run -d <device-id>
```

---

## ⚙️ Configuration

### API Configuration

Edit `lib/core/utils/constants/api_constants.dart`:

```dart
// Base URLs
const String baseUrl = "http://72.60.199.45:3000/api";
const String aIbaseUrl = "http://72.60.199.45:8000/api/v1/";

// Update endpoints as needed
const String getAllUsersEndpoint = "/admin/user";
const String createSOPEndpoint = "/sop";
// ... more endpoints
```

### Firebase Configuration

1. **Add Firebase configuration files:**
   - Android: `android/app/google-services.json`
   - iOS: `ios/Runner/GoogleService-Info.plist`

2. **Firebase options are auto-generated in:**
   - `lib/firebase_options.dart`

3. **Firebase features enabled:**
   - Firebase Core
   - Firebase Messaging (Push Notifications)
   - Cloud Messaging

### Environment Variables

Create `.env` file (if using):
```
API_BASE_URL=http://your-api-url.com/api
AI_BASE_URL=http://your-ai-url.com/api/v1/
```

---

## 👥 User Roles

### 1. Trainee
- **Access Level**: Basic user
- **Capabilities**:
  - View protocols and SOPs
  - Create and submit reports
  - Use medical calculators
  - Access emergency protocols
  - Use AI triage assistant
  - View personal activity history

### 2. Admin
- **Access Level**: Administrative user
- **Capabilities**:
  - All Trainee capabilities
  - Create, edit, and delete SOPs
  - Manage users (CRUD operations)
  - View dashboard statistics
  - Manage medicine database
  - Approve/reject user registrations
  - Monitor system activity

### 3. Super Admin
- **Access Level**: Highest administrative level
- **Capabilities**:
  - All Admin capabilities
  - System-wide configuration
  - Advanced user management
  - Full access to all features

### Role-Based Routing

```dart
// Initial route determination based on role
if (token == null || token.isEmpty) {
  initialRoute = AppRoute.getLoginScreen();
} else {
  switch (role) {
    case 'TRAINEE':
      initialRoute = AppRoute.getBottomNavBarScreen();
      break;
    case 'ADMIN':
    case 'SUPER_ADMIN':
      initialRoute = AppRoute.getBottomNavbarAdmin();
      break;
    default:
      initialRoute = AppRoute.getLoginScreen();
  }
}
```

---

## 📖 Features Documentation

### Authentication System

**Login Flow:**
1. User enters email and password
2. App sends credentials to `/auth/login`
3. Server validates and returns JWT token
4. Token stored in GetStorage
5. User role determines initial screen

**Signup Flow:**
1. User fills registration form
2. Selects jurisdiction
3. App sends data to `/auth/signup`
4. Account created with "Pending" status
5. Admin approval required

**Forgot Password:**
1. User enters email
2. OTP sent via email
3. User verifies OTP
4. User sets new password

### SOP Management (Admin)

**Creating SOP:**
- Title, jurisdiction, category
- Protocol steps (dynamic list)
- Associated medications
- Equipment requirements
- Contraindications
- Publication status and priority
- Tags for categorization
- Draft system for incomplete SOPs

**Editing SOP:**
- Load existing SOP data
- Modify any field
- Update publication status
- Save changes to backend

**Draft System:**
- Local storage using GetStorage
- Save incomplete SOPs
- Load drafts for completion
- Delete drafts after publishing

### Report Creation (Trainee)

**Report Fields:**
- Incident title
- Procedure performed
- Severity level
- Patient demographics (age, sex)
- Clinical findings
- Complications
- Treatment details
- Image attachments

**Draft System:**
- Auto-save functionality
- Local storage
- Resume incomplete reports
- Submit when ready

### Medical Calculator

**Supported Calculations:**

1. **Epinephrine**
   - Adult: Fixed 0.3mg dose
   - Pediatric: 0.01mg/kg (max 0.3mg)
   - Route: Intramuscular

2. **Hydrocortisone**
   - Adult: 200mg fixed dose
   - Pediatric: Weight-based
   - Route: IV/IM

3. **Chlorpheniramine**
   - Age-based dosing
   - Safety checks

4. **Lidocaine**
   - Weight-based calculation
   - Maximum dose limits

**Safety Features:**
- Automatic safety classification
- Clinical warnings
- Review required alerts
- Copy to clipboard functionality

### AI Triage Assistant

**Features:**
- Real-time chat interface
- Image upload for symptoms
- Complication detection
- Emergency protocol suggestions
- Chat history
- Category-based filtering

**Integration:**
- REST API: `POST /triage/chat`
- Image support via multipart/form-data
- Real-time response parsing

---

## 🔌 API Integration

### Network Caller Service

Centralized HTTP client in `NetworkCaller.dart`:

```dart
// POST Request
final response = await NetworkCaller.postRequest(
  endpoint: '/endpoint',
  body: {'key': 'value'},
);

// GET Request
final response = await NetworkCaller.getRequest(
  endpoint: '/endpoint',
  queryParams: {'param': 'value'},
);

// PUT Request
final response = await NetworkCaller.putRequest(
  endpoint: '/endpoint',
  body: {'key': 'value'},
);

// DELETE Request
final response = await NetworkCaller.deleteRequest(
  endpoint: '/endpoint',
);
```

### API Endpoints

**Authentication:**
- `POST /auth/login` - User login
- `POST /auth/signup` - User registration
- `POST /auth/forget-password` - Password reset

**User Management:**
- `GET /admin/user` - Get all users
- `GET /admin/user/{id}` - Get user by ID
- `POST /admin/user` - Create user
- `PUT /admin/approve/{id}` - Update/approve user
- `DELETE /admin/user/{id}` - Delete user

**SOP Management:**
- `GET /sop` - Get all SOPs
- `GET /sop/{id}` - Get SOP by ID
- `POST /sop` - Create SOP
- `PUT /sop/{id}` - Update SOP
- `DELETE /sop/{id}` - Delete SOP

**Report Management:**
- `POST /report` - Create report
- `GET /report/{id}` - Get report by ID

**Dashboard:**
- `GET /admin` - Dashboard summary
- `GET /admin/recentActivity` - Recent activity
- `GET /user/recent-activity` - User activity

**Medicine:**
- `POST /medicine` - Create medicine
- `GET /medicine` - Get all medicines

**AI Services:**
- `POST /triage/chat` - AI triage chat
- `POST /calculate` - Medical calculations

### Error Handling

```dart
try {
  final response = await NetworkCaller.getRequest(
    endpoint: endpoint,
  );
  
  if (response.statusCode == 200) {
    // Success
    final data = jsonDecode(response.body);
  } else {
    // Error
    final error = jsonDecode(response.body);
    throw Exception(error['message']);
  }
} on SocketException {
  throw Exception('No internet connection');
} on HttpException {
  throw Exception('HTTP error occurred');
} catch (e) {
  throw Exception('Unexpected error: $e');
}
```

---

## 🎮 State Management

### GetX Controllers

**Controller Lifecycle:**
```dart
class ExampleController extends GetxController {
  // Observable variables
  final RxString data = ''.obs;
  final RxBool isLoading = false.obs;
  final RxList<Model> items = <Model>[].obs;
  
  @override
  void onInit() {
    super.onInit();
    // Initialize
    fetchData();
  }
  
  @override
  void onReady() {
    super.onReady();
    // Called after widget is rendered
  }
  
  @override
  void onClose() {
    // Cleanup
    super.onClose();
  }
  
  // Business logic methods
  Future<void> fetchData() async {
    isLoading.value = true;
    try {
      // API call
      data.value = 'Fetched data';
    } finally {
      isLoading.value = false;
    }
  }
}
```

**Usage in UI:**
```dart
class ExampleScreen extends StatelessWidget {
  final controller = Get.put(ExampleController());
  
  @override
  Widget build(BuildContext context) {
    return Obx(() => Text(controller.data.value));
  }
}
```

### Global Bindings

```dart
class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    // Singleton services
    Get.put(NetworkManager(), permanent: true);
    
    // Lazy controllers
    Get.lazyPut(() => HomeController(), fenix: true);
  }
}
```

---

## 💾 Local Database

### GetStorage Implementation

**Local Data Service:**
```dart
class LocalDataService {
  static final GetStorage _storage = GetStorage();
  
  // Save draft SOP
  static Future<bool> saveDraftSOP(SimpleDraftSOPModel draft) async {
    final drafts = _getAllSOPDraftsAsJson();
    drafts.add(draft.toJson());
    await _storage.write('draft_sops', drafts);
    return true;
  }
  
  // Get all drafts
  static List<SimpleDraftSOPModel> getAllDraftSOPs() {
    final draftsJson = _getAllSOPDraftsAsJson();
    return draftsJson.map((json) => 
      SimpleDraftSOPModel.fromJson(json)
    ).toList();
  }
  
  // Delete draft
  static Future<bool> deleteDraftSOP(String id) async {
    final drafts = _getAllSOPDraftsAsJson();
    drafts.removeWhere((draft) => draft['id'] == id);
    await _storage.write('draft_sops', drafts);
    return true;
  }
}
```

**Draft Models:**

1. **SimpleDraftSOPModel** - Stores incomplete SOP data
2. **SimpleDraftReportModel** - Stores incomplete report data

**Storage Keys:**
- `authToken` - JWT authentication token
- `userRole` - User role (TRAINEE/ADMIN/SUPER_ADMIN)
- `userId` - Current user ID
- `draft_sops` - List of draft SOPs
- `draft_reports` - List of draft reports

---

## 🔥 Firebase Integration

### Push Notifications

**NotificationController:**
- Handles FCM token registration
- Listens for foreground messages
- Displays local notifications
- Manages notification permissions

**Setup:**
```dart
// Initialize Firebase
await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform
);

// Initialize NotificationController
Get.put(NotificationController(), permanent: true);

// Request permissions
await FirebaseMessaging.instance.requestPermission();
```

**Notification Handling:**
- Foreground: Local notification display
- Background: System tray notification
- Terminated: System handles notification

---

## 📝 Development Notes

The `notes/` directory contains 40+ detailed implementation documents:

### Key Documentation Files

1. **API Integration:**
   - `add_new_sop_api_integration_complete.md`
   - `create_report_api_integration_implementation.md`
   - `medicine_api_integration_calculator.md`
   - `publication_status_restored_api_integration.md`

2. **Feature Implementation:**
   - `calculator_screen_implementation.md`
   - `draft_report_local_storage_implementation.md`
   - `draft_sop_local_storage_implementation_complete.md`
   - `edit_sop_functionality_implementation_complete.md`

3. **Bug Fixes:**
   - `bug_fixes_summary_sept_30_2025.md`
   - `logout_issue_final_fix.md`
   - `duplicate_globalkey_error_fix.md`

4. **UI/UX Updates:**
   - `protocol_enums_ui_updates.md`
   - `protocol_location_design_fix.md`

### Development Workflow

1. **Feature Development:**
   - Create feature branch
   - Implement feature following MVC pattern
   - Test functionality
   - Document in notes/
   - Submit PR

2. **Bug Fixing:**
   - Identify issue
   - Create bug report
   - Implement fix
   - Test thoroughly
   - Document fix in notes/

3. **Code Quality:**
   - Follow Flutter/Dart style guide
   - Use meaningful variable names
   - Add comments for complex logic
   - Keep controllers focused
   - Reuse widgets when possible

---

## 🧪 Testing

### Running Tests

```bash
# Run all tests
flutter test

# Run specific test file
flutter test test/widget_test.dart

# Run with coverage
flutter test --coverage
```

### Test Structure

```
test/
├── unit/              # Unit tests
├── widget/            # Widget tests
└── integration/       # Integration tests
```

---

## 📱 Building for Production

### Android

```bash
# Build APK
flutter build apk --release

# Build App Bundle
flutter build appbundle --release

# Output location:
# build/app/outputs/flutter-apk/app-release.apk
# build/app/outputs/bundle/release/app-release.aab
```

### iOS

```bash
# Build iOS app
flutter build ios --release

# Archive for App Store
# Use Xcode: Product > Archive
```

---

## 🐛 Known Issues

1. **Hive Type Adapters**: Currently not in use, replaced with GetStorage
2. **Draft System**: Draft SOPs and Reports use simplified models
3. **Image Upload**: Limited to single image per report/triage
4. **Offline Mode**: Limited offline functionality

---

## 🔮 Future Enhancements

- [ ] Multi-language support (i18n)
- [ ] Dark mode theme
- [ ] Export reports to PDF
- [ ] Advanced search and filters
- [ ] Real-time WebSocket updates
- [ ] Offline-first architecture
- [ ] Enhanced analytics dashboard
- [ ] Role-based permission system
- [ ] Audit trail logging
- [ ] Batch operations for admin

---

## 👨‍💻 Contributing

### Code Style

- Follow official Flutter/Dart style guide
- Use meaningful variable and function names
- Add documentation comments for public APIs
- Keep functions small and focused
- Use const constructors where possible

### Commit Convention

```
feat: Add new feature
fix: Bug fix
docs: Documentation changes
style: Code style changes
refactor: Code refactoring
test: Add or update tests
chore: Build process or auxiliary tool changes
```

### Pull Request Process

1. Fork the repository
2. Create feature branch (`git checkout -b feature/amazing-feature`)
3. Commit changes (`git commit -m 'feat: Add amazing feature'`)
4. Push to branch (`git push origin feature/amazing-feature`)
5. Open Pull Request

---

## 📄 License

This project is private and proprietary. Unauthorized copying, distribution, or use is strictly prohibited.

---

## 📞 Support

For issues, questions, or support:
- Create an issue in the repository
- Contact the development team
- Check documentation in `notes/` directory

---

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- GetX team for state management solution
- Firebase team for backend services
- All contributors to the project

---

<div align="center">

**Built with ❤️ using Flutter**

Version 1.0.0+1

Last Updated: November 29, 2025

</div>
