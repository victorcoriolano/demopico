library firestore;
import 'package:cloud_firestore/cloud_firestore.dart';

class Firestore {
  FirebaseFirestore? _firestore;
  FirebaseFirestore  get getInstance {
    _firestore ??= FirebaseFirestore.instance;
    return _firestore!;
  }

} 