import 'dart:async';

import 'package:chat_shared/blocs/user_bloc.dart';
import 'package:chat_shared/data/username.dart' as user;
import 'package:react/react.dart';

import 'bloc_provider.dart';
import 'materialized/materialize.dart';

var chatAppComponent = registerComponent(() => new ChatAppComponent());

class ChatAppComponent extends Component {
  final UserBloc bloc = createUserBloc();

  StreamSubscription<bool> _subscription;

  @override
  Map getInitialState() {
    return {
      "username": user.username,
    };
  }

  @override
  void componentDidMount() {
    _subscription = bloc.usernameSet.listen((_) {
      this.setState({
        "username": user.username,
      });
    });
  }

  @override
  void componentWillUnmount() {
    _subscription.cancel();
  }

  render() {
    if (state["username"] == null) {
      return usernameComponent(bloc: bloc);
    } else {
      return div({}, "Username is set to ${state["username"]}");
    }
  }
}

typedef UsernameComponent({UserBloc bloc});

var _usernameComponent = registerComponent(() => _UsernameComponent());

UsernameComponent usernameComponent =
    ({UserBloc bloc}) => _usernameComponent({"bloc": bloc});

class _UsernameComponent extends Component {
  @override
  render() {
    return div({}, [
      label({"htmlFor": "username", "key": "usernameLabel"}, "Enter nick: "),
      input({
        "placeholder": "Pick your nickname",
        "id": "username",
        "key": "usernameInput",
        "ref": "input",
      }),
      materialButton({
        "key": "usernameSubmit",
        "onClick": (SyntheticMouseEvent me) => _handleClick(),
      }, "OK"),
    ]);
  }

  void _handleClick() {
    props["bloc"].username.add(ref("input").value);
  }
}
