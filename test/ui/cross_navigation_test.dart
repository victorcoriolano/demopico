// test/home_page_test.dart
import 'package:demopico/core/app/controller/controller_home_page.dart';
import 'package:demopico/core/app/home_page.dart';
import 'package:demopico/core/app/providers/providers.dart';
import 'package:demopico/features/home/infra/http_climate_service.dart';
import 'package:demopico/features/home/presentation/pages/central_page.dart';
import 'package:demopico/features/home/provider/home_provider.dart';
import 'package:demopico/features/home/provider/weather_provider.dart';
import 'package:demopico/features/hub/domain/interfaces/i_hub_repository.dart';
import 'package:demopico/features/hub/domain/usecases/listar_comunicados_uc.dart';
import 'package:demopico/features/mapa/presentation/pages/map_page.dart';
import 'package:demopico/features/profile/presentation/pages/profile_page.dart';
import 'package:demopico/features/user/domain/interfaces/i_user_database_repository.dart';
import 'package:demopico/features/user/domain/usecases/pegar_dados_user_uc.dart';
import 'package:demopico/features/user/infra/repositories/user_data_repository_impl.dart';
import 'package:demopico/features/user/presentation/controllers/user_database_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';

import '../features/mocks/mocks_profile.dart';

class MockControllerHomePage extends Mock implements ControllerHomePage {}

class MockOpenWeatherProvider extends Mock implements OpenWeatherProvider {}

class MockHomeProvider extends Mock implements HomeProvider {}

class MockUserDatabaseProvider extends Mock implements UserDatabaseProvider {}

void main() {
  group('HomePage Widget Testes', () {
    late HomeProvider homeProvider;
    late UserDatabaseProvider userProvider;
    late OpenWeatherProvider openWeatherProvider;
    late ControllerHomePage controller;
    
    setUpAll(() {
      controller = MockControllerHomePage();
      homeProvider = MockHomeProvider();
      userProvider = MockUserDatabaseProvider();
      openWeatherProvider = MockOpenWeatherProvider();
    });

    testWidgets('Deve renderizar a CentralPage na inicialização',
        (WidgetTester tester) async {
      when(() => userProvider.user).thenReturn(null);
      when(() => controller.currentPage,).thenReturn(1);
      when(() => controller.pageController,).thenReturn(PageController());
      // Injeta o controlador antes de renderizar o widget.
      await tester.pumpWidget(MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => controller),
          ChangeNotifierProvider(create: (_) => homeProvider),
          ChangeNotifierProvider(create: (_) => openWeatherProvider),
          ChangeNotifierProvider(create: (_) => userProvider),
        ],
        child: const GetMaterialApp(home: HomePage()),
      ));
      await tester.pumpAndSettle();
      // Verifica se a CentralPage é exibida por padrão (índice 1).
      expect(find.byType(CentralPage), findsOneWidget);
    });

    testWidgets('Deve exibir a MapPage quando a página muda para 0',
        (WidgetTester tester) async {
      when(() => userProvider.user).thenReturn(null);
      
      await tester.pumpWidget(const GetMaterialApp(home: HomePage()));

      // Simula a mudança de página diretamente no controlador.
      controller.onPageChanged(0);
      await tester.pumpAndSettle(); // Aguarda a UI reconstruir.

      // Verifica se a MapPage é exibida.
      expect(find.byType(MapPage), findsOneWidget);
    });

    testWidgets('Deve exibir a ProfilePage quando a página muda para 2',
        (WidgetTester tester) async {
      when(() => userProvider.user).thenReturn(mockUserProfile);
      await tester.pumpWidget(const GetMaterialApp(home: HomePage()));

      // Simula a mudança de página para o índice 2.
      controller.onPageChanged(2);
      await tester.pumpAndSettle();

      // Verifica se a ProfilePage é exibida.
      expect(find.byType(ProfilePage), findsOneWidget);
    });

    testWidgets('Deve permitir o pop na página central',
        (WidgetTester tester) async {
      when(() => userProvider.user).thenReturn(null);
      await tester.pumpWidget(const GetMaterialApp(home: HomePage()));

      // A página inicial é a central, então canPop deve ser true.
      expect(controller.currentPage, 1);
      final didPop = await controller.handlePop();

      // Verifica se o método de pop do controlador retorna true.
      expect(didPop, true);
    });

    testWidgets('Não deve permitir o pop fora da página central',
        (WidgetTester tester) async {
      when(() => userProvider.user).thenReturn(null);
      await tester.pumpWidget(const GetMaterialApp(home: HomePage()));

      // Simula a mudança de página para o índice 0.
      controller.onPageChanged(0);
      await tester.pumpAndSettle();

      // canPop deve ser falso agora.
      expect(controller.currentPage, 0);
      final didPop = await controller.handlePop();

      // Verifica se o método de pop do controlador retorna false.
      expect(didPop, false);

      // O controlador deve ter retornado para a página 1 (central).
      expect(controller.currentPage, 1);
    });
  });
}
