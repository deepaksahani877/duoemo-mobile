import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_typography.dart';
import '../../domain/entity/chat_message_entity.dart';

/// Modular voice note audio player message bubble widget.
class VoiceNoteBubbleWidget extends StatelessWidget {
  final ChatMessageEntity message;
  final VoidCallback? onPlayPressed;

  const VoiceNoteBubbleWidget({
    super.key,
    required this.message,
    this.onPlayPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(AppRadius.medium),
            topRight: Radius.circular(AppRadius.medium),
            bottomLeft: Radius.circular(4.0),
            bottomRight: Radius.circular(AppRadius.medium),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(5),
              blurRadius: 10.0,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Play Button
                GestureDetector(
                  onTap: onPlayPressed,
                  child: Container(
                    width: 42.0,
                    height: 42.0,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.voicePlayBg,
                    ),
                    child: const Icon(
                      Icons.play_arrow_rounded,
                      size: 26.0,
                      color: AppColors.copperAccent,
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),

                // Audio Waveform Visualization
                Row(
                  children: const [
                    _WaveBar(height: 10.0),
                    _WaveBar(height: 16.0),
                    _WaveBar(height: 22.0),
                    _WaveBar(height: 14.0),
                    _WaveBar(height: 26.0),
                    _WaveBar(height: 18.0),
                    _WaveBar(height: 24.0),
                    _WaveBar(height: 12.0),
                    _WaveBar(height: 20.0),
                    _WaveBar(height: 28.0),
                    _WaveBar(height: 16.0),
                    _WaveBar(height: 22.0),
                    _WaveBar(height: 10.0),
                  ],
                ),
                const SizedBox(width: AppSpacing.sm),

                // Duration Text
                Text(
                  message.voiceDuration ?? '0:16',
                  style: AppTypography.screenSubtitleStyle().copyWith(
                    fontSize: 13.0,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 2.0),
            Text(
              message.timestamp,
              style: AppTypography.hintStyle().copyWith(
                fontSize: 11.0,
                color: AppColors.textSubtle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _WaveBar extends StatelessWidget {
  final double height;

  const _WaveBar({required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 2.5,
      height: height,
      margin: const EdgeInsets.symmetric(horizontal: 1.5),
      decoration: BoxDecoration(
        color: AppColors.copperAccent,
        borderRadius: BorderRadius.circular(AppRadius.pill),
      ),
    );
  }
}
