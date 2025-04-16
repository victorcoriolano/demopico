import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demopico/features/mapa/data/models/pico_model.dart';
import 'package:demopico/features/mapa/domain/entities/pico_entity.dart';
import 'package:demopico/features/mapa/domain/interfaces/i_save_spot_repository.dart';
import 'package:demopico/features/user/data/models/user.dart';

class FirebaseSaveSpotRepository implements ISaveSpotRepository {
  final FirebaseFirestore _firebaseFirestore;

  FirebaseSaveSpotRepository(this._firebaseFirestore);

  @override
  Future<void> deleteSave(String userId, String picoName) async {
    try {
      await _firebaseFirestore
          .collection("picosFavoritados")
          .doc("$userId-$picoName")
          .delete();
    } catch (e) {
      // TODO
      throw Exception(e);
    }
  }

  @override
  Future<List<Pico>> listSavePico(String idUser) async {
    try {
      final snapshotListPico = await _firebaseFirestore
          .collection("picosFavoritados")
          .where("idUser", isEqualTo: idUser)
          .get();

      if (snapshotListPico.docs.isNotEmpty) {
        print("o os salvos aqui ò: ${snapshotListPico.docs}");
        final picos = await Future.wait(
          snapshotListPico.docs.map(
            (doc) async {
              final spotRef = doc['spotRef'] as DocumentReference;
              final spotSnapshot = await spotRef.get();
              return PicoModel.fromJson(
                  spotSnapshot.data() as Map<String, dynamic>);
            },
          ),
        );
        return picos;
      } else {
        print("Salvos não encontrados");
        return [];
      }
    } on FirebaseException catch (e) {
      throw Exception("Erro no firevase ao salvar pico: $e");
    } catch (e) {
      throw Exception("Erro desconhecido ao salvar pico: $e");
    }
  }

  @override
  Future<void> saveSpot(PicoModel pico, UserM user) async {
    try {
      final snapshot = await _firebaseFirestore
          .collection('spots')
          .where("id", isEqualTo: pico.picoName)
          .limit(1)
          .get();

      if (snapshot.docs.isEmpty) {
        throw Exception("Pico não encontrado");
      }

      final spotRef = snapshot.docs.first.reference;
      final userId = user.id;
      await _firebaseFirestore
          .collection("picosFavoritados")
          .doc("$userId-${pico.picoName}")
          .set({
            'idUser': userId,
            'spotRef': spotRef,
          });
    } on FirebaseException catch (e) {
      throw Exception("Erro no firevase ao salvar pico: $e");
    } catch (e) {
      throw Exception("Erro desconhecido ao salvar pico: $e");
    }
  }
}
