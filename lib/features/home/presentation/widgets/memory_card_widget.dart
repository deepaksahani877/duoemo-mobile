import 'package:flutter/material.dart';
import '../../../../app/localization/app_strings.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_typography.dart';

/// Modular card displaying the Memory of the day quote.
class MemoryCardWidget extends StatelessWidget {
  final String memoryQuote;
  final VoidCallback? onFavoritePressed;

  const MemoryCardWidget({
    super.key,
    required this.memoryQuote,
    this.onFavoritePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppRadius.large),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(6),
            blurRadius: 16.0,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.memoryOfDayTitle,
            style: AppTypography.screenSubtitleStyle().copyWith(
              fontSize: 13.5,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),

          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Quote Icon Container
              Container(
                width: 38.0,
                height: 38.0,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFFAF3EC),
                ),
                child: const Icon(
                  Icons.format_quote_rounded,
                  size: 20.0,
                  color: AppColors.copperAccent,
                ),
              ),
              const SizedBox(width: AppSpacing.md),

              // Quote Text
              Expanded(
                child: Text(
                  memoryQuote,
                  style: AppTypography.quoteStyle().copyWith(
                    fontSize: 14.5,
                    fontWeight: FontWeight.w500,
                    height: 1.35,
                  ),
                ),
              ),

              // Heart Favorite Icon Button
              IconButton(
                onPressed: onFavoritePressed,
                icon: const Icon(
                  Icons.favorite_border_rounded,
                  size: 20.0,
                  color: AppColors.inputIcon,
                ),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
