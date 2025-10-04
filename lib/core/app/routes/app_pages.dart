import 'package:demopico/core/app/home_page.dart';
import 'package:demopico/core/app/routes/app_routes.dart';
import 'package:demopico/core/app/routes/middleware.dart';
import 'package:demopico/core/common/auth/infra/repositories/firebase_auth_repository.dart';
import 'package:demopico/features/hub/presentation/pages/hub_page.dart';
import 'package:demopico/features/mapa/presentation/pages/add_pico_pages.dart/create_spot_page.dart';
import 'package:demopico/features/mapa/presentation/pages/favorites_page.dart';
import 'package:demopico/features/mapa/presentation/pages/history_page.dart';
import 'package:demopico/features/mapa/presentation/pages/map_page.dart';
import 'package:demopico/features/profile/presentation/bidings/auth_biding.dart';
import 'package:demopico/features/profile/presentation/pages/chat_room_page.dart';
import 'package:demopico/features/profile/presentation/pages/create_post_page.dart';
import 'package:demopico/features/profile/presentation/pages/edit_profile_page.dart';
import 'package:demopico/features/profile/presentation/pages/my_network_page.dart';
import 'package:demopico/features/profile/presentation/pages/search_profile_page.dart';
import 'package:demopico/features/profile/presentation/pages/screens_profile.dart';
import 'package:demopico/features/user/presentation/controllers/auth_view_model_account.dart';
import 'package:demopico/features/user/presentation/pages/login_page.dart';
import 'package:demopico/features/user/presentation/pages/register_page.dart';
import 'package:get/get.dart';

class AppPages {
  AppPages._();

  static final routes = <GetPage>[
    //mapa
    GetPage(
      binding: AuthBinding(),
      name: Paths.favoriteSpot,
      page: () => FavoriteSpotPage(),
      middlewares: [Middleware(AuthViewModelAccount.instance)],
    ),
    GetPage(
      name: Paths.historySpot,
      page: () => HistoricoPage(),
    ),
    GetPage(
      name: Paths.map,
      page: () => MapPage(),
    ),
    
    //profile
    GetPage(
      binding: AuthBinding(),
      name: Paths.searchProfile,
      page: () => SearchProfilePage(),
      middlewares: [Middleware(AuthViewModelAccount.instance)],
    ),
    GetPage(
        binding: AuthBinding(),
        name: Paths.profile,
        page: () => ScreensProfile(),
        middlewares: [Middleware(AuthViewModelAccount.instance)],
        transition: Transition.rightToLeft),
    GetPage(
        binding: AuthBinding(),
        name: Paths.chat,
        page: () => ChatRoomPage(),
        middlewares: [Middleware(AuthViewModelAccount.instance)],
        transition: Transition.rightToLeft),
    GetPage(
        binding: AuthBinding(),
        name: Paths.createPostPage,
        page: () => CreatePostPage(),
        transition: Transition.downToUp),
    GetPage(
        binding: AuthBinding(),
        name: Paths.editProfile,
        page: () => EditProfilePage(),
        transition: Transition.circularReveal,
        middlewares: [Middleware(AuthViewModelAccount.instance)]),
    
    //hub
    GetPage(
      name: Paths.hub,
      page: () => HubPage(),
      transition: Transition.upToDown,
    ),

    //auth
    GetPage(
      name: Paths.login,
      page: () => LoginPage(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      page: () => RegisterPage(),
      name: Paths.signUp,
      transition: Transition.circularReveal,
    ),

    //home
    GetPage(
      binding: AuthBinding(),
      name: Paths.home,
      page: () => HomePage(),
      transition: Transition.native,
    ),

    GetPage(
      binding: AuthBinding(),
      name: Paths.myNetwork,
      page: () => MyNetworkScreen(),
      transition: Transition.fadeIn,
    ),

    GetPage(
      name: Paths.createSpotPage, 
      page: () => CreateSpotPage(),
      transition: Transition.circularReveal,
    ),
  ];
}
