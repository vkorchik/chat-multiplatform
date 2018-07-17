import 'package:chat_shared/blocs/messages_bloc.dart';
import 'package:chat_shared/blocs/send_message_bloc.dart';
import 'package:chat_shared/blocs/user_bloc.dart';
import 'service_provider.dart';

UserBloc createUserBloc() => UserBlocImpl();

MessagesBloc createMessagesBloc() => MessagesBlocImpl(createMessageService());

SendMessageBloc createSendMessageBloc() =>
    SendMessageBlocImpl(createMessageService());
