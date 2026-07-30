import '../../app/localization/app_strings.dart';

/// Centralized form validation functions returning localized error strings per instruction.md rules.
class FormValidators {
  FormValidators._();

  static final RegExp _emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  /// Validates email address input field
  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.emailRequired;
    }
    if (!_emailRegex.hasMatch(value.trim())) {
      return AppStrings.emailInvalid;
    }
    return null;
  }

  /// Validates password input field
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.passwordRequired;
    }
    if (value.length < 6) {
      return AppStrings.passwordTooShort;
    }
    return null;
  }

  /// Validates full name input field
  static String? validateFullName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.fullNameRequired;
    }
    if (value.trim().length < 2) {
      return AppStrings.fullNameTooShort;
    }
    return null;
  }

  /// Validates confirm password matches password
  static String? validateConfirmPassword(String? value, String originalPassword) {
    if (value == null || value.isEmpty) {
      return AppStrings.confirmPasswordRequired;
    }
    if (value != originalPassword) {
      return AppStrings.passwordsDoNotMatch;
    }
    return null;
  }

  /// Validates date of birth field
  static String? validateDateOfBirth(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.dateOfBirthRequired;
    }
    return null;
  }
}
