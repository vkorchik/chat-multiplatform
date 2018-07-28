import 'package:chat_shared/services/message_service.dart';
import 'package:chat_shared/services/echo_message_service.dart';

import 'firestore_message_service.dart';

var _echoService = new EchoMessageService();
var _firestoreService = new FirestoreMessageService();
MessageService createMessageService() => _firestoreService;
