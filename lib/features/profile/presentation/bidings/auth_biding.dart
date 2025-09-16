import 'package:demopico/features/user/presentation/controllers/profile_view_model.dart';
import 'package:get/get.dart';

class AuthBiding implements Bindings {

  @override
  void dependencies() {
    Get.put<UserDataViewModel>(UserDataViewModel.getInstance);
  }
}