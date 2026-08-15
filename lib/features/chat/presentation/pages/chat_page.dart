import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/constants/app_constants.dart';
import '../../../../app/router/app_router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../domain/entity/chat_message_entity.dart';
import '../controllers/chat_controller.dart';
import '../widgets/chat_app_bar_widget.dart';
import '../widgets/chat_bubble_widget.dart';
import '../widgets/chat_input_bar_widget.dart';
import '../widgets/heart_reaction_bubble_widget.dart';
import '../widgets/voice_note_bubble_widget.dart';

/// Messaging Page.
class ChatPage extends ConsumerWidget {
  const ChatPage({super.key});

  void _onBackPressed(BuildContext context) {
    if (context.canPop()) {
      context.pop();
    } else {
      context.go(AppRoutes.home);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(chatControllerProvider);
    final controller = ref.read(chatControllerProvider.notifier);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        _onBackPressed(context);
      },
      child: Scaffold(
        backgroundColor: AppColors.backgroundLight,
        appBar: ChatAppBarWidget(
          onBackPressed: () => _onBackPressed(context),
          onCallPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Starting voice call...')),
            );
          },
          onVideoCallPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Starting video call...')),
            );
          },
          onMorePressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Chat options menu')),
            );
          },
        ),
        body: Column(
          children: [
            // Chat Messages List
            Expanded(
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: AppConstants.maxContentWidth,
                  ),
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.lg,
                      vertical: AppSpacing.md,
                    ),
                    physics: const BouncingScrollPhysics(),
                    itemCount: state.messages.length,
                    itemBuilder: (context, index) {
                      final msg = state.messages[index];
                      switch (msg.type) {
                        case ChatMessageType.voice:
                          return VoiceNoteBubbleWidget(
                            message: msg,
                            onPlayPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Playing voice note...'),
                                ),
                              );
                            },
                          );
                        case ChatMessageType.heartReaction:
                          return HeartReactionBubbleWidget(message: msg);
                        case ChatMessageType.text:
                          return ChatBubbleWidget(message: msg);
                      }
                    },
                  ),
                ),
              ),
            ),

            // Bottom Input Bar
            Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: AppConstants.maxContentWidth,
                ),
                child: ChatInputBarWidget(
                  onSendMessage: (text) => controller.sendMessage(text),
                  onEmojiPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Emoji picker')),
                    );
                  },
                  onGalleryPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Select image from gallery')),
                    );
                  },
                  onMicPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Recording voice note...')),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
