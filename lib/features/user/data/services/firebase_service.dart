import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demopico/features/user/data/models/user_model.dart';
import 'package:demopico/features/user/domain/interfaces/firebase_interface.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService implements FirebaseInterface {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseService(this.firebaseAuth, this.firebaseFirestore);

//getters
  Stream<User?> get authState => firebaseAuth.authStateChanges();
  
  Stream<User?> get userInstanceChanges => firebaseAuth.userChanges();

  User? get currentUser => firebaseAuth.currentUser;

//métodos de leitura e escrita

  //Serviço de login
  @override
  Future<UserModel> login(String email, String password) async {
    await firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return UserModel(senha: password, email: email, vulgo: null, id: null);
  }

  //Serviço de registro CREDENCIAIS
  @override
  Future<UserModel> registerByEmailAndPassword(
      String email, String password) async {
    await firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    return UserModel(senha: password, email: email, vulgo: null, id: null);
  }

  //Serviço de registro LOGIN
  @override
  Future<UserModel> registerFirestore(String email, String vulgo) async {
    await firebaseFirestore
        .collection("user_email_vulgo")
        .add({'email': email, 'vulgo': vulgo});
    return UserModel(senha: null, email: email, vulgo: vulgo, id: null);
  }

  //Serviço GET ID by USERNAME
  @override
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
  @override
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

  //Serviço de logout
  void logOut() async{
    await firebaseAuth.signOut();
  }
}
