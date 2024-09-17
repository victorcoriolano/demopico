import 'package:demopico/features/user/data/models/user_model.dart';

abstract class FirebaseInterface {
  Future<UserModel> login(String email, String password);
  Future<UserModel> registerByEmailAndPassword(String email, String password);
  Future<UserModel> registerFirestore(String email, String vulgo);
  Future<String?> getEmailByID(String id);
  Future<String?> getIDByVulgo(String vulgo);
}