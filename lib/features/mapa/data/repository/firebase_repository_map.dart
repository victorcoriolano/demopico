import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demopico/features/mapa/domain/entities/pico_entity.dart';
import 'package:demopico/features/mapa/domain/interfaces/i_spot_repository.dart';
import 'package:demopico/features/mapa/data/models/pico_model.dart';

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
  Future<List<PicoModel>> showAllPico() async {
    try {
      QuerySnapshot snapshot = await _firebaseFirestore
          .collection('spots')
          .get(const GetOptions(source: Source.server));
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String,
            dynamic>; // deixa o map aq quieto pq ele tem q dar baum
        return PicoModel.fromJson(data, doc.id);
      }).toList();
    } catch (e) {
      print("Erro no firebase $e");
      return [];
    }
  }

  @override
  Future<void> salvarNota(Pico pico) async {
    try {
      final snapshot = await _firebaseFirestore
          .collection('spots')
          .where('name', isEqualTo: pico.picoName)
          .limit(1)
          .get();

      if (snapshot.docs.isNotEmpty) {
        final picoReference = snapshot.docs.first.id;
        await _firebaseFirestore.collection('spots').doc(picoReference).update({
          'nota': pico.nota,
          'avaliacoes': pico.numeroAvaliacoes,
        });
      } else {
        throw Exception("Piquerson: '${pico.picoName}' não encontrado.");
      }
    } catch (e) {
      print("Erro ao salvar a nota: $e");
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
}
