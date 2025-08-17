// test/home_page_test.dart
import 'package:demopico/core/app/home_page.dart';
import 'package:demopico/features/home/presentation/pages/central_page.dart';
import 'package:demopico/features/home/presentation/provider/home_provider.dart';
import 'package:demopico/features/home/presentation/provider/weather_provider.dart';
import 'package:demopico/features/mapa/presentation/controllers/spots_controller.dart';
import 'package:demopico/features/mapa/presentation/pages/map_page.dart';
import 'package:demopico/features/profile/presentation/pages/profile_page.dart';
import 'package:demopico/features/user/presentation/controllers/user_database_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';

import '../features/mocks/mocks_profile.dart';

class MockOpenWeatherProvider extends Mock implements OpenWeatherProvider {}

class MockHomeProvider extends Mock implements HomeProvider {}

class MockUserDatabaseProvider extends Mock implements UserDatabaseProvider {}

class MockSpotControllerProvider extends Mock implements SpotsControllerProvider {}

// TODO: CORRIGIR ESSES TESTES
void main() {
  group('HomePage Widget Testes', () {
    late HomeProvider homeProvider;
    late UserDatabaseProvider userProvider;
    late OpenWeatherProvider openWeatherProvider;
    late SpotsControllerProvider spotControllerProvider;

    setUpAll(() {
      homeProvider = MockHomeProvider();
      userProvider = MockUserDatabaseProvider();
      openWeatherProvider = MockOpenWeatherProvider();
      spotControllerProvider = MockSpotControllerProvider();

      Get.testMode = true;
      Get.put<UserDatabaseProvider>(userProvider);
    });

    testWidgets('Deve renderizar a CentralPage na inicialização',
        (WidgetTester tester) async {
      
      await tester.pumpWidget(MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => homeProvider),
          ChangeNotifierProvider(create: (_) => openWeatherProvider),
          ChangeNotifierProvider(create: (_) => userProvider),
          ChangeNotifierProvider(create: (_) => spotControllerProvider),
        ],
        child: const GetMaterialApp(home: HomePage()),
      ));
      await tester.pumpAndSettle();
      // Verifica se a CentralPage é exibida por padrão (índice 1).
      expect(find.byType(CentralPage), findsOneWidget);
    });

    testWidgets('Deve exibir a MapPage quando deslizar pra direita ',
        (WidgetTester tester) async {
      when(() => userProvider.user).thenReturn(null);
      
      await tester.pumpWidget(const GetMaterialApp(home: HomePage()));

      // Simula a mudança de página diretamente no controlador.
      await tester.pumpAndSettle(); // Aguarda a UI reconstruir.

      // Verifica se a MapPage é exibida.
      expect(find.byType(MapPage), findsOneWidget);
    });

    testWidgets('Deve exibir a ProfilePage quando deslizar pra esquerda',
        (WidgetTester tester) async {
      when(() => userProvider.user).thenReturn(mockUserProfile);
      await tester.pumpWidget(const GetMaterialApp(home: HomePage()));

      // Simula a mudança de página para o índice 2.
      await tester.pumpAndSettle();

      // Verifica se a ProfilePage é exibida.
      expect(find.byType(ProfilePage), findsOneWidget);
    });

  });
}
