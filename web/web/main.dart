import 'dart:html';

import 'package:react/react_client.dart' as react_client;
import 'package:react/react_dom.dart' as react_dom;
import 'chat_app.dart';
import 'firestore_init.dart';

void main() {
  initFirestore();
  react_client.setClientConfiguration();
  var chatApp = chatAppComponent({});
  react_dom.render(chatApp, querySelector('#react_mount_point'));
}
