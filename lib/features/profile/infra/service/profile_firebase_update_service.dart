import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demopico/features/external/datasources/firestore.dart';
import 'package:demopico/features/profile/domain/interfaces/i_profile_database_update_service.dart';

class ProfileFirebaseUpdateService implements IProfileDatabaseUpdateService {
  static ProfileFirebaseUpdateService? _profileFirebaseUpdateService;

  static ProfileFirebaseUpdateService get getInstance {
    _profileFirebaseUpdateService ??=
        ProfileFirebaseUpdateService(firestore: Firestore().getInstance);
    return _profileFirebaseUpdateService!;
  }

  ProfileFirebaseUpdateService({required this.firestore});
  final FirebaseFirestore firestore;

  @override
  void atualizarBio(String newBio, String uid) async {
    await firestore
        .collection('users')
        .doc(uid)
        .update({'description': newBio});
  }

  @override
  void atualizarContribuicoes(String uid) async {
    await firestore.collection('users').doc(uid).update({
      'picosAdicionados': FieldValue.increment(1),
    });
  }

  @override
  void atualizarFoto(String newImg, String uid) async {
    await firestore.collection('users').doc(uid).update({'pictureUrl': newImg});
  }

  @override
  void atualizarSeguidores(String uid) async {
    await firestore
        .collection('users')
        .doc(uid)
        .update({'conexoes': FieldValue.increment(1)});
  }
}
