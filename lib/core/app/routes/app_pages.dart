  import 'package:demopico/core/app/app.dart';
import 'package:demopico/core/app/home_page.dart';
  import 'package:demopico/core/app/routes/app_routes.dart';
  import 'package:demopico/core/app/routes/middleware.dart';
  import 'package:demopico/core/common/auth/domain/entities/user_entity.dart';
  import 'package:demopico/features/hub/presentation/pages/hub_page.dart';
  import 'package:demopico/features/mapa/presentation/pages/add_pico_pages.dart/create_spot_page.dart';
  import 'package:demopico/features/mapa/presentation/pages/favorites_page.dart';
  import 'package:demopico/features/mapa/presentation/pages/history_page.dart';
  import 'package:demopico/features/mapa/presentation/pages/map_page.dart';
  import 'package:demopico/features/mapa/presentation/pages/my_spots_page.dart';
  import 'package:demopico/features/profile/presentation/bidings/auth_biding.dart';
  import 'package:demopico/features/profile/presentation/pages/chat_room_page.dart';
  import 'package:demopico/features/profile/presentation/pages/create_post_page.dart';
  import 'package:demopico/features/profile/presentation/pages/edit_profile_page.dart';
  import 'package:demopico/features/profile/presentation/pages/my_friends_page.dart';
  import 'package:demopico/features/profile/presentation/pages/my_network_page.dart';
import 'package:demopico/features/profile/presentation/pages/notification_page.dart';
  import 'package:demopico/features/profile/presentation/pages/search_profile_page.dart';
  import 'package:demopico/features/profile/presentation/pages/screens_profile.dart';
  import 'package:demopico/features/profile/presentation/widgets/profile_data/about_page_widget.dart';
  import 'package:demopico/features/user/presentation/controllers/auth_view_model_account.dart';
  import 'package:demopico/features/user/presentation/pages/login_page.dart';
  import 'package:demopico/features/user/presentation/pages/register_page.dart';
  import 'package:get/get.dart';

  class AppPages {
    AppPages._();

   static final routes = <GetPage>[
  // MAPA
  GetPage(
    name: Paths.map,
    page: () => MapPage(),
    transition: Transition.leftToRight,
  ),
  GetPage(
    binding: AuthBinding(),
    name: Paths.mySpots,
    page: () => MySpotsPage(),
    middlewares: [Middleware(AuthViewModelAccount.instance)],
  ),
  GetPage(
    name: Paths.favoriteSpot,
    page: () => FavoriteSpotPage(),
    middlewares: [Middleware(AuthViewModelAccount.instance)],
  ),
  GetPage(
    name: Paths.createSpotPage,
    page: () => CreateSpotPage(),
    transition: Transition.circularReveal,
    middlewares: [Middleware(AuthViewModelAccount.instance)],
  ),

  // PROFILE
  GetPage(
    name: Paths.profile,
    page: () => ScreensProfile(),
    transition: Transition.rightToLeft,
    middlewares: [Middleware(AuthViewModelAccount.instance)],
  ),
  GetPage(
    name: Paths.connections,
    page: () => MyFriendsPage(),
    transition: Transition.fade,
    middlewares: [Middleware(AuthViewModelAccount.instance)],
  ),
  GetPage(
    name: Paths.searchProfile,
    page: () => SearchProfilePage(),
    transition: Transition.rightToLeft,
    middlewares: [Middleware(AuthViewModelAccount.instance)],
  ),
  GetPage(
    name: Paths.editProfile,
    page: () => EditProfilePage(),
    transition: Transition.circularReveal,
    middlewares: [Middleware(AuthViewModelAccount.instance)],
  ),
  
  GetPage(
    name: Paths.createPostPage,
    page: () => CreatePostPage(),
    transition: Transition.downToUp,
  ),
  GetPage(
    name: Paths.myNetwork,
    page: () => MyNetworkScreen(),
    transition: Transition.fadeIn,
    middlewares: [Middleware(AuthViewModelAccount.instance)],
  ),

  // CHAT
  GetPage(
    name: Paths.chat,
    page: () => ChatRoomPage(
      idCurrentUser: (AuthViewModelAccount.instance.user as UserEntity).id,
    ),
    middlewares: [Middleware(AuthViewModelAccount.instance)],
    transition: Transition.rightToLeft,
  ),

  //NOTIFICATIONS
  GetPage(
    name: Paths.notifications,
    page: () => NotificationPage(),
    middlewares: [Middleware(AuthViewModelAccount.instance)],
    transition: Transition.circularReveal,
  ),

  // OUTRAS
  GetPage(name: Paths.aboutPage, page: () => AboutPage()),
  GetPage(name: Paths.hub, page: () => HubPage()),
  GetPage(name: Paths.historySpot, page: () => HistoricoPage()),
  GetPage(name: Paths.login, page: () => LoginPage()),
  GetPage(name: Paths.signUp, page: () => RegisterPage()),
  GetPage(name: Paths.home, page: () => HomePage()),
];
}
