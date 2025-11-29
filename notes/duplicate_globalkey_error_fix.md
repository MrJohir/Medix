# Duplicate GlobalKey Error Fix

## Issue Summary
The application was throwing a duplicate GlobalKey error:
```
Duplicate GlobalKey detected in widget tree.
The following GlobalKey was specified multiple times in the widget tree. This will lead to parts of the widget tree being truncated unexpectedly...
- [LabeledGlobalKey<FormState>#45f00]
```

### Root Cause:
`GlobalKey<FormState>` instances were stored in GetX controllers (`LoginController` and `SignUpController`), which are singletons that persist across widget rebuilds. When Flutter rebuilt the widget tree or navigated between screens, the same `GlobalKey` was being used in multiple places in the widget tree simultaneously, causing the duplicate key error.

**Key Principle**: GlobalKeys are tied to the widget tree lifecycle and should be owned by widgets, not controllers. Controllers in GetX are long-lived singletons, while widgets are ephemeral and rebuild frequently.

## Changes Made

### 1. Fixed LoginController and LoginScreen

#### LoginController (`login_controller.dart`)
- **Removed**: `final GlobalKey<FormState> loginKey = GlobalKey<FormState>();`
- **Updated**: `submitForm()` method to accept form key as parameter
  ```dart
  // Before:
  Future<void> submitForm() async {
    if (!loginKey.currentState!.validate()) {
      ...
    }
  }

  // After:
  Future<void> submitForm(GlobalKey<FormState> formKey) async {
    if (!formKey.currentState!.validate()) {
      ...
    }
  }
  ```

#### LoginScreen (`login_screen.dart`)
- **Added**: Local form key in the widget
  ```dart
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  ```
- **Updated**: Form widget to use `_loginFormKey`
- **Updated**: Login button to pass form key to controller
  ```dart
  if (_loginFormKey.currentState!.validate()) {
    loginController.submitForm(_loginFormKey);
  }
  ```

### 2. Fixed SignUpController and SignUpScreen

#### SignUpController (`signup_controller.dart`)
- **Removed**: `final GlobalKey<FormState> signUpKey = GlobalKey<FormState>();`
- **Added**: New method `completeSignup(String jurisdiction)` for JurisdictionScreen
  - This method doesn't require form validation since it's already done in SignUpScreen
- **Note**: Kept the original approach where validation happens before navigation

#### SignUpScreen (`signup_screen.dart`)
- **Added**: Local form key in the widget
  ```dart
  final GlobalKey<FormState> _signUpFormKey = GlobalKey<FormState>();
  ```
- **Updated**: Form widget to use `_signUpFormKey`
- **Updated**: Register button to use local form key
  ```dart
  if (_signUpFormKey.currentState!.validate()) {
    Get.to(() => JurisdictionScreen());
  }
  ```

#### JurisdictionScreen (`jurisdiction_screen.dart`)
- **Updated**: Changed from `submitForm()` to `completeSignup()`
  ```dart
  // Before:
  bool success = await signupicontroller.submitForm(
    controller.selectedCountry.value,
  );

  // After:
  bool success = await signupicontroller.completeSignup(
    controller.selectedCountry.value,
  );
  ```

## Architecture Pattern

### Before (❌ Incorrect):
```
Controller (Singleton)
  └── GlobalKey<FormState> (shared across all widget instances)
       └── Used by multiple Form widgets → DUPLICATE KEY ERROR
```

### After (✅ Correct):
```
Widget (Ephemeral, rebuilds frequently)
  └── GlobalKey<FormState> (unique to this widget instance)
       └── Passed to controller methods when needed
```

## Benefits

1. ✅ **Eliminates duplicate GlobalKey errors** - Each widget instance has its own unique form key
2. ✅ **Follows Flutter best practices** - GlobalKeys are owned by widgets, not controllers
3. ✅ **Better separation of concerns** - Widgets manage UI state, controllers manage business logic
4. ✅ **More maintainable** - Clear lifecycle management of form keys
5. ✅ **Prevents future issues** - Pattern can be applied to all forms in the app

## Testing Checklist

- [ ] Test login flow - verify form validation works
- [ ] Test signup flow - verify form validation works
- [ ] Test navigation between login and signup screens multiple times
- [ ] Test logout and login again - no duplicate key errors
- [ ] Test app restart and navigation flows
- [ ] Test password reset flow (has similar pattern but not causing issues yet)

## Additional Notes

**Other controllers with GlobalKeys** (for future reference):
- `ForgotPasswordController` - has `forgotPasswordKey` but currently not causing issues (only created once)
- `CreateReportController` - has `formKey` (commented analysis suggests it was moved to widget)
- Consider applying the same pattern to these controllers proactively

## Date
30 September 2025
