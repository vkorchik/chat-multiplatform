import 'dart:async';

import 'package:chat_shared/blocs/bloc.dart';
import 'package:chat_shared/data/message.dart';

/// Provides a stream of messages list to be displayed
abstract class MessagesBloc extends Bloc {
  Stream<List<Message>> get messages;
}
