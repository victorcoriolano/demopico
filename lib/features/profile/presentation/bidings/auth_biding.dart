import 'package:demopico/features/user/presentation/controllers/user_database_provider.dart';
import 'package:get/get.dart';

class AuthBiding implements Bindings {

  @override
  void dependencies() {
    Get.put<UserDatabaseProvider>(UserDatabaseProvider.getInstance);
  }
}