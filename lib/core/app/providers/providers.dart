import 'package:demopico/core/common/auth/infra/repositories/firebase_auth_repository.dart';
import 'package:demopico/core/common/media_management/usecases/pick_files_uc.dart';
import 'package:demopico/core/common/media_management/usecases/pick_video_uc.dart';
import 'package:demopico/features/home/infra/http_climate_service.dart';
import 'package:demopico/features/home/presentation/provider/forecast_provider.dart';
import 'package:demopico/features/home/presentation/provider/home_provider.dart';
import 'package:demopico/features/home/presentation/provider/weather_provider.dart';
import 'package:demopico/features/hub/domain/usecases/listar_comunicados_uc.dart';
import 'package:demopico/features/hub/domain/usecases/postar_comunicado_uc.dart';
import 'package:demopico/features/hub/presentation/providers/hub_provider.dart';
import 'package:demopico/features/mapa/presentation/controllers/add_pico_view_model.dart';
import 'package:demopico/features/mapa/presentation/controllers/comment_controller.dart';
import 'package:demopico/features/mapa/presentation/controllers/favorite_spot_controller.dart';
import 'package:demopico/features/mapa/presentation/controllers/historico_controller.dart';
import 'package:demopico/features/mapa/presentation/controllers/map_controller.dart';
import 'package:demopico/features/mapa/presentation/controllers/spot_provider.dart';
import 'package:demopico/features/mapa/presentation/controllers/spots_controller.dart';
import 'package:demopico/features/profile/domain/usecases/create_post_uc.dart';
import 'package:demopico/features/profile/domain/usecases/delete_post_uc.dart';
import 'package:demopico/features/profile/domain/usecases/get_post_uc.dart';
import 'package:demopico/features/profile/domain/usecases/update_post_uc.dart';
import 'package:demopico/features/profile/presentation/view_model/network_view_model.dart';
import 'package:demopico/features/profile/presentation/view_model/post_provider.dart';
import 'package:demopico/features/profile/presentation/view_model/screen_provider.dart';
import 'package:demopico/features/user/domain/enums/auth_state.dart';
import 'package:demopico/features/user/presentation/controllers/auth_view_model_sign_in.dart';
import 'package:demopico/features/user/presentation/controllers/auth_view_model_sign_up.dart';
import 'package:demopico/features/user/presentation/controllers/profile_view_model.dart';
import 'package:provider/provider.dart';

final myProviders = [
  ChangeNotifierProvider(create: (_) => NetworkViewModel.instance),
  ChangeNotifierProvider(create: (_) => OpenWeatherProvider()),
  ChangeNotifierProvider(
      create: (_) =>
          ForecastProvider(null, climaService: HttpClimateService())),
  ChangeNotifierProvider(create: (_) => AuthViewModelSignIn.getInstance),
  ChangeNotifierProvider(create: (_) => AuthViewModelSignUp.getInstance),
  ChangeNotifierProvider(create: (_) => ScreenProvider()),
  StreamProvider<AuthState>(
    create: (_) => FirebaseAuthRepository.instance.authState,
    initialData: AuthUnauthenticated(),
  ),
  ChangeNotifierProvider(create: (_) => AddPicoViewModel.getInstance),
  ChangeNotifierProvider(create: (_) => MapControllerProvider()),
  ChangeNotifierProvider(create: (_) => FavoriteSpotController.getInstance),
  ChangeNotifierProvider(create: (_) => SpotsControllerProvider.getInstance),
  ChangeNotifierProvider(create: (_) => ProfileViewModel.getInstance),
  ChangeNotifierProvider(create: (_) => HistoricoController.getInstance),
  ChangeNotifierProvider(
    create: (_) => HubProvider(
      postarComunicado: PostarComunicado.getInstance,
      listarComunicado: ListarComunicado.getInstance,
    ),
  ),
  ChangeNotifierProvider(create: (_) => HomeProvider.getInstance),
  ChangeNotifierProvider(create: (_) => CommentController.getInstance),
  ChangeNotifierProvider(
      create: (_) => PostProvider(
            createPostUc: CreatePostUc.instace,
            pickFileUC: PickFileUC.getInstance(),
            getPosts: GetPostUc.instance,
            deleteUc: DeletePostUc.instance,
            updateUc: UpdatePostUc.instance,
            pickVideo: PickVideoUC.getInstance,
          )),
  ChangeNotifierProvider(create: (_) => SpotProvider.instance)
];
