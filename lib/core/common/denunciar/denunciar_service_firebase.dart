import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demopico/core/common/denunciar/denuncia_model.dart';

class DenunciarServiceFirebase {
  final FirebaseFirestore _firestore;

  DenunciarServiceFirebase({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  /// Salva uma denúncia no Firestore
  Future<void> salvarDenuncia(DenunciaModel denuncia) async {
    try {
      await _firestore.collection('denuncias').add(denuncia.toMap());
      print('Denúncia salva com sucesso!');
    } catch (e) {
      print('Erro ao salvar denúncia: $e');
      rethrow; // Repassa o erro para quem chamou, caso queira tratar
    }
  }
}
