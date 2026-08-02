import 'package:flutter/material.dart';
import '../../../../app/constants/app_assets.dart';
import '../../../../app/localization/app_strings.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_typography.dart';

/// Modular card displaying the Live Connection status between partners.
class LiveConnectionCardWidget extends StatelessWidget {
  final String partnerName;
  final bool isConnected;

  const LiveConnectionCardWidget({
    super.key,
    required this.partnerName,
    required this.isConnected,
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
            color: Colors.black.withAlpha(8),
            blurRadius: 20.0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Top Label & Connected Badge Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.liveConnectionTitle,
                      style: AppTypography.screenTitleStyle().copyWith(
                        fontSize: 17.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 2.0),
                    Text(
                      'You & $partnerName',
                      style: AppTypography.screenSubtitleStyle().copyWith(
                        fontSize: 13.5,
                      ),
                    ),
                  ],
                ),
              ),
              if (isConnected)
                Padding(
                  padding: const EdgeInsets.only(left: AppSpacing.xs),
                  child: Text(
                    AppStrings.connectedStatus,
                    style: AppTypography.screenSubtitleStyle().copyWith(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF2E7D32),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),

          // Avatars & Concentric Heart Pulse Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Partner 1 Avatar (Suraj)
              Container(
                width: 72.0,
                height: 72.0,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage(AppAssets.avatarSuraj),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              // Center Concentric Heart Pulse Widget
              Container(
                width: 60.0,
                height: 60.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFFFFF9F5),
                  border: Border.all(
                    color: AppColors.copperAccent.withAlpha(30),
                    width: 1.5,
                  ),
                ),
                child: Center(
                  child: Container(
                    width: 44.0,
                    height: 44.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFFFFF2EB),
                      border: Border.all(
                        color: AppColors.copperAccent.withAlpha(50),
                        width: 1.0,
                      ),
                    ),
                    child: const Icon(
                      Icons.favorite,
                      size: 22.0,
                      color: AppColors.copperAccent,
                    ),
                  ),
                ),
              ),

              // Partner 2 Avatar (Neha)
              Container(
                width: 72.0,
                height: 72.0,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage(AppAssets.avatarNeha),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
