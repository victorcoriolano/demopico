import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demopico/core/common/errors/repository_failures.dart';
import 'package:demopico/features/mapa/data/data_sources/interfaces/spot_datasource_interface.dart';
import 'package:demopico/features/mapa/data/data_sources/remote/firebase_errors_mapper.dart';
import 'package:demopico/features/mapa/data/dtos/pico_model_firebase_dto.dart';
import 'package:demopico/features/mapa/domain/entities/filters.dart';


class FirebaseSpotRemoteDataSource implements SpotRemoteDataSource {
  final FirebaseFirestore _firebaseFirestore;
  final String _collectionName = 'spots';

  FirebaseSpotRemoteDataSource(this._firebaseFirestore);

  @override
  Future<PicoModelFirebaseDto> create(PicoModelFirebaseDto data) async {
    // Salvando os dados no Firestore
    try {
      final doc =
          await _firebaseFirestore.collection(_collectionName).add(data.data);
      //retornando id do spot criado 
      final newPico = data.copyWith(id: doc.id);
      return newPico;

    } on FirebaseException catch (e) {
      throw FirebaseErrorsMapper.map(e);
    } catch (e, stacktrace) {
      throw UnknownFailure(
          originalException: e as Exception, stackTrace: stacktrace);
    }
  }

  @override
  Future<void> delete(String id) async {
    try {
      await _firebaseFirestore.collection(_collectionName).doc(id).delete();
    } on FirebaseException catch (e) {
      throw FirebaseErrorsMapper.map(e);
    } catch (e, stacktrace) {
      throw UnknownFailure(
          originalException: e as Exception, stackTrace: stacktrace);
    }
  }

  @override
  Future<PicoModelFirebaseDto> getbyID(String id) async {
    final doc =
        await _firebaseFirestore.collection(_collectionName).doc(id).get();
    if (!doc.exists) {
      throw PicoNotFoundFailure();
    }
    final PicoModelFirebaseDto pico = PicoModelFirebaseDto(id: id, data: doc.data()!);
    return pico;
  }
  

  @override
  Stream<List<PicoModelFirebaseDto>> load([Filters? filtro]) {
    final quey = executeQuery(filtro);
    try {
      return quey.snapshots().map(
            (snapshot) => snapshot.docs
                .map((doc) {
                  PicoModelFirebaseDto pico = PicoModelFirebaseDto(
                    id: doc.id,
                    data: doc.data()! as Map<String, dynamic>,
                  );
                  return pico;
                })
                .toList(),
          );
    } on FirebaseException catch (e) {
      throw FirebaseErrorsMapper.map(e);
    } catch (e, stacktrace) {
      throw UnknownFailure(
          originalException: e as Exception, stackTrace: stacktrace);
    }
  }
  

  Query executeQuery([Filters? filtro]) {
    Query querySnapshot = _firebaseFirestore.collection(_collectionName);

    if (filtro != null && filtro.hasActivateFilters) {
      if (filtro.atributos!.isNotEmpty) {
        querySnapshot =
            querySnapshot.where("atributos", arrayContains: filtro.atributos);
      }

      if (filtro.utilidades!.isNotEmpty) {
        querySnapshot = querySnapshot.where("utilidades",
            arrayContainsAny: filtro.utilidades);
      }

      if (filtro.modalidade != null) {
        querySnapshot =
            querySnapshot.where("modalidade", isEqualTo: filtro.modalidade);
      }
      if (filtro.tipo != null) {
        querySnapshot = querySnapshot.where("tipoPico", isEqualTo: filtro.tipo);
      }
    }
    return querySnapshot;
  }


  @override
  Future<void> update(PicoModelFirebaseDto picoDto) async {
    try {
      
     await  _firebaseFirestore
          .collection(_collectionName)
          .doc(picoDto.id)
          .update(picoDto.data);

    } on FirebaseException catch (e) {
      throw FirebaseErrorsMapper.map(e);
    } catch (e, stacktrace) {
      throw UnknownFailure(
          originalException: e as Exception, stackTrace: stacktrace);
    }
  }
}
