import 'package:flutter/material.dart';
import '../../../../app/constants/app_assets.dart';
import '../../../../app/localization/app_strings.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_typography.dart';

/// Modular top header for Forgot Password screen.
class ForgotPasswordHeaderWidget extends StatelessWidget {
  final VoidCallback onBackPressed;

  const ForgotPasswordHeaderWidget({
    super.key,
    required this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Back Button Row
        Align(
          alignment: Alignment.centerLeft,
          child: IconButton(
            onPressed: onBackPressed,
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: AppColors.textPrimary,
              size: 24.0,
            ),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ),
        const SizedBox(height: AppSpacing.sm),

        // Illustration
        Image.asset(
          AppAssets.welcomeIllustration,
          width: 140.0,
          height: 140.0,
          fit: BoxFit.contain,
        ),
        const SizedBox(height: AppSpacing.xs),

        // Brand Name
        Text(
          AppStrings.appName,
          style: AppTypography.logoStyle().copyWith(fontSize: 24.0),
        ),
        const SizedBox(height: AppSpacing.xxs),

        // Brand Tagline
        Text(
          '${AppStrings.forgotPasswordTaglineLine1}\n${AppStrings.forgotPasswordTaglineLine2}',
          textAlign: TextAlign.center,
          style: AppTypography.taglineStyle().copyWith(fontSize: 10.5),
        ),
        const SizedBox(height: AppSpacing.xl),

        // Screen Heading
        Text(
          AppStrings.forgotPasswordHeading,
          style: AppTypography.screenTitleStyle(),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSpacing.xs),

        // Subtitle Description
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
          child: Text(
            AppStrings.forgotPasswordSubtitle,
            textAlign: TextAlign.center,
            style: AppTypography.screenSubtitleStyle().copyWith(height: 1.4),
          ),
        ),
      ],
    );
  }
}
