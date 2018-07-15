import 'dart:async';

import 'package:chat_shared/blocs/bloc.dart';
import 'package:chat_shared/data/message.dart';
import 'package:chat_shared/services/message_service.dart';
import 'package:rxdart/rxdart.dart';

/// Provides a stream of messages list to be displayed
abstract class MessagesBloc extends Bloc {
  Stream<List<Message>> get messages;
}

class MessagesBlocImpl extends MessagesBloc {
  final MessageService messageService;
  final BehaviorSubject<List<Message>> _messages;

  MessagesBlocImpl(this.messageService)
      : assert(messageService != null),
        _messages = new BehaviorSubject(seedValue: []) {
    messageService.setOnMessagesUpdatedCallback((list) {
      _messages.add(list);
    });
  }

  @override
  void dispose() {
    messageService.setOnMessagesUpdatedCallback(null);
    _messages.close();
  }

  @override
  Stream<List<Message>> get messages => _messages.asBroadcastStream();
}
