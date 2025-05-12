import 'package:demopico/features/external/datasources/firestore.dart';
import 'package:demopico/features/profile/infra/domain/interfaces/profile_database_update_service.dart';

class ProfileFirebaseUpdateService implements ProfileDatabaseUpdateService {
  static ProfileFirebaseUpdateService? _profileFirebaseUpdateService;

  static ProfileFirebaseUpdateService get getInstance {
    _profileFirebaseUpdateService ??= ProfileFirebaseUpdateService();
    return _profileFirebaseUpdateService!;
  }

  ProfileFirebaseUpdateService();

  final Firestore firestore = Firestore();

  @override
  void atualizarBio(String newBio, String uid) async {
    
    await firestore.getInstance
        .collection('users')
        .doc(uid)
        .update({'description': newBio});
    
  
  }

  @override
  void atualizarContribuicoes(String uid) async {
    // TODO: implement atualizarContribuicoes
  }

  @override
  void atualizarFoto(String newImg, String uid) async {
    // TODO: implement atualizarFoto
  }

  @override
  void atualizarSeguidores(String uid) async {
    // TODO: implement atualizarSeguidores
  }
}

/*
  Future<void> atualizarContribuicoes() async {
    final id = auth.currentUser?.uid ?? 'User not found';
    final reference = firestore.collection("users");

    if (id != 'User not found') { 
      try {
        await reference.doc(id).update({
          'picosAdicionados': FieldValue.increment(1),
        });
        print('Contribuição atualizada com sucesso!');
      } catch (e) {
        print('Erro ao atualizar contribuições: $e');
      }
    } else {
      print('Usuário não encontrado.');
    }
  }

//////////////////////////
///////////////////////////
/////////////////////////////
  Future<void> updateUserBioInFirebase(String newBio) async {
    String uid = auth.currentUser!.uid;
    try {
      await firestore
          .collection('users')
          .doc(uid)
          .update({'description': newBio});
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> updateUserImgInFirebase(String newImg) async {
    print("OIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII ${newImg}");
    String uid = auth.currentUser!.uid;
    try {
      await firestore
          .collection('users')
          .doc(uid)
          .update({'pictureUrl': newImg});
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
  */