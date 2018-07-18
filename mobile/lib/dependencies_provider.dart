import 'package:chat_shared/blocs/messages_bloc.dart';
import 'package:chat_shared/blocs/send_message_bloc.dart';
import 'package:chat_shared/services/message_service.dart';
import 'package:mobile/firestore_message_service.dart';

MessagesBloc createMessagesBloc() => MessagesBlocImpl(_createMessagesService());

SendMessageBloc createSendMessageBloc() =>
    SendMessageBlocImpl(_createMessagesService());

MessageService messageService = FirestoreMessageService();

MessageService _createMessagesService() => messageService;
