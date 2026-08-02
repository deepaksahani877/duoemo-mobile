import 'package:flutter/material.dart';
import '../../../../app/localization/app_strings.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_typography.dart';

/// Modular header widget for Create New Password screen matching screenshot design.
class CreatePasswordHeaderWidget extends StatelessWidget {
  final VoidCallback onBackPressed;

  const CreatePasswordHeaderWidget({
    super.key,
    required this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Back Button
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
        const SizedBox(height: AppSpacing.md),

        // Lock Badge Graphic Icon
        Container(
          width: 96.0,
          height: 96.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.shieldBg,
            border: Border.all(
              color: AppColors.copperAccent.withAlpha(25),
              width: 1.0,
            ),
          ),
          child: Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Icon(
                  Icons.lock_outline_rounded,
                  size: 48.0,
                  color: AppColors.copperAccent,
                ),
                Positioned(
                  bottom: 14.0,
                  child: Icon(
                    Icons.favorite,
                    size: 14.0,
                    color: AppColors.copperAccent,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.lg),

        // Screen Heading
        Text(
          AppStrings.createNewPasswordHeading,
          style: AppTypography.screenTitleStyle().copyWith(fontSize: 26.0),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSpacing.xs),

        // Subtitle Description
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
          child: Text(
            AppStrings.createNewPasswordSubtitle,
            textAlign: TextAlign.center,
            style: AppTypography.screenSubtitleStyle().copyWith(height: 1.35),
          ),
        ),
      ],
    );
  }
}
