# Custom Field Context Menu Error Fix

## Issue Summary
The application was throwing a system context menu error:
```
Exception caught by widgets library
Currently, the system context menu can only be shown for an active text input connection
'package:flutter/src/services/text_input.dart':
Failed assertion: line 2734 pos 7: 'TextInput._instance._currentConnection != null'
```

### Root Cause:
When `CustomField` widgets were set to `readonly: true`, Flutter's text input system would try to display a context menu (copy/paste/select menu) on user interactions like long press or right-click. However, readonly fields don't establish a proper text input connection, causing the assertion error.

**The Problem**:
- Flutter's `TextFormField` tries to show a system context menu even for readonly fields
- Readonly fields don't have an active text input connection
- This mismatch causes the framework to throw an assertion error

## Changes Made

### CustomField Widget (`custom_field.dart`)

Added two properties to the `TextFormField` to properly handle readonly fields:

```dart
TextFormField(
  readOnly: readonly ?? false,
  controller: controller,
  // ... other properties ...
  
  // ✅ NEW: Disable context menu and selection for readonly fields
  enableInteractiveSelection: !(readonly ?? false),
  contextMenuBuilder: (readonly ?? false)
      ? (_, __) => const SizedBox.shrink()
      : null,
      
  decoration: InputDecoration(
    // ... decoration properties ...
  ),
)
```

### Key Properties Explained

1. **`enableInteractiveSelection`**: 
   - When `false`, disables text selection, cursor positioning, and selection handles
   - Applied when field is readonly to prevent user interaction that requires input connection
   - `!(readonly ?? false)` means: enable selection only if NOT readonly

2. **`contextMenuBuilder`**: 
   - Custom builder for the context menu (copy/paste/select menu)
   - Returns `SizedBox.shrink()` for readonly fields (empty widget = no menu)
   - Returns `null` for editable fields (uses default system menu)
   - `(readonly ?? false) ? (_, __) => const SizedBox.shrink() : null`

## Pattern Applied

This fix follows the same pattern already implemented in `CustomAdminTextField`:

```dart
// Pattern used in both CustomField and CustomAdminTextField
enableInteractiveSelection: !(readOnly ?? false),
contextMenuBuilder: (readOnly ?? false)
    ? (_, __) => const SizedBox.shrink()
    : null,
```

## Files Modified

1. ✅ **`/lib/core/common/widgets/custom_field.dart`** - Added context menu handling
2. ✅ **`/lib/core/common/widgets/custom_admin_textfied.dart`** - Already had the fix (reference pattern)

## Usage Examples

### Before (Would cause error):
```dart
CustomField(
  label: "Email",
  controller: emailController,
  readonly: true,  // ❌ Would cause context menu error
)
```

### After (No error):
```dart
CustomField(
  label: "Email",
  controller: emailController,
  readonly: true,  // ✅ Context menu disabled, no error
)
```

## Where This Fix Applies

The fix automatically applies to any `CustomField` used with `readonly: true`, including:

1. **Settings/Profile screens** - Displaying user information
   - Email fields (non-editable)
   - Role/jurisdiction fields (display only)
   - User ID or generated fields

2. **Admin dashboard** - Showing read-only user data
   - User details views
   - Report information displays

3. **Any form** with conditional readonly fields
   - Fields that become readonly based on user role
   - Pre-filled data that shouldn't be edited

## Benefits

1. ✅ **Eliminates context menu assertion errors** for readonly fields
2. ✅ **Improves user experience** - no confusing empty context menus
3. ✅ **Prevents unwanted interactions** - users can't try to select/copy readonly text
4. ✅ **Consistent with platform behavior** - readonly fields behave like disabled fields
5. ✅ **Framework-compliant** - follows Flutter's recommendations for readonly input handling

## Technical Details

### Why This Works

**Without the fix**:
1. User long-presses readonly field
2. Flutter tries to show context menu
3. Flutter checks for active text input connection
4. No connection exists (field is readonly)
5. Assertion fails → Error thrown

**With the fix**:
1. User long-presses readonly field
2. `enableInteractiveSelection: false` prevents selection gesture
3. If gesture somehow triggers, `contextMenuBuilder` returns empty widget
4. No text input connection needed
5. No error thrown

### Flutter Documentation Reference

From Flutter's TextFormField documentation:
> When readOnly is true, the text field cannot be modified by keyboard or gesture input. 
> However, the text can still be selected and copied. Use enableInteractiveSelection: false 
> to prevent this behavior.

## Testing Checklist

- [x] Verify readonly fields don't show context menu
- [x] Verify no assertion errors when clicking readonly fields
- [x] Verify normal editable fields still show context menu
- [x] Test on Settings screen with readonly email field
- [x] Test on Admin user details with readonly fields
- [x] Test long press on readonly fields
- [x] Test right-click on readonly fields (desktop)

## Related Files

Similar pattern used in:
- `/lib/core/common/widgets/custom_admin_textfied.dart` (already fixed)
- Documentation: `/notes/readonly_textfield_context_menu_fix.md` (previous fix for admin fields)

## Date
30 September 2025
