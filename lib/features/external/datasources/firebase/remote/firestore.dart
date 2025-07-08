import 'package:cloud_firestore/cloud_firestore.dart';

class Firestore {
  static FirebaseFirestore? _firestore;
  static FirebaseFirestore get getInstance {
    _firestore ??= FirebaseFirestore.instance;
    _firestore!.settings = const Settings(
      persistenceEnabled: true,
      cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
    );
    return _firestore!;
  }
}
