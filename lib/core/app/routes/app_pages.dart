import 'package:demopico/core/app/home_page.dart';
import 'package:demopico/core/app/routes/app_routes.dart';
import 'package:demopico/core/app/routes/middleware.dart';
import 'package:demopico/features/mapa/presentation/pages/favorites_page.dart';
import 'package:demopico/features/mapa/presentation/pages/history_page.dart';
import 'package:demopico/features/mapa/presentation/pages/map_page.dart';
import 'package:demopico/features/profile/presentation/pages/chat_room_page.dart';
import 'package:demopico/features/profile/presentation/pages/edit_profile_page.dart';
import 'package:demopico/features/profile/presentation/pages/profile_page.dart';
import 'package:demopico/features/profile/presentation/pages/search_profile_page.dart';
import 'package:demopico/features/user/presentation/pages/login_page.dart';
import 'package:get/get.dart';

class AppPages {
  AppPages._();

  static final routes = [
    GetPage(
      name: Paths.home,
      page: () => HomePage(),
    ),
    GetPage(
      name: Paths.editProfile,
      page: () => EditProfilePage(),
      middlewares: [AuthGard()]
    ),
    GetPage(
      name: Paths.login,
      page: () => LoginPage(),
    ),
    GetPage(
      name: Paths.profile,
      page: () => ProfilePage(),
      middlewares: [AuthGard()],
    ),
    GetPage(
      name: Paths.chat,
      page: () => ChatRoomPage(),
      middlewares: [AuthGard()],
    ),
    GetPage(
      name: Paths.searchProfile,
      page: () => SearchProfilePage(),
      middlewares: [AuthGard()],
    ),
    GetPage(
      name: Paths.favoriteSpot,
      page: () => FavoriteSpotPage(),
      middlewares: [AuthGard()],
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