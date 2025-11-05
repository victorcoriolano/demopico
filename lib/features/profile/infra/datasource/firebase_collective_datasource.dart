import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demopico/core/app/routes/app_routes.dart';
import 'package:demopico/core/common/collections/collections.dart';
import 'package:demopico/features/external/datasources/firebase/crud_firebase.dart';
import 'package:demopico/features/external/datasources/firebase/dto/firebase_dto.dart';
import 'package:demopico/features/external/datasources/firebase/firestore.dart';
import 'package:demopico/features/external/interfaces/i_crud_datasource.dart';
import 'package:demopico/features/profile/domain/interfaces/i_coletivo_datasource.dart';

class FirebaseCollectiveDatasource implements IColetivoDatasource {
  final ICrudDataSource<FirebaseDTO, FirebaseFirestore> _crudBoilerplate;
    static FirebaseCollectiveDatasource? _instance;

    FirebaseCollectiveDatasource({ required ICrudDataSource<FirebaseDTO, FirebaseFirestore> crudDatasoure}):_crudBoilerplate = crudDatasoure;
    static FirebaseCollectiveDatasource get instance =>
      _instance ??= FirebaseCollectiveDatasource(crudDatasoure: CrudFirebase(collection: Collections.collectives, firestore: Firestore.getInstance));
  
  @override
  Future<void> addUserOnCollective(FirebaseDTO user) {
    // TODO: implement addUserOnCollective
    throw UnimplementedError();
  }

  @override
  Future<FirebaseDTO> createColetivo(FirebaseDTO coletivo) async {
    return await _crudBoilerplate.create(coletivo);
  }

  @override
  Future<FirebaseDTO> getCollectivoDoc(String id) async {
    return await _crudBoilerplate.read(id);
  }

  @override
  Future<void> removeUser(FirebaseDTO user) {
    // TODO: implement removeUser
    throw UnimplementedError();
  }

  @override
  Future<void> requestEntry(FirebaseDTO user) {
    // TODO: implement requestEntry
    throw UnimplementedError();
  }

  @override
  Future<void> updateColetivo(FirebaseDTO coletivo) async {
    await _crudBoilerplate.update(coletivo);
  }
  
  @override
  Future<List<FirebaseDTO>> getCollectiveForProfile(String idProfile) async {
     return await _crudBoilerplate.readArrayContains(field: "members", value: idProfile);
  }

}