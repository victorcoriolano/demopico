
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demopico/core/domain/entities/user_profile.dart';
import 'package:demopico/features/mapa/domain/entities/pico_entity.dart';
import 'package:demopico/features/mapa/domain/interfaces/spot_repository.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseServiceMap implements SpotRepository{
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  @override
  Future<void> createSpot(Pico pico) async {
    String imageUrl = '';
      // upload da imagem para o Storage
      if(pico.fotoPico != null){
      final ref = FirebaseStorage.instance
          .ref()
          .child('spots_images')
          .child('images/${pico.picoName.toString()}.jpg');
      await ref.putFile(pico.fotoPico!);
      imageUrl = await ref.getDownloadURL();//pegando a url da imagem pra subir no bd
      }

    // Salvando os dados no Firestore
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
    });
  }

  @override
  void saveSpot(Pico pico, LoggedUser user) {
    // implementar o método de salvar
  }

@override
  Future<List<Pico>> showAllPico() async {
    try {
    QuerySnapshot snapshot = await _firebaseFirestore.collection('spots').get();
    return snapshot.docs.map((doc) {
      //final data = doc.data() ;//as Map<String, dynamic>;
      return Pico(
        imgUrl: doc['imageUrl'],
        tipoPico: doc['tipo'],
        modalidade: doc['modalidade'],
        nota: doc['nota'],
        numeroAvaliacoes: doc['avaliacoes'],
        long: doc['longitude'],
        lat: doc['latitude'],
        description: doc['description'],
        atributos: doc['atributos'],
        fotoPico: null,// vou inserir a imagem diretamente no código usando o image.network
        obstaculos: doc['obstaculos'],
        utilidades: doc['utilidades'],
        userCreator: doc['criador'],
        urlIdPico: doc.id,
        picoName: doc['name'],
      );
    }).toList();
    } on Exception catch (e) {
      print(e);
      return [];
    }
  }
}