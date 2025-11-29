# Hive Local Database Implementation for Draft SOPs

## Overview
Successfully implemented Hive local database functionality for saving draft SOPs. Users can now save incomplete SOPs as drafts locally and later publish or delete them from a dedicated draft list screen.

## Implementation Details

### 1. Dependencies Added
- **hive**: ^2.2.3 - Core Hive database
- **hive_flutter**: ^1.1.0 - Flutter integration for Hive
- **hive_generator**: ^2.0.1 - Code generation for adapters

### 2. Data Models Created

#### Draft SOP Model (`draft_sop_model.dart`)
- **Location**: `lib/features/admin_flow/dashboard_section/add_new_sop/models/draft_sop_model.dart`
- **Purpose**: Hive-compatible model for storing draft SOPs locally
- **Key Features**:
  - Uses Hive annotations with unique type IDs (0, 1, 2)
  - Stores all SOP form data including title, jurisdiction, tags, etc.
  - Includes creation timestamp for tracking
  - Has `toApiJson()` method for publishing to server
  - Supports nested models for protocol steps and medications

#### Supporting Models
- **DraftProtocolStep**: Stores protocol step data with Hive annotations
- **DraftMedication**: Stores medication data with Hive annotations

### 3. Service Layer (`draft_sop_service.dart`)

#### Location
`lib/core/services/draft_sop_service.dart`

#### Key Methods
- `init()`: Initialize Hive box for draft SOPs
- `saveDraftSOP()`: Save draft SOP to local database
- `getAllDraftSOPs()`: Retrieve all stored draft SOPs
- `getDraftSOPById()`: Get specific draft by ID
- `deleteDraftSOP()`: Remove draft from local storage
- `clearAllDraftSOPs()`: Clear all drafts
- `getDraftSOPCount()`: Get count of stored drafts

#### Features
- Comprehensive error handling with Logger
- Null safety checks
- Automatic box initialization
- Returns success/failure status for all operations

### 4. UI Components

#### Draft SOP Card (`draft_sop_card.dart`)
- **Location**: `lib/features/admin_flow/dashboard_section/add_new_sop/views/widget/draft_sop_card.dart`
- **Purpose**: Display individual draft SOPs with action buttons
- **Features**:
  - Shows SOP title, author, creation date
  - Displays "Draft" status badge
  - Shows jurisdiction tags
  - Only has "Publish" and "Delete" buttons (no Edit/View)
  - Consistent styling with existing SOP cards

#### Draft SOP List Screen (`draft_sop_list_screen.dart`)
- **Location**: `lib/features/admin_flow/dashboard_section/add_new_sop/views/screens/draft_sop_list_screen.dart`
- **Purpose**: Main screen for viewing and managing draft SOPs
- **Features**:
  - Uses AppBarHelper for consistent app bar
  - Shows empty state when no drafts available
  - Pull-to-refresh functionality
  - Header with draft count
  - Confirmation dialogs for delete/publish actions

### 5. Controller Logic

#### Draft SOP List Controller (`draft_sop_list_controller.dart`)
- **Location**: `lib/features/admin_flow/dashboard_section/add_new_sop/controller/draft_sop_list_controller.dart`
- **Purpose**: Manages draft SOPs list screen logic
- **Key Methods**:
  - `loadDraftSOPs()`: Load drafts from local database
  - `publishDraftSOP()`: Convert draft to API format and publish
  - `deleteDraftSOP()`: Remove draft from local storage
  - `refreshDraftSOPs()`: Reload draft list

#### Updated Add New SOP Controller
- **Modified Method**: `onSaveAsDraft()`
- **New Behavior**: 
  - Validates form data
  - Creates DraftSOPModel from form
  - Saves to local Hive database
  - Navigates to draft list screen
  - Shows success/error messages

### 6. Database Initialization

#### Main.dart Updates
- Added Hive initialization in main function
- Registered all Hive adapters for custom models
- Initialized DraftSOPService
- Proper error handling for initialization

### 7. User Flow

#### Saving as Draft
1. User fills out SOP form (partially or completely)
2. Clicks "Save as Draft" button
3. Form validation runs
4. Data is saved to local Hive database
5. User is navigated to Draft SOP List screen
6. Success message is shown

#### Managing Drafts
1. User sees list of all saved drafts
2. Each draft shows title, author, date, jurisdiction tags
3. User can either:
   - **Publish**: Converts draft to API format and sends to server
   - **Delete**: Removes draft from local storage
4. After publishing, draft is automatically removed from local storage

### 8. Technical Implementation

#### Code Generation
- Used `flutter packages pub run build_runner build` to generate Hive adapters
- Generated files: `draft_sop_model.g.dart`

#### Error Handling
- Comprehensive try-catch blocks in all service methods
- User-friendly error messages via EasyLoading
- Logger integration for debugging
- Graceful fallbacks for failed operations

#### Data Consistency
- Unique ID generation using timestamp
- Proper null safety throughout
- Consistent data validation
- Clean separation of concerns

## Key Benefits

### 1. Offline Functionality
- Users can save work without internet connection
- Data persists between app sessions
- No data loss if app crashes or is closed

### 2. User Experience
- Seamless save/restore workflow
- Clear visual feedback for all actions
- Intuitive draft management interface
- Consistent with existing app design

### 3. Performance
- Local storage is fast and responsive
- No network calls for draft operations
- Efficient data retrieval and storage

### 4. Maintainability
- Clean architecture with service layer
- Reusable components
- Well-documented code
- Follows Flutter best practices

## Future Enhancements

### Potential Features
1. **Edit Draft**: Allow editing saved drafts
2. **Draft Sync**: Sync drafts across devices
3. **Auto-save**: Automatically save drafts while typing
4. **Draft Categories**: Organize drafts by type or status
5. **Export/Import**: Backup and restore draft data

## Testing Notes

### Manual Testing Required
1. Save various types of draft SOPs
2. Test publish functionality with different draft data
3. Verify delete operations work correctly
4. Test app restart to ensure data persistence
5. Test error scenarios (network failures, etc.)

## Files Modified/Created

### New Files
- `lib/features/admin_flow/dashboard_section/add_new_sop/models/draft_sop_model.dart`
- `lib/core/services/draft_sop_service.dart`
- `lib/features/admin_flow/dashboard_section/add_new_sop/views/widget/draft_sop_card.dart`
- `lib/features/admin_flow/dashboard_section/add_new_sop/views/screens/draft_sop_list_screen.dart`
- `lib/features/admin_flow/dashboard_section/add_new_sop/controller/draft_sop_list_controller.dart`

### Modified Files
- `pubspec.yaml` - Added Hive dependencies
- `lib/main.dart` - Added Hive initialization
- `lib/core/utils/constants/api_constants.dart` - Added createSOPEndpoint
- `lib/features/admin_flow/dashboard_section/add_new_sop/controller/add_new_sop_controller.dart` - Updated onSaveAsDraft method

## Architecture Compliance

This implementation follows the established patterns:
- **MVC Architecture**: Clear separation of Model, View, Controller
- **Service Layer**: Database operations encapsulated in service classes
- **Error Handling**: Consistent error handling with Logger and EasyLoading
- **UI Consistency**: Reuses existing design components and patterns
- **Code Style**: Follows established naming conventions and code structure