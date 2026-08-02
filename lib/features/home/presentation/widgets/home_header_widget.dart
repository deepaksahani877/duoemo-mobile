import 'package:flutter/material.dart';
import '../../../../app/constants/app_assets.dart';
import '../../../../app/localization/app_strings.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_typography.dart';

/// Modular top header for Home screen with greeting, notification icon, and user avatar.
class HomeHeaderWidget extends StatelessWidget {
  final String userName;
  final VoidCallback? onNotificationPressed;
  final VoidCallback? onProfilePressed;

  const HomeHeaderWidget({
    super.key,
    required this.userName,
    this.onNotificationPressed,
    this.onProfilePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Greeting & User Name
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              AppStrings.goodEveningGreeting,
              style: AppTypography.screenSubtitleStyle(),
            ),
            const SizedBox(height: AppSpacing.xxs),
            Text(
              userName,
              style: AppTypography.screenTitleStyle(),
            ),
          ],
        ),

        // Right side: Bell icon & User Avatar
        Row(
          children: [
            // Notification Bell
            IconButton(
              onPressed: onNotificationPressed,
              icon: const Icon(
                Icons.notifications_none_rounded,
                size: 26.0,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(width: AppSpacing.xs),

            // Profile Avatar
            GestureDetector(
              onTap: onProfilePressed,
              child: Container(
                width: 44.0,
                height: 44.0,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage(AppAssets.avatarSuraj),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
