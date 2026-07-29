import 'package:flutter/material.dart';
import '../../../../app/localization/app_strings.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_typography.dart';

/// Modular text component displaying logo, taglines, and quote.
class WelcomeTextWidget extends StatelessWidget {
  const WelcomeTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Brand Title
        Text(
          AppStrings.appName,
          style: AppTypography.logoStyle(),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSpacing.lg),

        // Tagline Line 1 & 2
        Text(
          AppStrings.taglineLine1,
          style: AppTypography.taglineStyle(),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSpacing.xxs),
        Text(
          AppStrings.taglineLine2,
          style: AppTypography.taglineStyle(),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSpacing.xl),

        // Quote Text
        Text(
          AppStrings.quoteText,
          style: AppTypography.quoteStyle(),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
