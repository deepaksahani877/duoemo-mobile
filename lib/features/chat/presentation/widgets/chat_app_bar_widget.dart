import 'package:flutter/material.dart';
import '../../../../app/constants/app_assets.dart';
import '../../../../app/localization/app_strings.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_typography.dart';

/// Modular top app bar for Chat screen .
class ChatAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onBackPressed;
  final VoidCallback? onCallPressed;
  final VoidCallback? onVideoCallPressed;
  final VoidCallback? onMorePressed;

  const ChatAppBarWidget({
    super.key,
    required this.onBackPressed,
    this.onCallPressed,
    this.onVideoCallPressed,
    this.onMorePressed,
  });

  @override
  Size get preferredSize => const Size.fromHeight(68.0);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: 68.0,
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
        color: AppColors.backgroundLight,
        child: Row(
          children: [
            // Back Arrow Button
            IconButton(
              onPressed: onBackPressed,
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: AppColors.textPrimary,
                size: 20.0,
              ),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
            const SizedBox(width: AppSpacing.xs),

            // Partner Profile Avatar (Neha)
            Container(
              width: 44.0,
              height: 44.0,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage(AppAssets.avatarNeha),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),

            // Partner Name & Online Status
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.chatPartnerName,
                    style: AppTypography.screenTitleStyle().copyWith(
                      fontSize: 17.5,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 2.0),
                  Text(
                    AppStrings.chatOnlineStatus,
                    style: AppTypography.screenSubtitleStyle().copyWith(
                      fontSize: 12.5,
                      color: AppColors.successGreen,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            // Phone Call Button
            IconButton(
              onPressed: onCallPressed,
              icon: const Icon(
                Icons.phone_outlined,
                color: AppColors.textPrimary,
                size: 24.0,
              ),
            ),

            // Video Call Button
            IconButton(
              onPressed: onVideoCallPressed,
              icon: const Icon(
                Icons.videocam_outlined,
                color: AppColors.textPrimary,
                size: 24.0,
              ),
            ),

            // More Options Button
            IconButton(
              onPressed: onMorePressed,
              icon: const Icon(
                Icons.more_vert_rounded,
                color: AppColors.textPrimary,
                size: 24.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
