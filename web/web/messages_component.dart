import 'package:chat_shared/blocs/messages_bloc.dart';
import 'package:chat_shared/data/message.dart';
import 'package:react/react.dart';

import 'bloc_provider.dart';
import 'materialized/materialize.dart';

messagesComponent({String key, MessagesBloc bloc}) =>
    _messagesComponent({'key': key, 'bloc': bloc});
var _messagesComponent = registerComponent(() => new MessagesComponent());

class MessagesComponent extends Component {
  MessagesBloc get _bloc => createMessagesBloc();

  @override
  render() {
    List<Message> messages = state['messages'];
    int index = 0;
    return div(
        {},
        collection(
            {},
            messages
                .map((m) => _messageItem(
                    {'key': "mi:${m.hashCode}:${index++}", 'message': m}))
                .toList()));
  }

  @override
  Map getInitialState() {
    return {
      'messages': <Message>[],
    };
  }

  @override
  void componentDidMount() {
    super.componentDidMount();
    _bloc.messages.listen((list) {
      setState({
        'messages': list,
      });
    });
  }
}

var _messageItem = registerComponent(() => new _MessageItemComponent());

class _MessageItemComponent extends Component {
  @override
  render() {
    Message m = props['message'];
    return collectionItem({
      'key': props['key'],
    }, [
      div({'key': 'username'}, b({}, m.username)),
      p({'key': 'content'}, m.content),
    ]);
  }
}
