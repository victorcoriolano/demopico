import 'package:demopico/core/app/routes/app_routes.dart';
import 'package:demopico/core/app/routes/middleware.dart';
import 'package:demopico/core/common/auth/domain/entities/user_entity.dart';
import 'package:demopico/features/user/domain/enums/auth_state.dart';
import 'package:demopico/features/user/presentation/controllers/auth_view_model_account.dart';
import 'package:demopico/features/user/presentation/controllers/profile_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';

import '../features/mocks/mocks_users.dart';

// Mock da classe de serviço para simular o estado de autenticação
class MockUserDatabaseProvider extends Mock implements ProfileViewModel {}

class MockAuthViewModel extends Mock implements AuthViewModelAccount {}


void main() {

  group("deve testar o redirecionamento das telas", () {
    late Middleware authGard;
    late MockAuthViewModel mockAuthViewModel;
    setUpAll(() {
      mockAuthViewModel = MockAuthViewModel();
       Get.testMode = true;
      authGard = Middleware(mockAuthViewModel);
     
    });
    test('redirect should return login route if user is null', () {
      // Configura o mock para retornar anomymous no user
      when(() => mockAuthViewModel.authState).thenReturn(AuthUnauthenticated());

      

      // Chama o método redirect com uma rota protegida
      final result = authGard.redirect(Paths.editProfile);

      // Verifica se o resultado é a rota de login
      expect(result?.name, Paths.login);
    });

    // Teste para o caso de usuário logado
    test('redirect should return null if user is not null', () {
      // Configura o mock para retornar um valor não nulo (usuário logado)
      when(() => mockAuthViewModel.authState).thenReturn(AuthAuthenticated(user: userMock1));

      // Chama o método redirect com uma rota protegida
      final result = authGard.redirect(Paths.editProfile);

      // Verifica se o resultado é null
      expect(result, isNull);
    });
  });
}
