import '../model/chat_message_dto.dart';

abstract class ChatLocalDataSource {
  Future<List<ChatMessageDto>> getMessages();
  Future<ChatMessageDto> sendMessage(String text);
}

class ChatLocalDataSourceImpl implements ChatLocalDataSource {
  final List<ChatMessageDto> _messages = [
    const ChatMessageDto(
      id: 'msg_1',
      senderId: 'partner_neha',
      content: 'Hey you! 👋\nHow was your day?',
      timestamp: '9:30 PM',
      isUser: false,
      type: 'text',
    ),
    const ChatMessageDto(
      id: 'msg_2',
      senderId: 'user_suraj',
      content: 'It was good when I\ntalked to you ❤️',
      timestamp: '9:32 PM',
      isUser: true,
      type: 'text',
    ),
    const ChatMessageDto(
      id: 'msg_3',
      senderId: 'partner_neha',
      content: '',
      timestamp: '9:33 PM',
      isUser: false,
      type: 'voice',
      voiceDuration: '0:16',
    ),
    const ChatMessageDto(
      id: 'msg_4',
      senderId: 'user_suraj',
      content: 'Miss you so much! 🥺',
      timestamp: '9:34 PM',
      isUser: true,
      type: 'text',
    ),
    const ChatMessageDto(
      id: 'msg_5',
      senderId: 'partner_neha',
      content: '❤️',
      timestamp: '9:35 PM',
      isUser: false,
      type: 'heartReaction',
    ),
  ];

  @override
  Future<List<ChatMessageDto>> getMessages() async {
    return List.from(_messages);
  }

  @override
  Future<ChatMessageDto> sendMessage(String text) async {
    final newMsg = ChatMessageDto(
      id: 'msg_${DateTime.now().millisecondsSinceEpoch}',
      senderId: 'user_suraj',
      content: text,
      timestamp: '9:36 PM',
      isUser: true,
      type: 'text',
    );
    _messages.add(newMsg);
    return newMsg;
  }
}
