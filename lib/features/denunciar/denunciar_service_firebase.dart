import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demopico/features/denunciar/denuncia_model.dart';

class DenunciarServiceFirebase {
  final FirebaseFirestore _firestore;

  DenunciarServiceFirebase({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  Future<void> salvarDenuncia(DenunciaModel denuncia) async {
    try {
      await _firestore.collection('denuncias').add(denuncia.toMap());
    } catch (e) {
      rethrow; 
    }
  }
}
