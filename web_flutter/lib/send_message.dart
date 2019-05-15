import 'dart:async';

import 'package:chat_shared/blocs/send_message_bloc.dart';
import 'package:flutter_web/material.dart';

class SendMessage extends StatefulWidget {
  final SendMessageBloc bloc;

  SendMessage({Key key, @required this.bloc})
      : assert(bloc != null),
        super(key: key);

  @override
  _SendMessageState createState() {
    return new _SendMessageState();
  }
}

class _SendMessageState extends State<SendMessage> {
  TextEditingController _inputController;

  StreamSubscription<bool> _subscription;

  @override
  void didUpdateWidget(SendMessage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.bloc != widget.bloc) {
      _subscription.cancel();
      oldWidget.bloc.dispose();
      initStream();
    }
  }

  @override
  void initState() {
    super.initState();
    _inputController = new TextEditingController();
    initStream();
  }

  @override
  void dispose() {
    super.dispose();
    _subscription.cancel();
    widget.bloc.dispose();
    _inputController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: _inputController,
              maxLines: 3,
              autofocus: true,
            ),
          ),
          SizedBox(
            width: 4.0,
          ),
          IconButton(
            icon: Icon(
              Icons.send,
              color: Theme.of(context).primaryColor,
            ),
            onPressed: _sendMessage,
          ),
        ],
      ),
    );
  }

  void _sendMessage() {
    widget.bloc.messages.add(_inputController.text);
  }

  void initStream() {
    _subscription = widget.bloc.clearFieldEvents.listen((clear) {
      if (clear) {
        _inputController.clear();
      }
    }, onError: (e) {
      print("Error: $e");
    });
  }
}
