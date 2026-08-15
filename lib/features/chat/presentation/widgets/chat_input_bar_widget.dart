import 'package:flutter/material.dart';
import '../../../../app/localization/app_strings.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_typography.dart';

/// Modular bottom message input bar for Chat screen.
class ChatInputBarWidget extends StatefulWidget {
  final ValueChanged<String> onSendMessage;
  final VoidCallback? onEmojiPressed;
  final VoidCallback? onGalleryPressed;
  final VoidCallback? onMicPressed;

  const ChatInputBarWidget({
    super.key,
    required this.onSendMessage,
    this.onEmojiPressed,
    this.onGalleryPressed,
    this.onMicPressed,
  });

  @override
  State<ChatInputBarWidget> createState() => _ChatInputBarWidgetState();
}

class _ChatInputBarWidgetState extends State<ChatInputBarWidget> {
  late final TextEditingController _controller;
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _controller.addListener(() {
      setState(() {
        _hasText = _controller.text.trim().isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleSend() {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      widget.onSendMessage(text);
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppRadius.pill),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(10),
            blurRadius: 18.0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Input TextField
          Expanded(
            child: TextField(
              controller: _controller,
              style: AppTypography.inputTextStyle().copyWith(
                fontSize: 15.0,
              ),
              decoration: InputDecoration(
                hintText: AppStrings.typeMessagePlaceholder,
                hintStyle: AppTypography.hintStyle().copyWith(
                  fontSize: 15.0,
                ),
                border: InputBorder.none,
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
              ),
              onSubmitted: (_) => _handleSend(),
            ),
          ),

          // Emoji Icon
          IconButton(
            onPressed: widget.onEmojiPressed,
            icon: const Icon(
              Icons.sentiment_satisfied_alt_rounded,
              color: AppColors.inputIcon,
              size: 24.0,
            ),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
          const SizedBox(width: AppSpacing.xs),

          // Gallery Icon
          IconButton(
            onPressed: widget.onGalleryPressed,
            icon: const Icon(
              Icons.image_outlined,
              color: AppColors.inputIcon,
              size: 24.0,
            ),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
          const SizedBox(width: AppSpacing.xs),

          // Mic / Send Icon
          IconButton(
            onPressed: _hasText ? _handleSend : widget.onMicPressed,
            icon: Icon(
              _hasText ? Icons.send_rounded : Icons.mic_none_rounded,
              color: _hasText ? AppColors.copperAccent : AppColors.inputIcon,
              size: 24.0,
            ),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ],
      ),
    );
  }
}
