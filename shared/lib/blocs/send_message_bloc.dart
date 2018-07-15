import 'dart:async';

import 'package:chat_shared/blocs/bloc.dart';
import 'package:chat_shared/services/message_service.dart';
import 'package:chat_shared/data/username.dart' as user;
import 'package:rxdart/rxdart.dart';

/// Controls sending message UI behavior
abstract class SendMessageBloc extends Bloc {
  Sink<String> get messages;

  Stream<bool> get clearFieldEvents;
}

class SendMessageBlocImpl extends SendMessageBloc {
  final MessageService service;
  final StreamController<String> _inputMessages;
  final PublishSubject<String> _messagesSend;

  StreamSubscription<String> _subscription;

  SendMessageBlocImpl(this.service)
      : assert(service != null),
        _inputMessages = new StreamController<String>(),
        _messagesSend = new PublishSubject<String>() {
    _subscription = new Observable<String>(_inputMessages.stream)
        .where((message) => message != null && message.length > 0)
        .doOnData((message) {
      service.send(user.username, message);
    }).listen(_messagesSend.add, onError: _messagesSend.addError);
  }

  @override
  void dispose() {
    _subscription.cancel();
    _inputMessages.close();
  }

  @override
  Sink<String> get messages => _inputMessages.sink;

  @override
  Stream<bool> get clearFieldEvents => _messagesSend.map((message) {
        return true;
      });
}
