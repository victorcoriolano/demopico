import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demopico/features/mapa/domain/entities/filters.dart';
import 'package:demopico/features/mapa/domain/entities/pico_entity.dart';
import 'package:demopico/features/mapa/domain/interfaces/i_spot_repository.dart';
import 'package:demopico/features/mapa/domain/models/pico_model.dart';

class FirebaseSpotsService implements ISpotRepository {

  static FirebaseSpotsService? _firebaseSpotsService;
  
     static FirebaseSpotsService get getInstance{
    _firebaseSpotsService ??= FirebaseSpotsService();
    return _firebaseSpotsService!;
  } 

  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  FirebaseSpotsService();

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
  Future<PicoModel> updateSpot(Pico pico) async {
    try {
      final snapshotRef = _firebaseFirestore.collection('spots').doc(pico.id);

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
      
    } catch (e) {
      throw Exception("Erro inesperado: $e");
    }
  }

  @override
  Future<void> deleteSpot(String id) async {
    try {
      await _firebaseFirestore.collection('spots').doc(id).delete();
    } catch (e) {
      throw Exception("Erro ao deletar o pico: $e");
    }
  }

  @override
  Stream<List<PicoModel>> loadSpots([Filters? filtro]) {
    final query = executeQuery(filtro);
    try {
      return query.snapshots().map((snapshot) => snapshot.docs
          .map((doc) =>
              PicoModel.fromJson(doc.data() as Map<String, dynamic>, doc.id))
          .toList());
    } on Exception catch (e) {
      throw Exception("Erro ao carregar os piquersons: $e");
    }
  }
  
  Query executeQuery([Filters? filtro]) {
    Query querySnapshot = _firebaseFirestore.collection("spots");

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
      final snapshot = await _firebaseFirestore.collection("spots").doc(id).get();
      if (snapshot.data() == null) throw Exception("Dados nulos");
      return PicoModel.fromJson(snapshot.data()! , id);
    }on FirebaseException catch (e){
      throw Exception("Erro no firebase: $e ");
    }
  }
}
