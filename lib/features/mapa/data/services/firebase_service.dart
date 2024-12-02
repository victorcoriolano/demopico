
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demopico/features/mapa/domain/entities/pico_entity.dart';
import 'package:demopico/features/mapa/domain/interfaces/spot_repository.dart';
import 'package:demopico/features/user/data/models/loggeduser.dart';
//import 'package:firebase_storage/firebase_storage.dart';

class FirebaseServiceMap implements SpotRepository{
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  @override
  Future<void> createSpot(Pico pico) async {
    /* String imageUrl = '';
      // upload da imagem para o Storage
      if(pico.fotoPico != null){
      final ref = FirebaseStorage.instance
          .ref()
          .child('spots_images')
          .child('images/${pico.picoName.toString()}.jpg');
      await ref.putFile(pico.fotoPico!);
      imageUrl = await ref.getDownloadURL();//pegando a url da imagem pra subir no bd
      }
 */
    // Salvando os dados no Firestore
    try {
      GeoPoint location = GeoPoint(pico.lat, pico.long);
      await _firebaseFirestore.collection('spots').add({
        'name': pico.picoName,
        'description': pico.description,
        'latitude': pico.lat,
        'longitude': pico.long,
        'imageUrl': pico.imgUrl, // subindo no bd o link da imagem
        'utilidades': pico.utilidades,
        'atributos': pico.atributos,
        'obstaculos': pico.obstaculos,
        'nota': pico.nota,
        'avaliacoes': pico.numeroAvaliacoes,
        'criador': pico.userCreator,
        'modalidade': pico.modalidade,
        'tipo': pico.tipoPico,
        'geolocation': location,
      });
    } on Exception catch (e) {
      print("Erro na exeption: $e");
    } catch (e) {
      print("Erro ao criar piquerson: $e ");
    }
  }

  @override
  Future<void> saveSpot(Pico pico, LoggedUserModel user) async {
  try {
    final snapshot = await _firebaseFirestore
        .collection('spots')
        .where("name", isEqualTo: pico.picoName)
        .limit(1)
        .get();

    if (snapshot.docs.isEmpty) {
      throw Exception("Pico não encontrado");
    }

    final spotRef = snapshot.docs.first.reference; 
    final userId = user.id;

    if (userId != null) {
      await _firebaseFirestore.collection("picosFavoritados").doc("$userId-${pico.picoName}").set({
        'idUser': userId,
        'spotRef': spotRef, 
      });
    } else {
      print("Não foi possível salvar pico: Usuário não identificado");
    }
  } catch (e) {
    throw Exception("Erro ao salvar pico: $e");
  }
}


@override
  Future<List<Pico>> showAllPico() async {
  try {
    QuerySnapshot snapshot = await _firebaseFirestore.collection('spots').get(const GetOptions(source: Source.server));
    return snapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>; // deixa o map aq quieto pq ele tem q dar baum
      return Pico(
        imgUrl: data['imageUrl'] as List<dynamic>,
        tipoPico: data['tipo'] as String,
        modalidade: data['modalidade'] as String,
        nota: (data['nota'] as num).toDouble(), // vai dar boum
        numeroAvaliacoes: data['avaliacoes'] as int,
        long: (data['longitude'] as num).toDouble(), // tem q dar boaum
        lat: (data['latitude'] as num).toDouble(), //  precisa dar buams
        description: data['description'] as String,
        atributos: data['atributos'] as Map<String, dynamic>,
        fotoPico: null, // vou inserir a imagem diretamente no código usando o image.network
        obstaculos: data['obstaculos'] as List<dynamic>,
        utilidades: data['utilidades'] as List<dynamic>,
        userCreator: data['criador'],
        urlIdPico: doc.id,
        picoName: data['name'] as String,
      );
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
  Future<List<Pico>> getSavePico(String idUser) async {
    try {
      final snapshotListPico = await _firebaseFirestore
          .collection("picosFavoritos")
          .where("idUser", isEqualTo: idUser)
          .get();

      if (snapshotListPico.docs.isNotEmpty) {
        final picos = await Future.wait(snapshotListPico.docs.map((doc) async {
          final spotRef = doc['spotRef'] as DocumentReference;
          final spotSnapshot = await spotRef.get();
          return Pico.fromJson(spotSnapshot.data() as Map<String, dynamic>);
        }));
        return picos;
      }else{
        print("Salvos não encontrados");
        return [];
      }
    } catch (e) {
      return [];
    }
  }
  
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


}