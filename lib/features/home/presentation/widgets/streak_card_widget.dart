import 'package:flutter/material.dart';
import '../../../../app/localization/app_strings.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_typography.dart';

/// Modular card displaying the partner streak and flame progress.
class StreakCardWidget extends StatelessWidget {
  final int streakDays;

  const StreakCardWidget({
    super.key,
    required this.streakDays,
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
          // Top Row: Title & Streak Count
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.ourStreakTitle,
                      style: AppTypography.screenTitleStyle().copyWith(
                        fontSize: 16.5,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 2.0),
                    Text(
                      AppStrings.ourStreakSub,
                      style: AppTypography.screenSubtitleStyle().copyWith(
                        fontSize: 13.0,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  const Text(
                    '🔥',
                    style: TextStyle(fontSize: 22.0),
                  ),
                  const SizedBox(width: AppSpacing.xxs),
                  Text(
                    '$streakDays',
                    style: AppTypography.screenTitleStyle().copyWith(
                      fontSize: 24.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.xxs),
                  Text(
                    AppStrings.ourStreakLabel,
                    style: AppTypography.screenSubtitleStyle().copyWith(
                      fontSize: 12.0,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),

          // Progress Bar
          ClipRRect(
            borderRadius: BorderRadius.circular(AppRadius.pill),
            child: LinearProgressIndicator(
              value: 0.75,
              minHeight: 6.0,
              backgroundColor: const Color(0xFFF7F1EA),
              valueColor: const AlwaysStoppedAnimation<Color>(
                AppColors.copperAccent,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
