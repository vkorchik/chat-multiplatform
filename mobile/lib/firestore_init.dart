import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

Firestore firestore;

Future<Null> firestoreInitialization() async {
  final FirebaseApp app = await FirebaseApp.configure(
    name: 'chatapp-shareddart',
    options: FirebaseOptions(
      // TODO put your AppID and apiKeys here
      googleAppID: Platform.isAndroid ? 'androidAppId' : 'iosAppId',
      apiKey: Platform.isAndroid ? 'androidApiKey' : 'iosApiKey',
      projectID: 'chatapp-shareddart',
    ),
  );
  firestore = new Firestore(app: app);
}
