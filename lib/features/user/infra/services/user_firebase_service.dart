import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demopico/features/external/datasources/firestore.dart';
import 'package:demopico/features/user/domain/interfaces/i_user_database_service.dart';
import 'package:demopico/features/user/domain/models/user.dart';

class UserFirebaseService implements IUserDatabaseService {

  static UserFirebaseService? _userFirebaseService;
  static UserFirebaseService get getInstance {
    _userFirebaseService ??=
        UserFirebaseService(firebaseFirestore: Firestore().getInstance);
    return _userFirebaseService!;
  }

  final FirebaseFirestore firebaseFirestore;

  UserFirebaseService({
    required this.firebaseFirestore,
  });

  @override                     
  Future<void> addUserDetails(UserM newUser, String uid) async {
    try {
      final mappedUser = newUser.toJsonMap();
      await firebaseFirestore.collection('users').doc(uid).set(mappedUser);
    } on FirebaseException {
      Exception("Não foi possivel criar a conta devido a um erro no banco");
    } catch (e) {
      Exception("Não foi possivel criar a conta, tente novamente.");
    }
  }

  @override
  Future<UserM?> getUserDetails(String uid) async {
    try {
      DocumentSnapshot userSnapshot =
          await firebaseFirestore.collection('users').doc(uid).get();

      if (!userSnapshot.exists) {
        throw Exception("Usuario não existe");
      }
      UserM user = UserM.fromDocument(userSnapshot);
      return user;
    } on FirebaseException {
      throw Exception("Erro no banco, tente novamente mais tarde");
    } catch (e) {
      Exception("Não foi possivel pegar o email");
      return null;
    }
  }

  @override
  Future<String?> getEmailByUserID(String uid) async {
    try {
      UserM? user = await getUserDetails(uid);
      if (user == null) throw Exception("Usuario não encontrado");
      return user.email;
    } catch (e) {
      Exception("Não foi possivel pegar o email");
      return null;
    }
  }

  @override
  Future<String?> getUserIDByVulgo(String vulgo) async {
    try {
      QuerySnapshot idSnapshot = await firebaseFirestore
          .collection("users_email_vulgo")
          .where('vulgo', isEqualTo: vulgo)
          .get();
      if (!idSnapshot.docs.isNotEmpty) {
        throw Exception("Não existe nenhum usuario com um id como este");
      }
      return idSnapshot.docs.first.id;
    } on FirebaseException {
      throw Exception(
          "Falha ao tentar acessar o banco, tente novamente mais tarde");
    } catch (e) {
      Exception("Falha ao tentar buscar o usuario");
      return null;
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
}
