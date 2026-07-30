import 'package:flutter/material.dart';
import '../../../../app/localization/app_strings.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/utils/form_validators.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_field.dart';

/// Modular form component for the Register screen with form validation.
class RegisterFormWidget extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController fullNameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final TextEditingController dobController;
  final bool isPasswordVisible;
  final bool isConfirmPasswordVisible;
  final bool isAgreedToTerms;
  final bool isLoading;
  final VoidCallback onTogglePasswordVisibility;
  final VoidCallback onToggleConfirmPasswordVisibility;
  final ValueChanged<bool?> onToggleTermsAgreement;
  final VoidCallback onSelectDateOfBirth;
  final VoidCallback onSignUpPressed;

  const RegisterFormWidget({
    super.key,
    required this.formKey,
    required this.fullNameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.dobController,
    required this.isPasswordVisible,
    required this.isConfirmPasswordVisible,
    required this.isAgreedToTerms,
    required this.isLoading,
    required this.onTogglePasswordVisibility,
    required this.onToggleConfirmPasswordVisibility,
    required this.onToggleTermsAgreement,
    required this.onSelectDateOfBirth,
    required this.onSignUpPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Full Name Field
          AppTextField(
            controller: fullNameController,
            hintText: AppStrings.fullNameLabel,
            prefixIcon: Icons.person_outline_rounded,
            validator: FormValidators.validateFullName,
          ),
          const SizedBox(height: AppSpacing.md),

          // Email Field
          AppTextField(
            controller: emailController,
            hintText: AppStrings.emailAddressLabel,
            prefixIcon: Icons.mail_outline_rounded,
            keyboardType: TextInputType.emailAddress,
            validator: FormValidators.validateEmail,
          ),
          const SizedBox(height: AppSpacing.md),

          // Password Field
          AppTextField(
            controller: passwordController,
            hintText: AppStrings.passwordLabel,
            prefixIcon: Icons.lock_outline_rounded,
            obscureText: !isPasswordVisible,
            validator: FormValidators.validatePassword,
            suffixIcon: IconButton(
              icon: Icon(
                isPasswordVisible
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                color: AppColors.inputIcon,
                size: 20.0,
              ),
              onPressed: onTogglePasswordVisibility,
            ),
          ),
          const SizedBox(height: AppSpacing.md),

          // Confirm Password Field
          AppTextField(
            controller: confirmPasswordController,
            hintText: AppStrings.confirmPasswordLabel,
            prefixIcon: Icons.lock_outline_rounded,
            obscureText: !isConfirmPasswordVisible,
            validator: (val) => FormValidators.validateConfirmPassword(
              val,
              passwordController.text,
            ),
            suffixIcon: IconButton(
              icon: Icon(
                isConfirmPasswordVisible
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                color: AppColors.inputIcon,
                size: 20.0,
              ),
              onPressed: onToggleConfirmPasswordVisibility,
            ),
          ),
          const SizedBox(height: AppSpacing.md),

          // Date of Birth Label & Field
          Text(
            AppStrings.dateOfBirthLabel,
            style: AppTypography.fieldLabelStyle(),
          ),
          const SizedBox(height: AppSpacing.xs),
          AppTextField(
            controller: dobController,
            hintText: AppStrings.dateOfBirthPlaceholder,
            prefixIcon: Icons.calendar_today_outlined,
            readOnly: true,
            onTap: onSelectDateOfBirth,
            validator: FormValidators.validateDateOfBirth,
          ),
          const SizedBox(height: AppSpacing.md),

          // Terms of Service Checkbox Row
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 24,
                height: 24,
                child: Checkbox(
                  value: isAgreedToTerms,
                  onChanged: onToggleTermsAgreement,
                  activeColor: AppColors.copperAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  side: const BorderSide(
                    color: AppColors.copperAccent,
                    width: 1.5,
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: RichText(
                  text: TextSpan(
                    style: AppTypography.screenSubtitleStyle(
                      color: AppColors.textPrimary,
                    ).copyWith(fontSize: 13.5),
                    children: [
                      const TextSpan(text: AppStrings.agreeToTermsPrefix),
                      TextSpan(
                        text: AppStrings.termsOfService,
                        style:
                            AppTypography.linkStyle().copyWith(fontSize: 13.5),
                      ),
                      const TextSpan(text: AppStrings.agreeToTermsAnd),
                      TextSpan(
                        text: AppStrings.privacyPolicy,
                        style:
                            AppTypography.linkStyle().copyWith(fontSize: 13.5),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),

          // Sign Up Button with Copper Accent Theme
          AppButton(
            label: AppStrings.signUpButton,
            onPressed: onSignUpPressed,
            isLoading: isLoading,
            gradientColors: const [
              AppColors.buttonAccentBg,
              AppColors.buttonAccentBgDark,
            ],
          ),
        ],
      ),
    );
  }
}
