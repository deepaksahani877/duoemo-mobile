import 'package:flutter/material.dart';
import '../../../../app/localization/app_strings.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_typography.dart';

/// Modular header widget for OTP Verification screen matching screenshot design.
class OtpHeaderWidget extends StatelessWidget {
  final String email;
  final VoidCallback onBackPressed;

  const OtpHeaderWidget({
    super.key,
    required this.email,
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

        // Graphic Shield Icon Badge
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
                  Icons.shield_outlined,
                  size: 48.0,
                  color: AppColors.copperAccent,
                ),
                Icon(
                  Icons.favorite,
                  size: 18.0,
                  color: AppColors.copperAccent,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.lg),

        // Screen Heading
        Text(
          AppStrings.verifyOtpHeading,
          style: AppTypography.screenTitleStyle().copyWith(fontSize: 26.0),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSpacing.xs),

        // Subtitle Description & Target Email
        Column(
          children: [
            Text(
              AppStrings.otpSentSubtitle,
              textAlign: TextAlign.center,
              style: AppTypography.screenSubtitleStyle(),
            ),
            const SizedBox(height: 2.0),
            Text(
              email,
              textAlign: TextAlign.center,
              style: AppTypography.linkStyle().copyWith(
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
