import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demopico/features/mapa/data/data_sources/remote/firebase_errors_mapper.dart';
import 'package:demopico/features/mapa/domain/entities/filters.dart';
import 'package:demopico/features/mapa/domain/entities/pico_entity.dart';
import 'package:demopico/features/mapa/domain/interfaces/i_spot_repository.dart';
import 'package:demopico/features/mapa/domain/models/pico_model.dart';

class FirebaseSpotsService implements ISpotRepository {

  static FirebaseSpotsService? _firebaseSpotsService;
  
  static FirebaseSpotsService get getInstance{
    _firebaseSpotsService ??= FirebaseSpotsService(firebaseFirestore: FirebaseFirestore.instance);
    return _firebaseSpotsService!;
  } 

  final FirebaseFirestore firebaseFirestore;

  FirebaseSpotsService({required this.firebaseFirestore});

  @override
  Future<PicoModel> createSpot(PicoModel pico) async {
    // Salvando os dados no Firestore
    try {
      final doc = await firebaseFirestore.collection('spots').add(
          pico.toJson() // convertendo o objeto PicoModel para um Map<String, dynamic>
          );
          
      // Retornando o objeto PicoModel com o ID gerado pelo Firestore
      return pico.copyWith(id: doc.id);

    } on FirebaseException catch (e) {
      throw FirebaseErrorsMapper.map(e);
    } catch (e) {
      throw Exception("Erro inesperado criar piquerson: $e ");
    }
  }

  @override
  Future<PicoModel> updateSpot(Pico pico) async {
    try {
      final snapshotRef = firebaseFirestore.collection('spots').doc(pico.id);

      final snapshot = await snapshotRef.get();

      if (!snapshot.exists) {
        throw Exception("Piquerson: '${pico.picoName}' não encontrado no banco de dados.");
      }
      
        await snapshot.reference.update({
          'nota': pico.nota,
          'avaliacoes': pico.numeroAvaliacoes,
        });
        final newData = await snapshotRef.get();
        return PicoModel.fromJson(newData.data()!, newData.id);
      
    } on FirebaseException catch (e) {
      throw FirebaseErrorsMapper.map(e);
    }
  }

  @override
  Future<void> deleteSpot(String id) async {
    try {
      await firebaseFirestore.collection('spots').doc(id).delete();
    } on FirebaseException catch (e) {
      throw FirebaseErrorsMapper.map(e);
    }
  }

  @override
  Stream<List<PicoModel>> loadSpots([Filters? filtro]) {
    final query = executeQuery(filtro);
    try {
      return query.snapshots().map(
        (snapshot) => snapshot.docs
          .map((doc) =>
              PicoModel.fromJson(doc.data() as Map<String, dynamic>, doc.id))
          .toList(),
        );
    } on FirebaseException catch (e) {
      throw FirebaseErrorsMapper.map(e);
    }
  }

  
  Query executeQuery([Filters? filtro]) {
    Query querySnapshot = firebaseFirestore.collection("spots");

    if (filtro != null && filtro.hasActivateFilters) {
      if (filtro.atributos!.isNotEmpty) {
        querySnapshot = querySnapshot.where("atributos",
            arrayContains: filtro.atributos);
      }

      if (filtro.utilidades!.isNotEmpty) {
        querySnapshot = querySnapshot.where("utilidades",
            arrayContainsAny: filtro.utilidades);
      }

      if (filtro.modalidade != null) {
        querySnapshot = querySnapshot.where("modalidade", isEqualTo: filtro.modalidade);
      }
      if (filtro.tipo != null) {
        querySnapshot = querySnapshot.where("tipoPico", isEqualTo: filtro.tipo);
      }
    }
    return querySnapshot;
  }
  
  @override
  Future<PicoModel> getPicoByID(String id) async {
    try{
      final snapshot = await firebaseFirestore.collection("spots").doc(id).get();
      if (snapshot.data() == null) throw Exception("Dados nulos");
      return PicoModel.fromJson(snapshot.data()! , id);
    }on FirebaseException catch (e){
      throw FirebaseErrorsMapper.map(e);
    }
  }
}
