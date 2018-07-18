import 'package:chat_shared/data/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chat_shared/services/message_service.dart';
import 'package:mobile/firestore_init.dart';
import 'package:rxdart/rxdart.dart';

class FirestoreMessageService implements MessageService {
  MessagesUpdatedCallback _callback;

  List<Message> _cached;

  FirestoreMessageService() {
    Observable(firestore
            .collection("messages")
            .orderBy('creationTime', descending: true)
            .limit(15)
            .snapshots())
        .where((snapshot) => snapshot.documents.isNotEmpty)
        .map((snapshot) => snapshot.documents)
        .map((documents) =>
            documents.map(_mapDocument).toList().reversed.toList())
        .listen(_triggerCallback);
  }

  @override
  void send(String username, String message) {
    firestore.collection("messages").document().setData({
      'username': username,
      'content': message,
      'creationTime': new DateTime.now().toLocal().toUtc(),
    });
  }

  @override
  void setOnMessagesUpdatedCallback(MessagesUpdatedCallback callback) {
    _callback = callback;
    _triggerCallback(_cached);
  }

  Message _mapDocument(DocumentSnapshot ds) =>
      Message(ds.data['username'], ds.data['content']);

  void _triggerCallback(List<Message> messagesListEvent) {
    _cached = messagesListEvent;
    if (_callback != null) {
      _callback(messagesListEvent);
    }
  }
}
