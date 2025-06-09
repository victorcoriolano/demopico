import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demopico/core/common/errors/repository_failures.dart';
import 'package:demopico/features/mapa/data/data_sources/interfaces/i_spot_datasource.dart';
import 'package:demopico/features/mapa/data/dtos/firebase_dto.dart';
import 'package:demopico/features/mapa/data/mappers/firebase_errors_mapper.dart';
import 'package:demopico/features/mapa/domain/entities/filters.dart';
import 'package:flutter/foundation.dart';

class FirebaseSpotRemoteDataSource implements ISpotRemoteDataSource {
  static FirebaseSpotRemoteDataSource? _firebaseSpotRemoteDataSource;

  static FirebaseSpotRemoteDataSource get getInstance =>
      _firebaseSpotRemoteDataSource ??=
          FirebaseSpotRemoteDataSource(FirebaseFirestore.instance);

  final FirebaseFirestore _firebaseFirestore;
  final String _collectionName = 'spots';

  FirebaseSpotRemoteDataSource(this._firebaseFirestore);

  @override
  Future<FirebaseDTO> create(FirebaseDTO data) async {
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
  Future<FirebaseDTO> getbyID(String id) async {
    final doc =
        await _firebaseFirestore.collection(_collectionName).doc(id).get();
    if (!doc.exists) {
      throw PicoNotFoundFailure();
    }
    final FirebaseDTO pico = FirebaseDTO(id: id, data: doc.data()!);
    return pico;
  }

  @override
  Stream<List<FirebaseDTO>> load([Filters? filtro]) {
    final quey = executeQuery(filtro);
    try {
      return quey.snapshots().map(
            (snapshot) => snapshot.docs.map((doc) {
              FirebaseDTO pico = FirebaseDTO(
                id: doc.id,
                data: doc.data()! as Map<String, dynamic>,
              );
              debugPrint("pico");
              return pico;
            }).toList(),
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

    try {
      if (filtro != null) {
        if (filtro.tipo != null) {
          querySnapshot = querySnapshot.where("tipo", isEqualTo: filtro.tipo);
        }
        if (filtro.atributos != null && filtro.atributos!.isNotEmpty) {
          querySnapshot =
              querySnapshot.where("atributos", arrayContains: filtro.atributos);
        }

        if (filtro.utilidades != null && filtro.utilidades!.isNotEmpty) {
          querySnapshot = querySnapshot.where("utilidades",
              arrayContainsAny: filtro.utilidades);
        }

        if (filtro.modalidade != null) {
          querySnapshot =
              querySnapshot.where("modalidade", isEqualTo: filtro.modalidade);
        }
      }
      else {
        querySnapshot = querySnapshot.limit(3);
      }
    } catch (e, st) {
      debugPrint("Erro na consulta: $e $st");
    }
    return querySnapshot;
  }

  @override
  Future<void> update(FirebaseDTO picoDto) async {
    try {
      await _firebaseFirestore
          .collection(_collectionName)
          .doc(picoDto.id)
          .update(picoDto.data);
      return;
    } on FirebaseException catch (e) {
      throw FirebaseErrorsMapper.map(e);
    } catch (e, stacktrace) {
      throw UnknownFailure(
          originalException: e as Exception, stackTrace: stacktrace);
    }
  }
}
