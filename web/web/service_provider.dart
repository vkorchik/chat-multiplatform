import 'package:chat_shared/services/message_service.dart';
import 'package:chat_shared/services/echo_message_service.dart';

var _echoService = new EchoMessageService();
MessageService createMessageService() => _echoService;
