# Triage Null Check Error Fix

## Issue Summary
The application was crashing with the following errors:
1. `Exception: type 'Null' is not a subtype of type 'Map<String, dynamic>'`
2. `Null check operator used on a null value` at line 270 in `triage_screen.dart`

### Root Causes:
1. **API Response Handling**: The emergency protocol API was returning:
   ```json
   {
     "statusCode": 200,
     "success": true,
     "message": "User retrieved successfully Done",
     "data": null
   }
   ```
   But the code was trying to access `response['response_data']` and treating `data` as a non-null Map.

2. **Null Safety**: The code was using null-check operators (`!`) on potentially null values:
   - `settingsController.user.value!.jurisdiction!`

## Changes Made

### 1. Fixed Null Safety in `triage_screen.dart`
**File**: `/lib/features/trainee_flow/triage/views/screens/triage_screen.dart`

- **Line 270** (Send button callback): Added null-safe access to jurisdiction
  ```dart
  // Before:
  settingsController.user.value!.jurisdiction!
  
  // After:
  final jurisdiction = settingsController.user.value?.jurisdiction ?? '';
  controller.sendMessageWithOptionalImage(jurisdiction);
  ```

- **onSubmitted callback**: Added null-safe access
- **Emergency Protocol button**: Added null-safe access

### 2. Fixed API Response Handling in `triage_controller.dart`
**File**: `/lib/features/trainee_flow/triage/controllers/triage_controller.dart`

Updated `callEmergencyProtocol` method to:
- Check if `response['data']` is null before using it
- Extract `data` field from the API response structure
- Show appropriate error message when data is null
- Set `emargencyProtocolData` to empty map `{}` when no data available

```dart
// Handle API response structure: {statusCode, success, message, data}
if (response['data'] != null) {
  emargencyProtocolData.value = response['data'];
} else {
  // Show error and set empty map
  Get.snackbar("Error", response['message'] ?? "No emergency protocol data available");
  emargencyProtocolData.value = {};
}
```

### 3. Fixed Data Access in `emargency_protocal_screen.dart`
**File**: `/lib/features/trainee_flow/triage/views/screens/emargency_protocal_screen.dart`

- Changed from accessing `controller.emargencyProtocolData['response_data']`
- To directly using `controller.emargencyProtocolData` (since data is already extracted in controller)

```dart
// Before:
final response = controller.emargencyProtocolData['response_data'];

// After:
final response = controller.emargencyProtocolData;
```

## Testing Recommendations

1. **Test null jurisdiction scenario**:
   - Log out and ensure user data is cleared
   - Try to send a message
   - Should gracefully handle empty jurisdiction

2. **Test null data from API**:
   - Trigger emergency protocol with a complication
   - When API returns `data: null`, should show error message
   - Should not crash the app

3. **Test successful flow**:
   - Send a message that detects a complication
   - Click "View Emergency Protocols"
   - Verify protocol data displays correctly when API returns valid data

## Benefits
- ✅ Prevents app crashes due to null values
- ✅ Handles API errors gracefully
- ✅ Shows user-friendly error messages
- ✅ Maintains app stability even with unexpected API responses
- ✅ Better defensive programming practices

## Date
30 September 2025
