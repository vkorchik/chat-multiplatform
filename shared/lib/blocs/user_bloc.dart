import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:chat_shared/blocs/bloc.dart';
import 'package:chat_shared/data/username.dart' as user;

/// Interface of BLOC that collects user's name
abstract class UserBloc extends Bloc {
  Sink<String> get username;

  Stream<bool> get usernameSet;
}

class UserBlocImpl extends UserBloc {
  final _newUsernames = new StreamController<String>();
  final _usernameSet = new BehaviorSubject<bool>();

  StreamSubscription<String> _subscription;

  UserBlocImpl() {
    _subscription = _newUsernames.stream.listen((String name) {
      user.username = name;
      _usernameSet.add(true);
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    _usernameSet.close();
    _newUsernames.close();
  }

  @override
  Sink<String> get username => _newUsernames.sink;

  @override
  Stream<bool> get usernameSet =>
      _usernameSet.startWith(user.username != null).asBroadcastStream();
}
