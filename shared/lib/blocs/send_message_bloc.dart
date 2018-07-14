import 'dart:async';

import 'package:chat_shared/blocs/bloc.dart';

/// Controls sending message UI behavior
abstract class SendMessageBloc extends Bloc {
  Sink<String> get messages;
  Stream<bool> get clearFieldEvents;
}
