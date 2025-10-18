import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class FirebaseDTO {
  String _id;
  final Map<String, dynamic> data;

  FirebaseDTO({required String id, required this.data}) : _id = id;

  FirebaseDTO copyWith({
    String? id,
    Map<String, dynamic>? data,
  }) {
    return FirebaseDTO(
      id: id ?? _id,
      data: data ?? this.data,
    );
  }

  String get id => _id;

  set setId(String newId) {
    _id = newId;
  }

  factory FirebaseDTO.fromDocumentSnapshot(DocumentSnapshot document){
    return FirebaseDTO(
      id: document.id, 
      data: document.data() as Map<String, dynamic>);
  }

  FirebaseDTO resolveReference(String nameField){
    final currentData = data;

    if (currentData.containsKey(nameField) && currentData[nameField] is DocumentReference){

      final copyData = Map<String, dynamic>.from(currentData);

      copyData[nameField] = (currentData[nameField] as DocumentReference).id;

      debugPrint(copyData[nameField]);
      return copyWith(data: copyData);
    }
    return this;
  }



}
