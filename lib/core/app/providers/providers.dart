import 'package:demopico/core/common/util/file_manager/pick_files_uc.dart';
import 'package:demopico/core/common/util/file_manager/pick_video_uc.dart';
import 'package:demopico/features/home/provider/forecast_provider.dart';
import 'package:demopico/features/home/provider/home_provider.dart';
import 'package:demopico/features/home/provider/weather_provider.dart';
import 'package:demopico/features/hub/domain/usecases/listar_comunicados_uc.dart';
import 'package:demopico/features/hub/domain/usecases/postar_comunicado_uc.dart';
import 'package:demopico/features/hub/presentation/providers/hub_provider.dart';
import 'package:demopico/features/mapa/presentation/controllers/add_pico_controller.dart';
import 'package:demopico/features/mapa/presentation/controllers/comment_controller.dart';
import 'package:demopico/features/mapa/presentation/controllers/favorite_spot_controller.dart';
import 'package:demopico/features/mapa/presentation/controllers/historico_controller.dart';
import 'package:demopico/features/mapa/presentation/controllers/map_controller.dart';
import 'package:demopico/features/mapa/presentation/controllers/spot_controller.dart';
import 'package:demopico/features/profile/domain/usecases/create_post_uc.dart';
import 'package:demopico/features/profile/domain/usecases/delete_post_uc.dart';
import 'package:demopico/features/profile/domain/usecases/get_post_uc.dart';
import 'package:demopico/features/profile/domain/usecases/update_post_uc.dart';
import 'package:demopico/features/profile/presentation/provider/post_provider.dart';
import 'package:demopico/features/profile/presentation/provider/screen_provider.dart';
import 'package:demopico/features/user/infra/datasource/remote/user_auth_firebase_service.dart';
import 'package:demopico/features/user/presentation/controllers/auth_user_provider.dart';
import 'package:demopico/features/user/presentation/controllers/user_database_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

final myProviders = [
  ChangeNotifierProvider(create: (_) => OpenWeatherProvider()),
        ChangeNotifierProvider(create: (_) => ForecastProvider(null)),
        ChangeNotifierProvider(create: (_) => AuthUserProvider.getInstance),
        ChangeNotifierProvider(create: (_) => ScreenProvider()),
        StreamProvider<User?>(
          create: (_) =>
              UserAuthFirebaseService.getInstance.getAuthStateChanges(),
          initialData: null,
        ),
        ChangeNotifierProvider(create: (_) => AddPicoProvider.getInstance),
        ChangeNotifierProvider(create: (_) => MapControllerProvider()),
        ChangeNotifierProvider(
            create: (_) => FavoriteSpotController.getInstance),
        ChangeNotifierProvider(
            create: (_) => SpotControllerProvider.getInstance),
        ChangeNotifierProvider(create: (_) => UserDatabaseProvider.getInstance),
        ChangeNotifierProvider(create: (_) => HistoricoController.getInstance),
        ChangeNotifierProvider(
          create: (_) => HubProvider(
            postarComunicado: PostarComunicado.getInstance,
            listarComunicado: ListarComunicado.getInstance,
          ),
        ),
        ChangeNotifierProvider(create: (_) => HomeProvider.getInstance),
        ChangeNotifierProvider(create: (_) => CommentController.getInstance),
        ChangeNotifierProvider(create: (_) => PostProvider(
          createPostUc: CreatePostUc.instace,
          pickFileUC: PickFileUC.getInstance(),
          getPosts: GetPostUc.instance,
          deleteUc: DeletePostUc.instance,
          updateUc: UpdatePostUc.instance,
          pickVideo: PickVideoUC.getInstance,
        )),
];