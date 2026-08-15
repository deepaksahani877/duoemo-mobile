import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../app/di/injection.dart';
import '../../../../core/services/logger_service.dart';
import '../../domain/entity/chat_message_entity.dart';
import '../../domain/usecase/get_chat_messages_usecase.dart';
import '../../domain/usecase/send_message_usecase.dart';

class ChatState {
  final bool isLoading;
  final List<ChatMessageEntity> messages;
  final String? errorMessage;

  const ChatState({
    this.isLoading = false,
    this.messages = const [],
    this.errorMessage,
  });

  ChatState copyWith({
    bool? isLoading,
    List<ChatMessageEntity>? messages,
    String? errorMessage,
  }) {
    return ChatState(
      isLoading: isLoading ?? this.isLoading,
      messages: messages ?? this.messages,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class ChatController extends StateNotifier<ChatState> {
  final GetChatMessagesUseCase _getChatMessagesUseCase;
  final SendMessageUseCase _sendMessageUseCase;
  final LoggerService _logger;

  ChatController(
    this._getChatMessagesUseCase,
    this._sendMessageUseCase,
    this._logger,
  ) : super(const ChatState()) {
    loadMessages();
  }

  Future<void> loadMessages() async {
    _logger.info('Loading chat messages');
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final list = await _getChatMessagesUseCase.execute();
      state = state.copyWith(isLoading: false, messages: list);
      _logger.info('Loaded ${list.length} chat messages');
    } catch (e, stackTrace) {
      _logger.error('Failed to load chat messages', e, stackTrace);
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to load messages.',
      );
    }
  }

  Future<void> sendMessage(String text) async {
    if (text.trim().isEmpty) return;

    _logger.info('Sending message: $text');
    try {
      final newMsg = await _sendMessageUseCase.execute(text.trim());
      state = state.copyWith(
        messages: [...state.messages, newMsg],
      );
      _logger.info('Message sent successfully');
    } catch (e, stackTrace) {
      _logger.error('Failed to send message', e, stackTrace);
      state = state.copyWith(
        errorMessage: 'Failed to send message.',
      );
    }
  }
}

final chatControllerProvider =
    StateNotifierProvider.autoDispose<ChatController, ChatState>((ref) {
  return ChatController(
    getIt<GetChatMessagesUseCase>(),
    getIt<SendMessageUseCase>(),
    getIt<LoggerService>(),
  );
});
