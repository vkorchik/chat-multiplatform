import 'package:chat_shared/blocs/messages_bloc.dart';
import 'package:chat_shared/data/message.dart';
import 'package:flutter_web/material.dart';

class MessagesList extends StatelessWidget {
  final MessagesBloc bloc;

  const MessagesList({Key key, @required this.bloc})
      : assert(bloc != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Message>>(
      stream: bloc.messages,
      builder: _buildContent,
    );
  }

  Widget _buildContent(
      BuildContext context, AsyncSnapshot<List<Message>> snapshot) {
    if (snapshot.hasData && snapshot.data.isNotEmpty) {
      return _buildList(context, snapshot.data);
    } else {
      return _buildNoDataView(context);
    }
  }

  Widget _buildNoDataView(BuildContext context) => Center(
        child: Column(
          children: <Widget>[
            Text(
              "No messages yet.",
              style: TextStyle(
                fontSize: 30.0,
              ),
            ),
            Text(
              "Write first one!",
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
          ],
        ),
      );

  Widget _buildList(BuildContext context, List<Message> data) {
    var reversed = data.reversed.toList();
    return ListView.builder(
      reverse: true,
      itemCount: reversed.length,
      itemBuilder: (context, index) {
        Message m = reversed[index];
        return _MessageItem(
          message: m,
        );
      },
    );
  }
}

class _MessageItem extends StatelessWidget {
  const _MessageItem({
    Key key,
    @required this.message,
  }) : super(key: key);

  final Message message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            message.username,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 4.0,
          ),
          Text(
            message.content,
            textAlign: TextAlign.left,
          ),
        ],
      ),
    );
  }
}
