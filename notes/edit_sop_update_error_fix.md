# Edit SOP Update Error Fix

## Issue Description
When updating a SOP for the second time, the API was returning a 500 Internal Server Error with the message "Failed to update SOP." The error was occurring because the data format being sent to the PATCH endpoint didn't match what the backend API expected.

## Root Cause Analysis

### Original Error Log
```
Response Status: 500
Response Body: {"message":"Failed to update SOP.","error":"Internal Server Error","statusCode":500}
```

### Problems Identified
1. **Protocol Steps Format Mismatch**: The `AddSopModel` was sending protocol steps with different structure than expected
2. **Missing Required Fields**: The API expected an `oxygen` field that wasn't being sent
3. **Step Number Inconsistency**: Protocol steps need to have sequential `stepNumber` starting from 0
4. **Data Structure Differences**: The PATCH request needed exact API format, not the form model format

## Solution Implemented

### 1. Created Dedicated Update Payload Method
**Location**: `lib/features/admin_flow/dashboard_section/add_new_sop/controller/add_new_sop_controller.dart`

**New Method**: `_createUpdatePayload()`
- Creates payload specifically formatted for PATCH requests
- Ensures exact match with API expected structure
- Handles all required fields including oxygen
- Proper sequential step numbering

### 2. Enhanced Update Process
**Modified Method**: `_updateSop()`
- Now uses `_createUpdatePayload()` instead of `_createSopModel()`
- Added detailed logging of the payload being sent
- Better error handling and debugging information

### 3. Key Format Changes

#### Protocol Steps Format:
```dart
// Before (causing errors)
{
  "stepNumber": 1,  // Was starting from 1
  "title": "string",
  "description": "string", 
  "duration": "string"
}

// After (API compatible)
{
  "stepNumber": 0,  // Now starts from 0
  "title": "string",
  "description": "string",
  "duration": "string"
}
```

#### Added Required Oxygen Field:
```dart
"oxygen": {
  "dose": "",
  "route": "",
  "repeat": ""
}
```

#### Proper Field Mapping:
```dart
'required_equipment': requiredEquipmentControllers  // Not 'requiredEquipment'
'isDraft': publicationStatus.value                 // Proper publication status
'status': settingStatus.value ? 'Emergence' : 'Procedure'  // Proper status mapping
```

## Technical Details

### Update Payload Structure
The new payload matches the exact structure expected by the API:
- All field names match API expectations
- Protocol steps have sequential numbering from 0
- Medications include all required fields
- Oxygen field is always included (even if empty)
- Proper data type handling for all fields

### Error Prevention
- Added comprehensive logging to track payload structure
- Validates data before sending to API
- Ensures no missing required fields
- Proper null safety throughout the process

## Testing Verification
After implementing this fix:
- ✅ First update works correctly
- ✅ Second update works correctly  
- ✅ Multiple consecutive updates work
- ✅ No more 500 Internal Server Error
- ✅ Proper error handling for actual API issues
- ✅ Data integrity maintained across updates

## Files Modified
1. **AddNewSopController**: Added `_createUpdatePayload()` method and enhanced `_updateSop()`

## Core Logic Summary
The fix ensures that when updating a SOP, the data sent to the API exactly matches the structure the backend expects for PATCH requests. This eliminates the 500 error and allows for reliable, repeatable SOP updates.

The key insight was that create (POST) and update (PATCH) endpoints might expect slightly different data formats, and using a dedicated update payload method ensures compatibility with the backend's update logic.