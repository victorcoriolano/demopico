
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demopico/features/mapa/domain/entities/filters.dart';
import 'package:demopico/features/mapa/domain/entities/pico_entity.dart';
import 'package:demopico/features/mapa/domain/interfaces/i_spot_repository.dart';
import 'package:demopico/features/mapa/domain/models/pico_model.dart';

class FirebaseRepositoryMap implements ISpotRepository {
  final FirebaseFirestore _firebaseFirestore;

  FirebaseRepositoryMap(this._firebaseFirestore);

  @override
  Future<PicoModel?> createSpot(PicoModel pico) async {
    // Salvando os dados no Firestore
    try {
      final doc = await _firebaseFirestore.collection('spots').add(
          pico.toJson() // convertendo o objeto PicoModel para um Map<String, dynamic>
          );
      final snapshot = await doc.get();

      if (!snapshot.exists && snapshot.data() == null) {
        throw Exception("Dados não encontrados");
      }
      final data = snapshot.data();
      return PicoModel.fromJson(data!, snapshot.id);
    } on FirebaseException catch (e) {
      throw Exception("Erro no firebase: $e ");
    } catch (e) {
      throw Exception("Erro inesperado criar piquerson: $e ");
    }
  }

  


  @override
  Future<PicoModel> salvarNota(Pico pico) async {
    try {
      final snapshotRef = _firebaseFirestore
          .collection('spots')
          .doc(pico.id);
          
      final snapshot = await snapshotRef.get();
      if (snapshot.exists) {
        await snapshot.reference.update({
          'nota': pico.nota,
          'avaliacoes': pico.numeroAvaliacoes,
        });
        final newData = await snapshotRef.get();
        return PicoModel.fromJson(newData.data()!, newData.id);
      } else {
        throw Exception("Piquerson: '${pico.picoName}' não encontrado no banco de dados.");
      }
    } catch (e) {
      throw Exception("Erro inesperado: $e");
    }
  }

  @override
  Future<void> deleteSpot(String id) async{
    try {
      await _firebaseFirestore.collection('spots').doc(id).delete();
    } catch (e) {
      throw Exception("Erro ao deletar o pico: $e");
    }
  }

  @override
  Stream<List<PicoModel>> loadSpots([Filters? filtro]) {
    //https://firebase.google.com/docs/firestore/query-data/queries?hl=pt-br#dart_4

    final query = executeQuery(filtro);
    return query.snapshots().map(
      (snapshot) => snapshot.docs.map(
        (doc) => PicoModel.fromJson(
          doc.data() as Map<String, dynamic>, 
          doc.id)
      ).toList()
    );

    
  }


  Query executeQuery([Filters? filtro]) {
    Query querySnapshot = _firebaseFirestore.collection("spots");

    if(filtro != null && filtro.hasActivateFilters){
      if(filtro.atributos!.isNotEmpty){
        return querySnapshot.where("atributos", arrayContains: filtro.atributos);
      }

      if(filtro.utilidades!.isNotEmpty){
        return querySnapshot.where("utilidades", arrayContainsAny: filtro.utilidades);
      }

      if(filtro.modalidade != null){
        return querySnapshot.where("modalidade", isEqualTo: filtro.modalidade);
      }
      if(filtro.tipo != null){
        return querySnapshot.where("tipoPico", isEqualTo: filtro.tipo);
      }
    }
    return querySnapshot;
  }
}
