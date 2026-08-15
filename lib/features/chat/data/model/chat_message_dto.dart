import '../../domain/entity/chat_message_entity.dart';

/// Chat message DTO mapping data models to domain entities.
class ChatMessageDto {
  final String id;
  final String senderId;
  final String content;
  final String timestamp;
  final bool isUser;
  final String type;
  final String? voiceDuration;
  final bool isRead;

  const ChatMessageDto({
    required this.id,
    required this.senderId,
    required this.content,
    required this.timestamp,
    required this.isUser,
    required this.type,
    this.voiceDuration,
    this.isRead = true,
  });

  ChatMessageEntity toEntity() {
    ChatMessageType messageType;
    switch (type) {
      case 'voice':
        messageType = ChatMessageType.voice;
        break;
      case 'heartReaction':
        messageType = ChatMessageType.heartReaction;
        break;
      default:
        messageType = ChatMessageType.text;
    }

    return ChatMessageEntity(
      id: id,
      senderId: senderId,
      content: content,
      timestamp: timestamp,
      isUser: isUser,
      type: messageType,
      voiceDuration: voiceDuration,
      isRead: isRead,
    );
  }
}
