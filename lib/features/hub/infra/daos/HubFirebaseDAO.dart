import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demopico/features/hub/domain/entities/communique.dart';
import 'package:demopico/features/hub/infra/interfaces/IHubDao.dart';

class HubFirebaseDAO implements IHubDao{

  final FirebaseFirestore firestore;
  HubFirebaseDAO({FirebaseFirestore? firestore})
      : firestore = firestore ?? FirebaseFirestore.instance;
  
  @override
  Future<void> create(Object obj) async {
    // Fazendo o cast 
    if (obj is Communique) {
      await firestore.collection('communique').add(obj.toJsonMap());
    } else {
      throw Exception('Objeto inválido, espera-se um Communique.');
    }
  }

  @override
  Future<void> deleteObj(String id) {
    // TODO: implement deleteObj
    throw UnimplementedError();
  }

  @override
  Future<List<Object>> getAllObj() {
    // TODO: implement getAllObj
    throw UnimplementedError();
  }

  @override
  Future<Object?> getObjById(String id) {
    // TODO: implement getObjById
    throw UnimplementedError();
  }

  @override
  Future<void> updateObj(Object obj) {
    // TODO: implement updateObj
    throw UnimplementedError();
  }
  
}