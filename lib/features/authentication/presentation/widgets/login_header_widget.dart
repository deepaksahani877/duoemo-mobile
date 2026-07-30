import 'package:flutter/material.dart';
import '../../../../app/constants/app_assets.dart';
import '../../../../app/localization/app_strings.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_typography.dart';

/// Modular header for Login screen showing illustration, logo, taglines, and heart symbol.
class LoginHeaderWidget extends StatelessWidget {
  const LoginHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    final double maxIllustrationHeight = (screenHeight * 0.28).clamp(150.0, 260.0);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Top Illustration Artwork
        Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 280,
              maxHeight: maxIllustrationHeight,
            ),
            child: Image.asset(
              AppAssets.welcomeIllustration,
              fit: BoxFit.contain,
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.sm),

        // Brand Logo
        Text(
          AppStrings.appName,
          style: AppTypography.logoStyle(),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSpacing.xs),

        // Subtitles
        Text(
          AppStrings.loginTaglineLine1,
          style: AppTypography.taglineStyle(),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSpacing.xxs),
        Text(
          AppStrings.loginTaglineLine2,
          style: AppTypography.taglineStyle(),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSpacing.xs),

        // Small Heart Symbol
        const Icon(
          Icons.favorite,
          size: 10.0,
          color: AppColors.copperAccent,
        ),
      ],
    );
  }
}
