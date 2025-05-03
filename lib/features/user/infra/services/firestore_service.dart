import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demopico/features/user/domain/models/user.dart';
import 'package:demopico/features/user/infra/services/auth_service.dart';
import 'package:flutter/foundation.dart';

class FirestoreService {

  static FirestoreService? _firestoreService;
  static FirestoreService get instance {
  _firestoreService ??= FirestoreService();
    return _firestoreService!;
  }

  FirebaseFirestore? _firestore;
  FirebaseFirestore get firestore {
    _firestore ??= FirebaseFirestore.instance;
    return _firestore!;
  }

  AuthService auth = AuthService();

  Future<void> addUserDetailsToFirestore(UserM newUser) async {
    String uid = newUser.id!;
    final mappedUser = newUser.toJsonMap();
    await firestore
        .collection('users')
        .doc(uid)
        .set(mappedUser);
  }


  Future<UserM?> getUserDetailsFromFirestore(String? uid) async {
    try {
      DocumentSnapshot userSnapshot =
          await firestore.collection('users').doc(uid).get();

      if (userSnapshot.exists) {
        return UserM.fromDocument(userSnapshot);
      } else {
        return null;
      }
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print(e.code);
        print(e.message);
        print(e.stackTrace);
      }
    }
    return null;
  }

//Serviço GET ID by USERNAME
  Future<String?> getIDByVulgo(
    String vulgo,
  ) async {
    QuerySnapshot idSnapshot = await firestore
        .collection("users_email_vulgo")
        .where('vulgo', isEqualTo: vulgo)
        .get();
    if (idSnapshot.docs.isNotEmpty) {
      return idSnapshot.docs.first.id;
    } else {
      return null;
    }
  }

  //Serviço GET EMAIL by ID
  Future<String?> getEmailByID(String id) async {
    DocumentSnapshot emailSnapshot =
        await firestore.collection("user_email_vulgo").doc(id).get();
    if (emailSnapshot.exists) {
      Map<String, dynamic>? data =
          emailSnapshot.data() as Map<String, dynamic>?;
      if (data != null && data.containsKey('email')) {
        return data['email'] as String;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

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

}
