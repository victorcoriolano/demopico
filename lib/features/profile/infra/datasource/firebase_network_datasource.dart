import 'package:demopico/core/common/files_manager/enums/collections.dart';
import 'package:demopico/features/external/datasources/firebase/crud_firebase.dart';
import 'package:demopico/features/external/datasources/firebase/dto/firebase_dto.dart';
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
  Future<void> deleteConnection(FirebaseDTO dto) async {
    await _crudFirebaseBoilerplate.delete(dto.id);
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
}
