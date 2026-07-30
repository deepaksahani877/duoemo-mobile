import 'package:flutter/material.dart';
import '../../../../app/localization/app_strings.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_typography.dart';

/// Modular header widget for the Register screen with back button and title block.
class RegisterHeaderWidget extends StatelessWidget {
  final VoidCallback onBackPressed;

  const RegisterHeaderWidget({
    super.key,
    required this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Back Navigation Icon
        IconButton(
          onPressed: onBackPressed,
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: AppColors.textPrimary,
            size: 24.0,
          ),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
        ),
        const SizedBox(height: AppSpacing.lg),

        // Title Block
        Center(
          child: Column(
            children: [
              Text(
                AppStrings.createAccountHeading,
                style: AppTypography.screenTitleStyle(),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                AppStrings.createAccountSubtitle,
                style: AppTypography.screenSubtitleStyle(),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
