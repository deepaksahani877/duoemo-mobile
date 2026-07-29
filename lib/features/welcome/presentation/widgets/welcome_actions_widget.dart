import 'package:flutter/material.dart';
import '../../../../app/localization/app_strings.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/widgets/app_button.dart';

/// Modular actions widget for primary and secondary welcome buttons.
class WelcomeActionsWidget extends StatelessWidget {
  final VoidCallback onCreateDuoPressed;
  final VoidCallback onAlreadyHaveAccountPressed;
  final bool isLoading;

  const WelcomeActionsWidget({
    super.key,
    required this.onCreateDuoPressed,
    required this.onAlreadyHaveAccountPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Primary Action Button
        AppButton(
          label: AppStrings.createDuoButton,
          onPressed: onCreateDuoPressed,
          isLoading: isLoading,
        ),
        const SizedBox(height: AppSpacing.md),

        // Secondary Text Button
        TextButton(
          onPressed: onAlreadyHaveAccountPressed,
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.lg,
              vertical: AppSpacing.sm,
            ),
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Text(
            AppStrings.alreadyHaveAccountButton,
            style: AppTypography.buttonSecondaryStyle(),
          ),
        ),
      ],
    );
  }
}
