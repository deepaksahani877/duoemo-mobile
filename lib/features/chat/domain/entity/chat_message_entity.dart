enum ChatMessageType { text, voice, heartReaction }

/// Domain Entity for Chat Messages per Clean Architecture.
class ChatMessageEntity {
  final String id;
  final String senderId;
  final String content;
  final String timestamp;
  final bool isUser;
  final ChatMessageType type;
  final String? voiceDuration;
  final bool isRead;

  const ChatMessageEntity({
    required this.id,
    required this.senderId,
    required this.content,
    required this.timestamp,
    required this.isUser,
    this.type = ChatMessageType.text,
    this.voiceDuration,
    this.isRead = true,
  });
}
