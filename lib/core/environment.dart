import 'package:firebase_core/firebase_core.dart';

class Environment {
  static final Environment instance = Environment._instance();

  factory Environment() {
    return instance;
  }

  Environment._instance();

  Future<FirebaseApp> firebaseInit() async {
    return Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: String.fromEnvironment('API_KEY'),
        authDomain: String.fromEnvironment('AUTH_DOMAIN'),
        projectId: String.fromEnvironment('PROJECT_ID'),
        storageBucket: String.fromEnvironment('STORAGE_BUCKET'),
        messagingSenderId: String.fromEnvironment('MESSAGING_SENDER_ID'),
        appId: String.fromEnvironment('APP_ID'),
        measurementId: String.fromEnvironment('MEASUREMENT_ID'),
      ),
    );
  }
}
