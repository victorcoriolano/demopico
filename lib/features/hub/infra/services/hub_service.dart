import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demopico/core/common/errors/repository_failures.dart';
import 'package:demopico/core/common/files_manager/enums/collections.dart';
import 'package:demopico/features/external/datasources/firebase/crud_firebase.dart';
import 'package:demopico/features/external/datasources/firebase/dto/firebase_dto.dart';
import 'package:demopico/features/external/datasources/firebase/firestore.dart';
import 'package:demopico/features/external/interfaces/i_crud_datasource.dart';
import 'package:demopico/features/hub/domain/interfaces/i_hub_service.dart';
import 'package:demopico/features/mapa/data/mappers/firebase_errors_mapper.dart';

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
    try {
      return await crudBoilerplate.create(communique);
    } on FirebaseException catch (e) {
      throw FirebaseErrorsMapper.map(e);
    } on Exception catch (e, stacktrace) {
      throw UnknownFailure(originalException: e, stackTrace: stacktrace);
    } catch (e) {
      throw UnknownFailure(unknownError: e);
    }
  }
  
  @override
  Future<void> delete(String id) async {
    try {
      await crudBoilerplate.delete(id);
    } on FirebaseException catch (e) {
      throw FirebaseErrorsMapper.map(e);
    } on Exception catch (e, stacktrace) {
      throw UnknownFailure(originalException: e, stackTrace: stacktrace);
    } catch (e) {
      throw UnknownFailure(unknownError: e);
    }
  }
  
  @override
  Stream<List<FirebaseDTO>> list() {
    try {
      return crudBoilerplate.watch();
    } on FirebaseException catch (e) {
      throw FirebaseErrorsMapper.map(e);
    } on Exception catch (e, stacktrace) {
      throw UnknownFailure(originalException: e, stackTrace: stacktrace);
    } catch (e) {
      throw UnknownFailure(unknownError: e);
    }
  }
  
  @override
  Future<FirebaseDTO> update(FirebaseDTO communique) async {
    try {
      return await crudBoilerplate.update(communique);
    } on FirebaseException catch (e) {
      throw FirebaseErrorsMapper.map(e);
    } on Exception catch (e, stacktrace) {
      throw UnknownFailure(originalException: e, stackTrace: stacktrace);
    } catch (e) {
      throw UnknownFailure(unknownError: e);
    }
  }
}
