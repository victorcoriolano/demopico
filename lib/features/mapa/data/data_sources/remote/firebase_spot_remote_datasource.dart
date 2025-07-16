import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demopico/core/common/errors/repository_failures.dart';
import 'package:demopico/core/common/files_manager/enums/collections.dart';
import 'package:demopico/features/external/datasources/firebase/remote/crud_firebase.dart';
import 'package:demopico/features/mapa/data/data_sources/interfaces/i_spot_datasource.dart';
import 'package:demopico/features/external/datasources/firebase/dto/firebase_dto.dart';
import 'package:demopico/features/mapa/data/mappers/firebase_errors_mapper.dart';
import 'package:demopico/features/mapa/domain/entities/filters.dart';
import 'package:flutter/foundation.dart';

class FirebaseSpotRemoteDataSource implements ISpotDataSource<FirebaseDTO> {
  static FirebaseSpotRemoteDataSource? _firebaseSpotRemoteDataSource;

  static FirebaseSpotRemoteDataSource get getInstance =>
      _firebaseSpotRemoteDataSource ??=
          FirebaseSpotRemoteDataSource(CrudFirebase.getInstance..setcollection(Collections.spots));

  final CrudFirebase _firebaseFirestore;
  final String _collectionName = 'spots';

  FirebaseSpotRemoteDataSource(this._firebaseFirestore);

  @override
  Future<FirebaseDTO> create(FirebaseDTO data) async {
    // Salvando os dados no Firestore
    try {
      final doc =
          await _firebaseFirestore.create(data);
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
      await _firebaseFirestore.delete(id);
    } on FirebaseException catch (e) {
      throw FirebaseErrorsMapper.map(e);
    } on Exception catch (e, stacktrace) {
      throw UnknownFailure(
          originalException: e, stackTrace: stacktrace);
    }catch (e) {
      throw UnknownFailure(unknownError: e);
    }
  }

  @override
  Future<FirebaseDTO> getbyID(String id) async {

    return await _firebaseFirestore.read(id);
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
    //acessando a instancia do crud para realizar consultas com where
    Query querySnapshot = _firebaseFirestore.firestore.collection(_collectionName);

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
        querySnapshot = querySnapshot;
      }
    } catch (e, st) {
      debugPrint("Erro na consulta: $e $st");
    }
    return querySnapshot;
  }

  @override
  Future<void> update(FirebaseDTO picoDto) async {
      await _firebaseFirestore.update(picoDto);
      return;
  }
  
  @override
  Future<List<FirebaseDTO>> getList(String id) async => 
      await _firebaseFirestore.readWithFilter("userID", id); 
}
