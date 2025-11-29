# Create Report API Integration Implementation

## Overview
This note explains the implementation of POST API integration for creating reports in the trainee flow. When a user fills out all required fields and clicks the "Submit Log" button, the form data is submitted to the backend API and the screen refreshes to show updated data.

## Main Components Updated

### 1. API Constants (`lib/core/utils/constants/api_constants.dart`)
- Added new endpoint `createReportEndpoint = "/report"` for creating reports

### 2. Create Report Model (`lib/features/trainee_flow/create_report/models/create_report_model.dart`)
- Updated `toJson()` method to match the API requirements
- Mapped field names correctly (e.g., `descriptionOfIncident` instead of `incident_description`)
- Added proper data type conversion for `patientAge` (string to int)
- Set `isDraft: false` for all submissions

### 3. Create Report Controller (`lib/features/trainee_flow/create_report/controllers/create_report_controller.dart`)
- **Imports**: Added NetworkCaller, API constants, EasyLoading, and dart:convert
- **Form Validation**: Updated to use EasyLoading instead of snackbars for error messages
- **API Integration**: Implemented `submitReport()` method using NetworkCaller.postRequest()
- **Loading States**: Used EasyLoading for showing loading, success, and error messages
- **Navigation**: Added proper navigation back with result passing
- **Data Management**: Clear form and draft data after successful submission

### 4. Reports App Bar (`lib/features/trainee_flow/reports/views/widgets/reports_app_bar.dart`)
- **Navigation Result Handling**: Updated navigation to wait for result from create report screen
- **Auto Refresh**: When result is true (successful submission), automatically refresh the reports list
- **Controller Access**: Use `Get.find<ReportsController>()` to access existing controller instance

## Key Implementation Logic

### Form Submission Flow
1. **Validation**: Check all required fields and dropdowns
2. **Loading**: Show EasyLoading with "Submitting report..." message
3. **API Call**: Use NetworkCaller.postRequest() with the report endpoint
4. **Response Handling**: 
   - Success (200/201): Clear form, show success message, navigate back with result=true
   - Error: Show error message from API response
5. **Error Handling**: Catch exceptions and show user-friendly error messages

### Data Mapping
The form data is mapped from the UI model to match the API requirements:
- `incidentTitle` → `incidentTitle`
- `procedure` → `procedure`
- `severity` → both `severity` and `situation` (API requirement)
- `patientAge` → converted to integer
- `patientSex` → `patientSex`
- `incidentDescription` → `descriptionOfIncident`
- `actionsTaken` → `actionsTaken`
- `outcome` → `outcome`
- `lessonsLearned` → `lessonsLearned`
- `isDraft` → always false for submissions

### Navigation and Refresh
- After successful submission, `Get.back(result: true)` is called
- The reports app bar waits for this result
- If result is true, it calls `reportsController.refreshData()` to reload the list
- This ensures the new report appears immediately in the reports list

## User Experience
1. User fills out all required fields in the create report form
2. User clicks "Submit Log" button
3. Loading indicator shows with "Submitting report..." message
4. Upon success:
   - Success message shows: "Report submitted successfully"
   - Form is cleared
   - User is navigated back to reports screen
   - Reports list is automatically refreshed to show the new report
5. Upon error:
   - Error message shows with specific API error or generic "Failed to submit report"
   - User remains on the form to fix issues and retry

## Technical Notes
- Uses EasyLoading for consistent UI feedback across the app
- Follows the existing NetworkCaller pattern for API calls
- Implements proper error handling and user feedback
- Maintains form state management through GetX controllers
- Follows the app's navigation and refresh patterns