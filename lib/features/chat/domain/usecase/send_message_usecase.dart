import '../entity/chat_message_entity.dart';
import '../repository/chat_repository.dart';

/// UseCase to send a chat message.
class SendMessageUseCase {
  final ChatRepository _repository;

  SendMessageUseCase(this._repository);

  Future<ChatMessageEntity> execute(String text) async {
    return await _repository.sendMessage(text);
  }
}
