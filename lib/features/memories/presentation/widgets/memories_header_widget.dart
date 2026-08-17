import 'package:flutter/material.dart';
import '../../../../app/localization/app_strings.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_typography.dart';

/// Top header bar for the Our Memories screen.
class MemoriesHeaderWidget extends StatelessWidget {
  final VoidCallback? onSearchPressed;
  final VoidCallback? onMorePressed;

  const MemoriesHeaderWidget({
    super.key,
    this.onSearchPressed,
    this.onMorePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Text(
            AppStrings.ourMemoriesTitle,
            style: AppTypography.screenTitleStyle().copyWith(
              fontSize: 24.0,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.xs),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: onSearchPressed,
              icon: const Icon(
                Icons.search_rounded,
                size: 24.0,
                color: AppColors.textPrimary,
              ),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
            const SizedBox(width: AppSpacing.sm),
            IconButton(
              onPressed: onMorePressed,
              icon: const Icon(
                Icons.more_vert_rounded,
                size: 24.0,
                color: AppColors.textPrimary,
              ),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          ],
        ),
      ],
    );
  }
}
