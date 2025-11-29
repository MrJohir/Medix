# Draft Report Local Storage Implementation

## 🎯 Task Overview
Implemented local database functionality for saving report drafts with specific user workflow:
1. User fills report form in create_report section
2. Clicks "Save as Draft" button → saves all information in local storage
3. Navigates to draft reports screen
4. Shows saved drafts as cards with 2 buttons: Delete and Submit Log
5. Submit Log removes from local storage and submits to API

## 🏗 Technical Implementation

### Architecture Used
- **Local Storage**: GetStorage (via LocalDataService)
- **State Management**: GetX controllers
- **Pattern**: MVC (Model-View-Controller)
- **UI Components**: Custom cards with action buttons

### Core Components Created

#### 1. Model (`SimpleDraftReportModel`)
- Location: `lib/features/trainee_flow/create_report/models/simple_draft_report_model.dart`
- Purpose: Data model for storing draft report information
- Key Features:
  - JSON serialization (toJson/fromJson)
  - API conversion method (toApiJson)
  - All report fields: title, procedure, severity, patient info, descriptions
  - Author and timestamp tracking
  - Null safety compliance

#### 2. Service Extension (`LocalDataService`)
- Location: `lib/core/services/local_data_service.dart`
- Purpose: Extended to handle both draft SOPs and draft reports
- Key Methods Added:
  - `saveDraftReport()` - Save new draft report
  - `getAllDraftReports()` - Load all draft reports
  - `getDraftReportById()` - Get specific draft report
  - `deleteDraftReport()` - Remove specific draft report
  - `clearAllDraftReports()` - Clear all draft reports
  - `getDraftReportCount()` - Get count of drafts
  - `draftReportExists()` - Check if draft exists

#### 3. UI Components
- **DraftIncidentCard** - Custom card for displaying draft reports with action buttons
- **DraftReportsScreen** - List view screen with empty state handling
- **DraftReportsController** - State management for draft reports screen

#### 4. Integration
- **ReportsController** - Added `submitDraftReport()` method for API submission
- **App Routes** - Added route for draft reports screen (`/draft-reports`)

## 📱 User Workflow

### Save as Draft Flow
1. User fills form fields in create report screen
2. Clicks "Save as Draft" button
3. Form data converted to `SimpleDraftReportModel`
4. Saved to GetStorage with unique timestamp ID
5. User navigated to draft reports screen
6. Success message shown

### Draft Reports Screen
1. Shows all saved draft reports as cards
2. Each card displays: title, description, severity, procedure, date, author
3. Two action buttons per card: Delete (red outline) and Submit Log (orange filled)
4. Empty state when no drafts exist
5. Header shows count and "Clear All" option

### Delete Draft Flow
1. User clicks "Delete" button on any card
2. Confirmation dialog appears
3. If confirmed, draft removed from local storage
4. Card disappears from list with success message

### Submit Log Flow
1. User clicks "Submit Log" button on any card
2. Draft data sent to report creation API
3. If successful, draft removed from local storage
4. Card disappears from list with success message
5. Reports list refreshed to show new submitted report

## 🔧 Key Implementation Details

### Data Storage Format
```dart
{
  'id': '1695801234567', // timestamp as string
  'incidentTitle': 'Report title',
  'procedure': 'Botulinum Toxin Injection',
  'severity': 'Medium',
  'patientAge': '25',
  'patientSex': 'Female',
  'incidentDescription': 'Description of incident',
  'actionsTaken': 'Actions taken',
  'outcome': 'Outcome description',
  'lessonsLearned': 'Lessons learned',
  'author': 'John Doe',
  'createdAt': '2024-01-15T10:30:00.000Z'
}
```

### API Integration
- Draft reports converted to API format using `toApiJson()` method
- Maps fields to expected API structure:
  - `descriptionOfIncident` instead of `incidentDescription`
  - `situation` mapped from `severity`
  - `patientAge` converted to integer
  - `isDraft` always false for submissions

### Error Handling
- Try-catch blocks in all service methods
- EasyLoading for user feedback
- Logger for debugging
- Graceful fallbacks for missing data
- Confirmation dialogs for destructive actions

### UI/UX Features
- **Empty State**: Friendly message with "Create New Report" button
- **Draft Badge**: Visual indicator showing "DRAFT" status
- **Info Tags**: Severity and procedure displayed as styled tags
- **Action Buttons**: Color-coded for clear distinction (delete=red, submit=orange)
- **Loading States**: Proper loading indicators during operations
- **Count Display**: Shows number of drafts in header

## 🚀 Integration Points

### Routes Added
```dart
static String draftReportsScreen = "/draft-reports";
GetPage(name: draftReportsScreen, page: () => const DraftReportsScreen()),
```

### Controller Dependencies
- `DraftReportsController` manages the draft reports screen
- `ReportsController` handles API submission of drafts
- Integration with existing `CreateReportController` (needs save as draft method)

## 📋 Remaining Tasks

### Critical
1. **Fix CreateReportController**: Add proper `saveAsDraft()` method and `_createDraftReportModel()` helper
2. **Navigation Integration**: Connect "Save as Draft" button to navigate to draft reports screen
3. **Testing**: Verify complete workflow end-to-end

### Optional Enhancements
- Add edit draft functionality
- Implement draft auto-save
- Add draft search/filter capabilities
- Include draft expiration dates
- Add draft synchronization across devices

## 🎯 Core Concept for New Developers

This implementation follows the same pattern as the SOP drafts:

1. **Save Pattern**: Convert form data to JSON model → Store in local database → Navigate to list
2. **List Pattern**: Load from storage → Display as cards → Handle actions
3. **Action Pattern**: Either delete locally or submit to API then delete locally

Key principle: Local storage acts as temporary holding area for incomplete work, with simple JSON-based persistence for reliability.

## 🔧 Current Status

**Completed:**
- ✅ SimpleDraftReportModel with JSON serialization
- ✅ LocalDataService extended for reports
- ✅ DraftReportsScreen with full UI
- ✅ DraftIncidentCard with action buttons
- ✅ ReportsController API integration
- ✅ App routes configuration

**In Progress:**
- 🔄 CreateReportController save as draft functionality (needs completion)

**Next Steps:**
1. Complete CreateReportController integration
2. Test save → list → delete/submit workflow
3. Verify API submission works correctly
4. Add any missing error handling or validation

The foundation is solid and most components are ready - just need to complete the controller integration for the save as draft functionality.