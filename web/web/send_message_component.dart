import 'dart:async';
import 'dart:html';
import 'package:react/react.dart';
import 'package:chat_shared/blocs/send_message_bloc.dart';

import 'bloc_provider.dart';
import 'materialized/materialize.dart';

var sendMessage = ({String key}) =>
    registerComponent(() => new SendMessageComponent())({'key': key});

class SendMessageComponent extends Component {
  StreamSubscription<bool> _subscription;

  SendMessageBloc _bloc = createSendMessageBloc();

  TextAreaElement get _contentInput => ref("content");

  @override
  void componentDidMount() {
    super.componentDidMount();
    _subscription = _bloc.clearFieldEvents.listen(_clearInput);
  }

  @override
  void componentWillUnmount() {
    _subscription.cancel();
    super.componentWillUnmount();
  }

  @override
  render() {
    return div({
      'key': props['key'],
    }, [
      materialTextarea(
        {'key': 'content', 'ref': 'content', 'rows': '3'},
      ),
      materialButton({
        'key': 'sendButton',
        'onClick': (SyntheticMouseEvent me) => _sendMessage(),
      }, "Send"),
    ]);
  }

  void _sendMessage() {
    _bloc.messages.add(_contentInput.value);
  }

  void _clearInput(bool clear) {
    if (clear) {
      _contentInput.value = "";
    }
  }
}
