import 'package:chat_shared/data/message.dart';

typedef MessagesUpdatedCallback(List<Message> recentMessages);

abstract class MessageService {
  void send(String username, String message);
  void setOnMessagesUpdatedCallback(MessagesUpdatedCallback callback);
}
