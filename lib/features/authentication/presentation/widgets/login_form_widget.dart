import 'package:flutter/material.dart';
import '../../../../app/localization/app_strings.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_field.dart';

/// Modular form component for the Login screen.
class LoginFormWidget extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool isPasswordVisible;
  final bool isLoading;
  final VoidCallback onTogglePasswordVisibility;
  final VoidCallback onForgotPasswordPressed;
  final VoidCallback onSignInPressed;

  const LoginFormWidget({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.isPasswordVisible,
    required this.isLoading,
    required this.onTogglePasswordVisibility,
    required this.onForgotPasswordPressed,
    required this.onSignInPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Heading & Subtitle
        Text(
          AppStrings.welcomeBackHeading,
          style: AppTypography.screenTitleStyle(),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSpacing.xxs),
        Text(
          AppStrings.welcomeBackSubtitle,
          style: AppTypography.screenSubtitleStyle(),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSpacing.lg),

        // Email Field
        AppTextField(
          controller: emailController,
          hintText: AppStrings.emailAddressLabel,
          prefixIcon: Icons.mail_outline_rounded,
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: AppSpacing.md),

        // Password Field
        AppTextField(
          controller: passwordController,
          hintText: AppStrings.passwordLabel,
          prefixIcon: Icons.lock_outline_rounded,
          obscureText: !isPasswordVisible,
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
        const SizedBox(height: AppSpacing.sm),

        // Forgot Password Link
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: onForgotPasswordPressed,
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text(
              AppStrings.forgotPassword,
              style: AppTypography.linkStyle(),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.lg),

        // Sign In Primary Button
        AppButton(
          label: AppStrings.signInButton,
          onPressed: onSignInPressed,
          isLoading: isLoading,
        ),
      ],
    );
  }
}
