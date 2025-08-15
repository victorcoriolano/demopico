/* // test/home_page_test.dart
import 'dart:ffi';

import 'package:demopico/core/app/home_page.dart';
import 'package:demopico/core/app/routes/app_pages.dart';
import 'package:demopico/core/app/routes/app_routes.dart';
import 'package:demopico/features/home/presentation/pages/central_page.dart';
import 'package:demopico/features/home/presentation/provider/home_controller.dart';
import 'package:demopico/features/home/presentation/provider/weather_provider.dart';
import 'package:demopico/features/mapa/presentation/controllers/spots_controller.dart';
import 'package:demopico/features/mapa/presentation/pages/map_page.dart';
import 'package:demopico/features/profile/presentation/pages/profile_page.dart';
import 'package:demopico/features/user/presentation/controllers/auth_user_provider.dart';
import 'package:demopico/features/user/presentation/controllers/user_database_provider.dart';
import 'package:demopico/features/user/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';
import '../features/mocks/mocks_profile.dart';

// Mocks
class MockOpenWeatherProvider extends Mock implements OpenWeatherProvider {}

class MockHomeProvider extends Mock implements HomeController {}

class MockUserDatabaseProvider extends Mock implements UserDatabaseProvider {}

class MockSpotControllerProvider extends Mock
    implements SpotControllerProvider {}

class MockAuthUserProvider extends Mock implements AuthUserProvider {}


void main() {
  group('HomePage Widget Testes', () {
    late MockHomeProvider homeProvider;
    late MockUserDatabaseProvider userProvider;
    late MockOpenWeatherProvider openWeatherProvider;
    late MockSpotControllerProvider spotControllerProvider;
    late MockAuthUserProvider authUserProvider;

    Widget createTestWidget({
      required Widget child,
    }) {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider<HomeController>(create: (_) => homeProvider),
          ChangeNotifierProvider<OpenWeatherProvider>(
              create: (_) => openWeatherProvider),
          ChangeNotifierProvider<UserDatabaseProvider>(
              create: (_) => userProvider),
          ChangeNotifierProvider<SpotControllerProvider>(
              create: (_) => spotControllerProvider),
          ChangeNotifierProvider<AuthUserProvider>(
              create: (_) => authUserProvider),
        ],
        child: GetMaterialApp(
          getPages: AppPages.routes,
          home: child,
        ),
      );
    }

    setUp(() {
      // Cria uma nova instância de mocks para CADA teste, garantindo isolamento.
      homeProvider = MockHomeProvider();
      userProvider = MockUserDatabaseProvider();
      openWeatherProvider = MockOpenWeatherProvider();
      spotControllerProvider = MockSpotControllerProvider();
      authUserProvider = MockAuthUserProvider();

      // Mocks mínimos necessários para que a HomePage e CentralPage inicializem sem travar.
      // 1. Simula o usuário logado (necessário para a CentralPage).
      when(() => userProvider.user).thenReturn(mockUserProfile);

      // 2. Mocka os métodos assíncronos que rodam na inicialização da CentralPage
      //    Eles devem retornar um Future<void> que completa.
      when(() => openWeatherProvider.init()).thenAnswer((_) async {});
      when(() => openWeatherProvider.fetchWeatherData())
          .thenAnswer((_) async {});
      when(() => homeProvider.getAllCommuniques()).thenAnswer((_) async {});
      when(() => homeProvider.swipeLeft()).thenAnswer((invocation) => {},);
      when(() => homeProvider.swipeRight()).thenAnswer((invocation) => {},);

      // 3. Mocka os getters para evitar erros de NullPointerException
      when(() => openWeatherProvider.isUpdated()).thenReturn(false);
      when(() => openWeatherProvider.isLoading).thenReturn(false);
      when(() => homeProvider.allCommuniques).thenReturn([]);
      when(() => spotControllerProvider.spots).thenReturn([]);

      // 4. Configuração do GetX
      Get.reset();
      Get.testMode = true;
      Get.put<UserDatabaseProvider>(userProvider);
    });

    testWidgets('Deve renderizar a CentralPage na inicialização',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(
        child: const HomePage(),
      )); 
      await tester.pumpAndSettle();

      expect(find.byType(CentralPage), findsOneWidget);
    });

    testWidgets('Deve navegar para MapPage ao arrastar para a direita',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(
        child: const HomePage(),
      ));
      await tester.pumpAndSettle();

      // Simula o gesto de arrastar para a direita
      await tester.drag(find.byKey(Key("GestureCrossNavigation")), const Offset(400, 0));
      verify(() => homeProvider.swipeRight()).called(1);
    });
  });
}

    /* testWidgets('Deve exibir a MapPage quando arrastar para a direita',
      (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(
        homeProvider: homeProvider,
        userProvider: userProvider,
        openWeatherProvider: openWeatherProvider,
        spotControllerProvider: spotControllerProvider,
        child: const HomePage(),
      ));
      await tester.pumpAndSettle();

      await tester.drag(find.byType(CentralPage), const Offset(400, 0));
      await tester.pumpAndSettle();

      expect(find.byType(MapPage), findsOneWidget);
    });

    testWidgets('Deve exibir a ProfilePage quando arrastar para a esquerda',
      (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(
        homeProvider: homeProvider,
        userProvider: userProvider,
        openWeatherProvider: openWeatherProvider,
        spotControllerProvider: spotControllerProvider,
        child: const HomePage(),
      ));
      await tester.pumpAndSettle();

      await tester.drag(find.byType(CentralPage), const Offset(-400, 0));
      await tester.pumpAndSettle();

      expect(find.byType(ProfilePage), findsOneWidget);
    });

    testWidgets('Deve ir para a LoginPage se o usuário não estiver logado',
      (WidgetTester tester) async {
      when(() => userProvider.user).thenReturn(null);

      await tester.pumpWidget(createTestWidget(
        homeProvider: homeProvider,
        userProvider: userProvider,
        openWeatherProvider: openWeatherProvider,
        spotControllerProvider: spotControllerProvider,
        child: const HomePage(),
      ));
      await tester.pumpAndSettle();
      
      await tester.drag(find.byType(CentralPage), const Offset(-400, 0));
      await tester.pumpAndSettle();

      expect(find.byType(LoginPage), findsOneWidget);
    }); */
 */