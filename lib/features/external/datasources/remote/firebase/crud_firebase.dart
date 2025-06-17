import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demopico/core/common/data/dtos/firebase_dto.dart';
import 'package:demopico/core/common/data/enums/table.dart';
import 'package:demopico/features/external/datasources/remote/firebase/firestore.dart';
import 'package:demopico/features/mapa/data/mappers/firebase_errors_mapper.dart';

class CrudFirebase {
  Collections table;
  final FirebaseFirestore _firestore;
  

  static CrudFirebase? _instance;
  static CrudFirebase get getInstance => _instance ??= CrudFirebase(
    table: Collections.spots);

  CrudFirebase({required this.table})
    : _firestore = Firestore.getInstance;

  
  static void setTable(Collections table) {
    _instance?.table = table;
  }

  Future<FirebaseDTO> create(FirebaseDTO model) async{
    try {
      await _firestore.collection(table.name).add(model.data);
      return model;
    } on FirebaseException catch (e) {
      throw FirebaseErrorsMapper.map(e);
    }
  }

  Future<FirebaseDTO> read(FirebaseDTO model)async{
    try {
      await _firestore.collection(table.name).doc(model.id).get();
      return model;
    } on FirebaseException catch (e) {
      throw FirebaseErrorsMapper.map(e);
    }
  }
  Future<FirebaseDTO> update(FirebaseDTO firebaseDto) async {
    try {
      await _firestore.collection(table.name).doc(firebaseDto.id).update(firebaseDto.data);
      return firebaseDto;
    } on FirebaseException catch (e) {
      throw FirebaseErrorsMapper.map(e);
    }
  }
  Future<void> delete(FirebaseDTO model) async {
    try {
      await _firestore.collection(table.name).doc(model.id).delete();
    } on FirebaseException catch (e) {
      throw FirebaseErrorsMapper.map(e);
    }
  }
  Future<List<FirebaseDTO>> list(FirebaseDTO firebaseDto) async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection(table.name).get();
      return querySnapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return FirebaseDTO(id: doc.id, data: data);
      }).toList();
    } on FirebaseException catch (e) {
      throw FirebaseErrorsMapper.map(e);
    }
  }
  


}