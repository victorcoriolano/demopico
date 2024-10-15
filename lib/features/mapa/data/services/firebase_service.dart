
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
      final data = doc.data() as Map<String, dynamic>; // deixa o map aq quieto pq ele tem q dar baum
      return Pico(
        imgUrl: data['imageUrl'] as List<String>,
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
}