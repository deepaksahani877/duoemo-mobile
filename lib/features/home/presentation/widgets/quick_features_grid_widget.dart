import 'package:flutter/material.dart';
import '../../../../app/localization/app_strings.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_typography.dart';

/// Modular grid displaying 6 quick feature cards.
class QuickFeaturesGridWidget extends StatelessWidget {
  final VoidCallback? onLoveMessagesTap;
  final VoidCallback? onVoiceNotesTap;
  final VoidCallback? onGalleryTap;
  final VoidCallback? onCalendarTap;
  final VoidCallback? onToDoTap;
  final VoidCallback? onMoreTap;

  const QuickFeaturesGridWidget({
    super.key,
    this.onLoveMessagesTap,
    this.onVoiceNotesTap,
    this.onGalleryTap,
    this.onCalendarTap,
    this.onToDoTap,
    this.onMoreTap,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: AppSpacing.sm,
      mainAxisSpacing: AppSpacing.sm,
      childAspectRatio: 0.82,
      children: [
        _FeatureCard(
          icon: Icons.favorite,
          iconColor: AppColors.copperAccent,
          title: AppStrings.loveMessagesTitle,
          badgeText: AppStrings.loveMessagesBadge,
          onTap: onLoveMessagesTap,
        ),
        _FeatureCard(
          icon: Icons.mic_none_rounded,
          iconColor: AppColors.copperAccent,
          title: AppStrings.voiceNotesTitle,
          badgeText: AppStrings.voiceNotesBadge,
          onTap: onVoiceNotesTap,
        ),
        _FeatureCard(
          icon: Icons.image_outlined,
          iconColor: AppColors.copperAccent,
          title: AppStrings.galleryTitle,
          badgeText: AppStrings.galleryBadge,
          onTap: onGalleryTap,
        ),
        _FeatureCard(
          icon: Icons.calendar_month_outlined,
          iconColor: AppColors.copperAccent,
          title: AppStrings.calendarTitle,
          badgeText: AppStrings.calendarBadge,
          onTap: onCalendarTap,
        ),
        _FeatureCard(
          icon: Icons.format_list_bulleted_rounded,
          iconColor: AppColors.copperAccent,
          title: AppStrings.toDoTitle,
          badgeText: AppStrings.toDoBadge,
          onTap: onToDoTap,
        ),
        _FeatureCard(
          icon: Icons.more_horiz_rounded,
          iconColor: AppColors.textPrimary,
          title: AppStrings.moreTitle,
          badgeText: '',
          onTap: onMoreTap,
        ),
      ],
    );
  }
}

class _FeatureCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String badgeText;
  final VoidCallback? onTap;

  const _FeatureCard({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.badgeText,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppRadius.medium),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(5),
            blurRadius: 12.0,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(AppRadius.medium),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.sm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  icon,
                  size: 24.0,
                  color: iconColor,
                ),
                const Spacer(),
                Text(
                  title,
                  style: AppTypography.screenTitleStyle().copyWith(
                    fontSize: 13.0,
                    fontWeight: FontWeight.w700,
                    height: 1.2,
                  ),
                ),
                if (badgeText.isNotEmpty) ...[
                  const SizedBox(height: 2.0),
                  Text(
                    badgeText,
                    style: AppTypography.screenSubtitleStyle().copyWith(
                      fontSize: 11.0,
                      color: AppColors.textSubtle,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
