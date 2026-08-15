import '../entity/chat_message_entity.dart';

/// Chat repository contract per Clean Architecture.
abstract class ChatRepository {
  Future<List<ChatMessageEntity>> getMessages();
  Future<ChatMessageEntity> sendMessage(String text);
}
