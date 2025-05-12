import 'package:demopico/features/profile/infra/domain/interfaces/profile_database_service.dart';

class ProfileFirebaseService implements ProfileDatabaseService {
  @override
  Future<String> atualizarBio(String newBio, String uid) {
    // TODO: implement atualizarBio
    throw UnimplementedError();
  }

  @override
  Future<String> atualizarContribuicoes(String uid) {
    // TODO: implement atualizarContribuicoes
    throw UnimplementedError();
  }

  @override
  Future<String> atualizarFoto(String newImg, String uid) {
    // TODO: implement atualizarFoto
    throw UnimplementedError();
  }

  @override
  Future<String> atualizarSeguidores(String uid) {
    // TODO: implement atualizarSeguidores
    throw UnimplementedError();
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