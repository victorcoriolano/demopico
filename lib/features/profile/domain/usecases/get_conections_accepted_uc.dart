
import 'package:demopico/core/common/errors/failure_server.dart';
import 'package:demopico/features/profile/domain/interfaces/i_network_repository.dart';
import 'package:demopico/features/profile/domain/models/relationship.dart';
import 'package:flutter/material.dart';

class GetConectionsAcceptedUc {
  final INetworkRepository _repository;

  GetConectionsAcceptedUc({ required INetworkRepository repository}): _repository = repository;

  Future<List<Relationship>> execute(String idUser){
    try {
      final relationships = _repository.getRelationshipAccepted(idUser);
      debugPrint("Relationships for $idUser: $relationships");
      return relationships;
    } on Failure catch (e){
      debugPrint("UC - ERRO AO PEGAR RELATIONSHIP: $e");
      rethrow;
    }
  }
}