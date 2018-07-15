import 'package:chat_shared/blocs/messages_bloc.dart';
import 'package:chat_shared/services/message_service.dart';
import 'package:chat_shared/services/echo_message_service.dart';

MessagesBloc createMessagesBloc() =>
    new MessagesBlocImpl(_createMessagesService());

MessageService messageService = EchoMessageService();

MessageService _createMessagesService() => messageService;
