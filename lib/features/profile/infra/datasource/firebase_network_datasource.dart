import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demopico/core/common/collections/collections.dart';
import 'package:demopico/features/external/datasources/firebase/crud_firebase.dart';
import 'package:demopico/features/external/datasources/firebase/dto/firebase_dto.dart';
import 'package:demopico/features/mapa/data/mappers/firebase_errors_mapper.dart';
import 'package:demopico/features/profile/domain/interfaces/i_network_datasource.dart';
import 'package:flutter/material.dart';

class FirebaseNetworkDatasource implements INetworkDatasource<FirebaseDTO> {
  final CrudFirebase _crudFirebaseBoilerplate;

  FirebaseNetworkDatasource({required CrudFirebase crudFirebase})
      : _crudFirebaseBoilerplate = crudFirebase;

  static FirebaseNetworkDatasource? _instance;

  static FirebaseNetworkDatasource get instance {
    _instance ??= FirebaseNetworkDatasource(
      crudFirebase: CrudFirebase.getInstance
        ..collection = Collections.connections,
    );
    return _instance!;
  }

  @override
  Future<FirebaseDTO> createConnection(FirebaseDTO dto) async {
    return await _crudFirebaseBoilerplate.create(dto);
  }


  @override
  Future<void> deleteConnection(String id) async {
    await _crudFirebaseBoilerplate.delete(id);
  }

  
  @override
  Future<FirebaseDTO> updateConnection(FirebaseDTO dto) async {
    return await _crudFirebaseBoilerplate.update(dto);
  }

  @override
  Future<List<FirebaseDTO>> getRelactionships({
    required String fieldRequest, 
    required String valueID, 
    required String fieldOther, 
    required String valorDoStatus}) async {
      debugPrint("Buscando relacionamentos com os filtros: $fieldRequest = $valueID, $fieldOther = $valorDoStatus");
        final dtos = await _crudFirebaseBoilerplate.readWithTwoFilters(
        field1: fieldRequest,
        value1: valueID,
        field2: fieldOther,
        value2: valorDoStatus);
        debugPrint("DTOs recebidos: ${dtos.length}");
        return dtos;
  }

  @override
  // método para pegar os relacionamentos aceitos - considerando dois cenarios (requester e addressed)
  Future<List<FirebaseDTO>> getAcceptedRelationships({ 
    required String idUser,}) async {
      debugPrint("Buscando relacionamentos aceitos");
      final datasource = _crudFirebaseBoilerplate.dataSource;
      final collections = datasource.collection(Collections.connections.name);

      try{
        final data = await collections.where(
          Filter.or(
            Filter("requesterID", isEqualTo: idUser),
            Filter("adressedID", isEqualTo: idUser),
          )
        ).get();
        return data.docs.map((doc) {
          return FirebaseDTO(data: doc.data(), id: doc.id);
        }).toList();
      }on FirebaseException catch (e) {
      debugPrint("Data Source Error: $e");
      throw FirebaseErrorsMapper.map(e);
    } catch (e, st) {
      debugPrint("${e.toString()} , ${st.toString()}");
      rethrow;
    }
  }
}
