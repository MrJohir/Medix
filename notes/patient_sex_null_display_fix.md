# Patient Sex Null Display Fix

## Problem
The `patientSex` data was always showing as null in the incident card widget, even though the API was returning the correct data.

## Root Cause
In the `ReportsController`, when converting from `Report` model to `IncidentModel`, the `patientSex` field was not being included in the JSON mapping. The `Report` model from the API contains the `patientSex` field, but it wasn't being passed to the `IncidentModel.fromJson()` method.

## Solution
1. **Fixed Controller Mapping**: Added `'patientSex': report.patientSex` to the JSON mapping in two places:
   - In `_loadReportsFromApi()` method where reports are converted to incidents
   - In `addReport()` method where new incidents are added

2. **Enhanced UI Display**: Added fallback display logic in the incident card widget to show 'N/A' when patient sex is empty or null.

## Changes Made
- **File**: `lib/features/trainee_flow/reports/controllers/reports_controller.dart`
  - Added patientSex mapping in the incident conversion process
  
- **File**: `lib/features/trainee_flow/reports/views/widgets/incident_card.dart`
  - Added null/empty check for patientSex display with fallback to 'N/A'

## Key Learning
Always ensure that all required fields from the API model are properly mapped when converting between different model classes. Missing field mappings are a common source of null data issues.