import '../entity/chat_message_entity.dart';
import '../repository/chat_repository.dart';

/// UseCase to fetch chat messages.
class GetChatMessagesUseCase {
  final ChatRepository _repository;

  GetChatMessagesUseCase(this._repository);

  Future<List<ChatMessageEntity>> execute() async {
    return await _repository.getMessages();
  }
}
