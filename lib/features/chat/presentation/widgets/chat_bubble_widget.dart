import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_typography.dart';
import '../../domain/entity/chat_message_entity.dart';

/// Modular chat message bubble widget.
class ChatBubbleWidget extends StatelessWidget {
  final ChatMessageEntity message;

  const ChatBubbleWidget({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    final isUser = message.isUser;
    final bgColor = isUser ? AppColors.userBubbleBg : AppColors.partnerBubbleBg;
    final alignment =
        isUser ? Alignment.centerRight : Alignment.centerLeft;

    return Align(
      alignment: alignment,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.72,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(AppRadius.medium),
            topRight: const Radius.circular(AppRadius.medium),
            bottomLeft: Radius.circular(
              isUser ? AppRadius.medium : 4.0,
            ),
            bottomRight: Radius.circular(
              isUser ? 4.0 : AppRadius.medium,
            ),
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
          crossAxisAlignment:
              isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Message Content Text
            Text(
              message.content,
              style: AppTypography.inputTextStyle().copyWith(
                fontSize: 15.0,
                fontWeight: FontWeight.w500,
                height: 1.35,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 4.0),

            // Time & Status Row
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  message.timestamp,
                  style: AppTypography.hintStyle().copyWith(
                    fontSize: 11.0,
                    color: AppColors.textSubtle,
                  ),
                ),
                if (isUser) ...[
                  const SizedBox(width: 4.0),
                  const Icon(
                    Icons.done_all_rounded,
                    size: 14.0,
                    color: AppColors.copperAccent,
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
