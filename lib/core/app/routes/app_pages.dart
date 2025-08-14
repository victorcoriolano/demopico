import 'package:demopico/core/app/home_page.dart';
import 'package:demopico/core/app/routes/app_routes.dart';
import 'package:demopico/core/app/routes/middleware.dart';
import 'package:demopico/features/mapa/presentation/pages/favorites_page.dart';
import 'package:demopico/features/mapa/presentation/pages/history_page.dart';
import 'package:demopico/features/mapa/presentation/pages/map_page.dart';
import 'package:demopico/features/profile/presentation/bidings/auth_biding.dart';
import 'package:demopico/features/profile/presentation/pages/chat_room_page.dart';
import 'package:demopico/features/profile/presentation/pages/create_post_page.dart';
import 'package:demopico/features/profile/presentation/pages/edit_profile_page.dart';
import 'package:demopico/features/profile/presentation/pages/profile_page.dart';
import 'package:demopico/features/profile/presentation/pages/search_profile_page.dart';
import 'package:demopico/features/user/presentation/pages/login_page.dart';
import 'package:get/get.dart';

class AppPages {
  AppPages._();

  static final routes = [
    GetPage(
      binding: AuthBiding(),
      name: Paths.createPostPage,
      page: () => CreatePostPage(),
    ),
    GetPage(
      binding: AuthBiding(),
      name: Paths.home,
      page: () => HomePage(),
    ),
    GetPage(
        binding: AuthBiding(),
        name: Paths.editProfile,
        page: () => EditProfilePage(),
        middlewares: [Middleware()]),
    GetPage(
      name: Paths.login,
      page: () => LoginPage(),
    ),
    GetPage(
      binding: AuthBiding(),
      name: Paths.profile,
      page: () => ProfilePage(),
      middlewares: [Middleware()],
    ),
    GetPage(
      binding: AuthBiding(),
      name: Paths.chat,
      page: () => ChatRoomPage(),
      middlewares: [Middleware()],
    ),
    GetPage(
      binding: AuthBiding(),
      name: Paths.searchProfile,
      page: () => SearchProfilePage(),
      middlewares: [Middleware()],
    ),
    GetPage(
      binding: AuthBiding(),
      name: Paths.favoriteSpot,
      page: () => FavoriteSpotPage(),
      middlewares: [Middleware()],
    ),
    GetPage(
      name: Paths.historySpot,
      page: () => HistoricoPage(),
    ),
    GetPage(
      name: Paths.map,
      page: () => MapPage(),
    ),
  ];
}
