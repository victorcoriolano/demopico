import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demopico/features/login/data/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthDataSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;

  FirebaseAuthDataSource(this.firebaseAuth, this.firebaseFirestore);

  Future<UserModel> login(String email, String password) async {
      await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return UserModel(senha: password, email: email, vulgo: null, id: null); 
  }

  Future<UserModel> register(String email, String password) async {
    await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    return UserModel(senha: password, email: email, vulgo: null, id: null);
  }

  Future<UserModel> registerFirestore(String email, String vulgo) async{
    await firebaseFirestore.collection("user_email_vulgo").add({'email': email,'vulgo': vulgo});
    return UserModel(senha: null, email: email, vulgo: vulgo, id: null);
  }
}