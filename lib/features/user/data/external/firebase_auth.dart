import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthInstance {
  FirebaseAuthInstance._();

  static FirebaseAuth get instance => FirebaseAuth.instance;
}
