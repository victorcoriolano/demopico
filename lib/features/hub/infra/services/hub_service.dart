import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demopico/core/common/files_manager/enums/collections.dart';
import 'package:demopico/features/external/datasources/firebase/crud_firebase.dart';
import 'package:demopico/features/external/datasources/firebase/dto/firebase_dto.dart';
import 'package:demopico/features/external/datasources/firebase/firestore.dart';
import 'package:demopico/features/external/interfaces/i_crud_datasource.dart';
import 'package:demopico/features/hub/domain/interfaces/i_hub_service.dart';

class HubService implements IHubService<FirebaseDTO> {
  static HubService? _hubService;

  HubService({required this.crudBoilerplate});

  static HubService get getInstance {
    _hubService ??= HubService(crudBoilerplate: CrudFirebase(collection: Collections.communique, firestore: Firestore.getInstance));
    return _hubService!;
  }

  final ICrudDataSource<FirebaseDTO, FirebaseFirestore> crudBoilerplate;
  
  @override
  Future<FirebaseDTO> create(FirebaseDTO communique) async {
    return await crudBoilerplate.create(communique);
  }
  
  @override
  Future<void> delete(String id) async {
    await crudBoilerplate.delete(id);
  }
  
  @override
  Stream<List<FirebaseDTO>> list() {
    return crudBoilerplate.watch();
  }
  
  @override
  Future<FirebaseDTO> update(FirebaseDTO communique) async {
    return await crudBoilerplate.update(communique);
  }
}
