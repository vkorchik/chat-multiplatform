import 'package:firebase/firebase.dart';
import 'package:firebase/firestore.dart' as fs;

/// returns default Firestore
fs.Firestore get chatAppStore => _firestore;

App _app;
fs.Firestore _firestore;
void initFirestore() {
  _app = initializeApp(
    apiKey: "YourApiKey",
    authDomain: "YourAuthDomain",
    databaseURL: "YourDatabaseUrl",
    projectId: "YourProjectId",
    storageBucket: "YourStorageBucket",
  );
  _firestore = _app.firestore();
}
