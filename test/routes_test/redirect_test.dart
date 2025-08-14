import 'package:demopico/core/app/routes/app_routes.dart';
import 'package:demopico/core/app/routes/middleware.dart';
import 'package:demopico/features/user/presentation/controllers/user_database_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';

import '../features/mocks/mocks_profile.dart';

// Mock da classe de serviço para simular o estado de autenticação
class MockUserDatabaseProvider extends Mock implements UserDatabaseProvider {}

void main() {

  group("deve testar o redirecionamento das telas", () {
    late MockUserDatabaseProvider authService;
    late Middleware authGard;
    setUpAll(() {
      
      authService = MockUserDatabaseProvider();
       Get.testMode = true;
      Get.put<UserDatabaseProvider>(authService);
      authGard = Middleware();
     
    });
    test('redirect should return login route if user is null', () {
      // Configura o mock para retornar null no user
      when(() => authService.user).thenReturn(null);

      

      // Chama o método redirect com uma rota protegida
      final result = authGard.redirect(Paths.editProfile);

      // Verifica se o resultado é a rota de login
      expect(result?.name, Paths.login);
    });

    // Teste para o caso de usuário logado
    test('redirect should return null if user is not null', () {
      // Configura o mock para retornar um valor não nulo (usuário logado)
      when(() => authService.user).thenReturn(mockUserProfile);

      // Chama o método redirect com uma rota protegida
      final result = authGard.redirect(Paths.editProfile);

      // Verifica se o resultado é null
      expect(result, isNull);
    });
  });
}
