# Conditional Validation Implementation for SOP Forms

## Problem
The SOP creation and editing should have different validation requirements:
- **Create Mode**: All fields should be required (strict validation)
- **Edit Mode**: All fields should be optional (relaxed validation)

## Solution Implemented

### 1. Modified Validation Logic in AddNewSopController

**File:** `lib/features/admin_flow/dashboard_section/add_new_sop/controller/add_new_sop_controller.dart`

#### Main Validation Method
```dart
bool _validateForm() {
  if (isEditMode.value) {
    return _validateFormForEdit();
  } else {
    return _validateFormForCreate();
  }
}
```

#### Create Mode Validation (Strict - All Required)
- SOP title ✅ Required
- Jurisdictions ✅ At least one required
- Tags ✅ At least one required
- Overview ✅ Required
- Indications ✅ At least one required
- Contraindications ✅ At least one required
- Required Equipment ✅ At least one required
- Protocol Steps ✅ At least one complete step (title, description, duration)
- Medications ✅ At least one complete medication (name, dose, route, repeat)
- Publication Status ✅ Required
- Priority ✅ Required

#### Edit Mode Validation (Relaxed - Most Optional)
- SOP title ✅ Required (basic identification)
- All other fields ✅ Optional
- Structural validation only:
  - If protocol step details are provided, title must be filled
  - If medication details are provided, name must be filled

### 2. Mode Detection
The controller uses the `isEditMode.value` flag which is set to `true` when:
```dart
// In initializeForEdit method
isEditMode.value = true;
editingSopId.value = sopData.id;
```

This is triggered when the AddNewSopScreen is opened with existing `sopData`:
```dart
// In AddNewSopScreen
if (sopData != null) {
  controller.initializeForEdit(sopData!);
}
```

### 3. User Experience Benefits

#### For Creating New SOPs:
- Ensures data quality with comprehensive validation
- Prevents incomplete SOPs from being created
- Guides users to fill all necessary fields

#### For Editing Existing SOPs:
- Allows quick updates to specific fields
- No need to fill all fields just to change one item
- Maintains data integrity with basic structural validation
- Faster workflow for minor edits

### 4. Validation Messages

#### Create Mode (Strict):
- "Please enter SOP title"
- "Please select at least one jurisdiction"
- "Please select at least one tag"
- "Please enter SOP overview"
- "Please enter at least one indication"
- etc.

#### Edit Mode (Relaxed):
- "SOP title cannot be empty"
- "Protocol step title is required when adding step details"
- "Medication name is required when adding medication details"

## Implementation Details

### Code Structure
- **Main validation method**: `_validateForm()` - routes to appropriate validation
- **Create validation**: `_validateFormForCreate()` - comprehensive checks
- **Edit validation**: `_validateFormForEdit()` - minimal required checks

### Mode Setting
- Edit mode is set via `initializeForEdit(sopData)` method
- Create mode is the default state (isEditMode = false)
- Mode persists throughout the form session

### Field Behavior
- **Create**: All key fields must be completed before submission
- **Edit**: Only structural integrity is validated, content is optional

This implementation provides a better user experience by adapting validation rules to the user's intent while maintaining data quality standards.