import 'package:flutter/material.dart';
import '../../../../app/localization/app_strings.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_typography.dart';

/// Modular password requirements checklist widget.
class PasswordChecklistWidget extends StatelessWidget {
  final bool hasAtLeast8Chars;
  final bool hasUpperAndLower;
  final bool hasNumberOrSpecialChar;

  const PasswordChecklistWidget({
    super.key,
    required this.hasAtLeast8Chars,
    required this.hasUpperAndLower,
    required this.hasNumberOrSpecialChar,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _ChecklistItem(
          text: AppStrings.ruleAtLeast8Chars,
          isValid: hasAtLeast8Chars,
        ),
        const SizedBox(height: AppSpacing.xs),
        _ChecklistItem(
          text: AppStrings.ruleUppercaseLowercase,
          isValid: hasUpperAndLower,
        ),
        const SizedBox(height: AppSpacing.xs),
        _ChecklistItem(
          text: AppStrings.ruleNumberSpecialChar,
          isValid: hasNumberOrSpecialChar,
        ),
      ],
    );
  }
}

class _ChecklistItem extends StatelessWidget {
  final String text;
  final bool isValid;

  const _ChecklistItem({
    required this.text,
    required this.isValid,
  });

  @override
  Widget build(BuildContext context) {
    final color = isValid ? AppColors.strengthGreen : AppColors.textSubtle;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          isValid
              ? Icons.check_circle_outline_rounded
              : Icons.radio_button_unchecked_rounded,
          size: 18.0,
          color: color,
        ),
        const SizedBox(width: AppSpacing.xs),
        Expanded(
          child: Text(
            text,
            style: AppTypography.screenSubtitleStyle().copyWith(
              fontSize: 13.0,
              color: color,
              fontWeight: isValid ? FontWeight.w500 : FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}
