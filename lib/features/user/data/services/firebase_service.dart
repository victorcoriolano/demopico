import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demopico/features/user/data/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;

  FirebaseService(this.firebaseAuth, this.firebaseFirestore);

  //Serviço de login
  Future<UserModel> login(String email, String password) async {
    await firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return UserModel(senha: password, email: email, vulgo: null, id: null);
  }

  //Serviço de registro CREDENCIAIS
  Future<UserModel> registerByEmailAndPassword(
      String email, String password) async {
    await firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    return UserModel(senha: password, email: email, vulgo: null, id: null);
  }

  //Serviço de registro LOGIN
  Future<UserModel> registerFirestore(String email, String vulgo) async {
    await firebaseFirestore
        .collection("user_email_vulgo")
        .add({'email': email, 'vulgo': vulgo});
    return UserModel(senha: null, email: email, vulgo: vulgo, id: null);
  }

  //Serviço GET ID by USERNAME
  Future<String?> getIDByVulgo(
    String vulgo,
  ) async {
    QuerySnapshot idSnapshot = await firebaseFirestore
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
        await firebaseFirestore.collection("user_email_vulgo").doc(id).get();
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
}
