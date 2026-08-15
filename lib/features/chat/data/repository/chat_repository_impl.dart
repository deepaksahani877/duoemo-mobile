import '../../domain/entity/chat_message_entity.dart';
import '../../domain/repository/chat_repository.dart';
import '../datasource/chat_local_datasource.dart';

/// Implementation of ChatRepository bridging data sources and domain use cases.
class ChatRepositoryImpl implements ChatRepository {
  final ChatLocalDataSource _dataSource;

  ChatRepositoryImpl(this._dataSource);

  @override
  Future<List<ChatMessageEntity>> getMessages() async {
    final dtos = await _dataSource.getMessages();
    return dtos.map((dto) => dto.toEntity()).toList();
  }

  @override
  Future<ChatMessageEntity> sendMessage(String text) async {
    final dto = await _dataSource.sendMessage(text);
    return dto.toEntity();
  }
}
