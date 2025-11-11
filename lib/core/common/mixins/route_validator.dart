import 'package:demopico/core/app/routes/app_routes.dart';
import 'package:demopico/features/profile/presentation/pages/profile_page_user.dart';
import 'package:demopico/features/user/domain/enums/auth_state.dart';
import 'package:get/get.dart';

mixin RouteValidator {
  void validateRoute(AuthState auth, String idCreator) {
    switch (auth) {
      case AuthAuthenticated _:
        auth.user.id == idCreator
            ? Get.toNamed(Paths.profile)
            : Get.to(() => ProfilePageUser(), arguments: idCreator);
        break;
      case AuthUnauthenticated _:
        Get.to(() => ProfilePageUser(), arguments: idCreator);
        break;
    }
  }
}
