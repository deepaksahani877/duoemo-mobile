import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_typography.dart';
import '../../domain/entity/chat_message_entity.dart';

/// Modular heart reaction message bubble widget .
class HeartReactionBubbleWidget extends StatelessWidget {
  final ChatMessageEntity message;

  const HeartReactionBubbleWidget({
    super.key,
    required this.message,
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
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              '❤️',
              style: TextStyle(fontSize: 38.0),
            ),
            const SizedBox(height: 4.0),
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
