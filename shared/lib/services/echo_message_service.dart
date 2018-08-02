import 'package:chat_shared/data/message.dart';

import 'message_service.dart';

class EchoMessageService implements MessageService {
  final List<Message> _messages = [
    Message("user1", "First message"),
    Message("user2", "Second message"),
    Message("user1",
        "Longer than usual message. That should brake into few lines. Let's check if it happen.")
  ];

  MessagesUpdatedCallback _callback;

  @override
  void send(String username, String message) {
    _messages.add(new Message(
      username,
      message,
    ));
    if (_callback != null) {
      _callback(_messages);
    }
  }

  @override
  void setOnMessagesUpdatedCallback(MessagesUpdatedCallback callback) {
    _callback = callback;
    _callback(_messages);
  }
}
