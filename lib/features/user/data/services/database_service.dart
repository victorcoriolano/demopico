import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demopico/features/hub/domain/entities/communique.dart';
import 'package:demopico/features/user/data/models/user.dart';
import 'package:demopico/features/user/data/services/auth_service.dart';
import 'package:flutter/foundation.dart';

class DatabaseService {
  static DatabaseService? _instance;
  static DatabaseService get instance {
    _instance ??= DatabaseService();
    return _instance!;
  }

  FirebaseFirestore? _firestore;
  FirebaseFirestore get firestore {
    _firestore ??= FirebaseFirestore.instance;
    return _firestore!;
  }

  AuthService auth = AuthService();
////////////////////////////
////////////////////////////
////////////////////////////
  Future<void> addUserDetailsToFirestore({required UserM newUser}) async {
    String uid = newUser.id!;
    print('entrou no adduser');
    final mappedUser = newUser.toJsonMap();
    await firestore
        .collection('users')
        .doc(uid)
        .set(mappedUser)
        .whenComplete(() => print('User added'));
  }

/////////////////////////////////////////////////////
/////////////////////////////////////////////////////
/////////////////////////////////////////////////////
  Future<UserM?> getUserDetailsFromFirestore(String? uid) async {
    try {
      DocumentSnapshot userSnapshot =
          await firestore.collection('users').doc(uid).get();

      if (userSnapshot.exists) {
        print(UserM.fromDocument(userSnapshot));
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

////////////////
////////////////
// Postar no hub
  Future<void> postHubCommuniqueToFirebase(String text, type) async {
    try {
      String? uid = auth.currentUser?.uid;
      String? name = auth.currentUser?.displayName;
      print('começo do posthub no databaseservice');
      print(uid);
      print(name);

      if (name == null && uid == null) {
        if (kDebugMode) {
          print('erro em pegar name e uid do auth current user');
        }
      } else {
        UserM? user = await getUserDetailsFromFirestore(uid);
        print(user.toString());

        if (user != null) {
          print('user nao e nulo');
          Communique newCommunique = Communique(
            id: Random(27345).toString(),
            uid: uid!,
            vulgo: user.name!,
            pictureUrl: user.pictureUrl ?? '',
            text: text,
            timestamp: DateTime.now().toString(),
            likeCount: 0,
            likedBy: [],
            type: type,
          );
          print(newCommunique);
          Map<String, dynamic> newPostMap = newCommunique.toJsonMap();

          await firestore.collection('communique').add(newPostMap);
        }
      }
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print(e.code);
        print(e.message);
        print(e.stackTrace);
      }
    } catch (e) {
      print("Erro não esperado: $e");
    }
  }
// Deletar do hub

// Pegar o hub
  Future<List<Communique>> getAllCommuniques() async {
    try {
      QuerySnapshot querySnapshot = await firestore
          .collection('communique')
          .orderBy('timestamp', descending: true)
          .get();
      print(
          '${querySnapshot.metadata} ${querySnapshot.docs.length} ${querySnapshot.docs.firstOrNull?.data()}');
      return querySnapshot.docs
          .map((doc) => Communique.fromDocument(doc))
          .toList();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return [];
    }
  }
}
