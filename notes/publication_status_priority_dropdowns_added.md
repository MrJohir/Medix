# Publication Status and Priority Dropdowns Added to Add New SOP

## Overview
Restored the "Publication Status" dropdown and added a new "Priority" dropdown to the Add New SOP screen as requested.

## Changes Made

### 1. Controller Updates (`add_new_sop_controller.dart`)

#### Added Variables:
```dart
// Publication Status
var publicationStatus = ''.obs;
final List<String> publicationStatusOptions = [
  'Draft',
  'Published', 
  'Archived',
];

// Priority
var priority = ''.obs;
final List<String> priorityOptions = [
  'High',
  'Medium',
  'Low',
];
```

#### Enhanced Validation:
- Added required validation for Publication Status
- Added required validation for Priority
- Both fields now show specific error messages if not selected

#### Updated Form Management:
- Added clearing of both fields in `_clearForm()` method
- Updated `_createSopModel()` to include both new fields

### 2. Model Updates (`add_sop_model.dart`)

#### Added Fields:
```dart
final String publicationStatus;
final String priority;
```

#### Updated Methods:
- **Constructor**: Added required parameters for both fields
- **toJson()**: Added both fields to API payload
- **fromJson()**: Added parsing with default values (Draft, Medium)

### 3. Screen Updates (`add_new_sop_screen.dart`)

#### Added Priority Dropdown:
```dart
Padding(
  padding: const EdgeInsets.only(top: 15.0, bottom: 5),
  child: Text(
    'Priority',
    style: TextStyle(
      fontSize: 12,
      fontFamily: 'Montserrat',
      fontWeight: FontWeight.w400,
      color: Color(0xff333333),
    ),
  ),
),

CustomAdminDropdown(
  label: 'Select priority',
  value: controller.priority,
  items: controller.priorityOptions,
  onChanged: (String? newValue) {
    controller.priority(newValue);
  },
),
```

#### Publication Status Already Present:
The Publication Status dropdown was already implemented in the screen but missing from the controller.

## UI Layout

The dropdowns are positioned in the settings section with:

1. **Settings Toggle** (Emergency/Procedure - Optional)
2. **Publication Status Dropdown** (Draft/Published/Archived - Required)
3. **Priority Dropdown** (High/Medium/Low - Required)

## Validation Logic

Both new fields are **required**:
- User must select a publication status
- User must select a priority level
- Clear error messages guide users to missing selections
- Only the settings toggle remains optional as specified

## API Integration

Both fields are included in the POST request payload:
```json
{
  "publicationStatus": "Draft",
  "priority": "High",
  // ... other fields
}
```

## Default Values

- **Publication Status**: "Draft" (when loading from API)
- **Priority**: "Medium" (when loading from API)
- **Form State**: Empty strings (when creating new SOP)

This implementation ensures both dropdowns work seamlessly with the existing form validation and API submission flow while maintaining the optional nature of the settings field.
