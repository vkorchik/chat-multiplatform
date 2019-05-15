import 'package:chat_shared/data/message.dart';
import 'package:chat_shared/services/message_service.dart';

import 'firestore_init.dart';
import 'package:firebase/firestore.dart';

class FirestoreMessageService extends MessageService {
  CollectionReference _fsMessages = chatAppStore.collection("messages");

  List<Message> _cachedMessages;

  MessagesUpdatedCallback _callback;

  FirestoreMessageService() {
    _fsMessages
        .orderBy('creationTime', 'desc')
        .limit(15)
        .onSnapshot
        .where((snapshot) => !snapshot.empty)
        .map((snapshot) => snapshot.docs)
        .map((docs) =>
            docs.map(_mapDocument).toList().reversed.toList(growable: false))
        .listen(_onMessagesReceived);
  }

  @override
  void send(String username, String message) {
    _fsMessages.add({
      "content": message,
      "username": username,
      "creationTime": FieldValue.serverTimestamp(),
    });
  }

  @override
  void setOnMessagesUpdatedCallback(MessagesUpdatedCallback callback) {
    _callback = callback;
    _triggerCallback();
  }

  Message _mapDocument(DocumentSnapshot ds) =>
      new Message(ds.data()['username'], ds.data()['content']);

  void _onMessagesReceived(List<Message> messages) {
    _cachedMessages = messages;
    _triggerCallback();
  }

  void _triggerCallback() {
    if (_cachedMessages != null && _callback != null) {
      _callback(_cachedMessages);
    }
  }
}
