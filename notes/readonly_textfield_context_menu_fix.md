# ReadOnly TextField Context Menu Error Fix

## Problem
When BasicInformation TextFields were set to readonly, users encountered this error when clicking on them:
```
Exception caught by widgets library: Currently, the system context menu can only be shown for an active text input connection
```

## Root Cause
- Flutter's TextFormField tries to show a context menu on long press/right-click even for readonly fields
- Readonly fields don't have an active text input connection, causing the assertion failure
- The system tries to display selection handles and context menu but can't establish proper text input connection

## Solution
Updated `CustomAdminTextField` widget to properly handle readonly fields:

1. **Disabled Interactive Selection**: Set `enableInteractiveSelection: false` for readonly fields
2. **Custom Context Menu Builder**: Return empty widget for readonly fields to prevent context menu

## Code Changes
In `/core/common/widgets/custom_admin_textfied.dart`:
```dart
TextFormField(
  readOnly: readOnly ?? false,
  // disable context menu and selection for readonly fields
  enableInteractiveSelection: !(readOnly ?? false),
  contextMenuBuilder: (readOnly ?? false) ? (_, __) => const SizedBox.shrink() : null,
  // ...other properties
)
```

## Key Benefits
- ✅ No more system context menu errors
- ✅ Readonly fields remain unselectable and non-editable  
- ✅ Normal fields still have full text selection functionality
- ✅ Better user experience for readonly form viewing

## Usage
This fix automatically applies to all `CustomAdminTextField` widgets when `readOnly: true` is set, including:
- BasicInformation fields in edit user mode
- Any other readonly form fields across the app

## Technical Details
- `enableInteractiveSelection: false` prevents text selection and cursor positioning
- `contextMenuBuilder` returning `SizedBox.shrink()` prevents context menu display
- Only affects readonly fields - normal fields retain full functionality
