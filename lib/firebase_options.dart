import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    return const FirebaseOptions(
      apiKey: "AIzaSyDA5f0NrqzgiGpNDzBwSqgwBbI197aS4hc",
      authDomain: "tallerlibros-88c84.firebaseapp.com",
      projectId: "tallerlibros-88c84",
      storageBucket: "tallerlibros-88c84.firebasestorage.app",
      messagingSenderId: "997216763899",
      appId: "1:997216763899:web:d0b6cb86fe1edb555ad55e",
      measurementId: "G-GQ4RZHJGNG",
    );
  }
}