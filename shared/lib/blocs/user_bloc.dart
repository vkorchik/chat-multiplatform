import 'dart:async';

import 'package:chat_shared/blocs/bloc.dart';

/// Interface of BLOC that collects user's name
abstract class UserBloc extends Bloc {
  Sink<String> get username;
  Stream<bool> get usernameSet;
}
