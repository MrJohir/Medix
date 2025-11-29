# SOP Model API Response Structure Update

## Changes Made
The API response structure for SOPs has been updated. The `author` field has been removed and replaced with a `user` object containing `firstName` and `lastName`, plus an `authorId` field.

## API Response Changes

### Before:
```json
{
  "author": "Super Admin",
  // ... other fields
}
```

### After:
```json
{
  "authorId": "cmfrnmugg0000tnl0f7gcm16p",
  "user": {
    "firstName": "Super",
    "lastName": "Admin"
  },
  // ... other fields
}
```

## Model Updates Made

### 1. Added User Model
Created a new `User` class to handle the user object structure:
```dart
class User {
  final String firstName;
  final String lastName;
  
  String get fullName => '$firstName $lastName'.trim();
}
```

### 2. Updated SOPModel
- Removed `final String author` field
- Added `final String authorId` field  
- Added `final User user` field
- Updated `fromJson()` constructor to parse the new structure
- Updated `toJson()` method to include new fields

### 3. Backward Compatibility
Added a getter to maintain backward compatibility:
```dart
String get author => user.fullName;
```

This ensures existing code using `sop.author` continues to work without changes.

## Files Modified
- `/lib/features/admin_flow/sops_section/sops/model/sop_model.dart`

## UI Impact
No changes needed to the SOP card UI since the `author` getter provides the same functionality as before. The author name will now display as "firstName lastName" from the user object.

## Key Benefits
- Better data structure alignment with API
- Separation of author ID and display name
- Future-proof for additional user fields
- Maintains backward compatibility