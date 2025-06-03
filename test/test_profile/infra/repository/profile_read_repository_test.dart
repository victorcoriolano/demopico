import 'package:demopico/features/profile/infra/repository/profile_read_repository.dart';
import 'package:demopico/features/user/domain/interfaces/i_user_database_repository.dart';
import 'package:demopico/features/user/domain/models/user.dart';
import 'package:demopico/features/user/infra/repositories/user_firebase_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks/mocks_profile.dart';

class MockRepository extends Mock
    implements UserFirebaseRepository {}
void main() {
  group("Este group possui todas as operações de read do Profile", () {
    late UserFirebaseRepository fakeUserRepository;
    late ProfileReadRepository fakeProfileReadRepository;
    
    setUp(() async {
      fakeUserRepository = MockRepository();
      fakeProfileReadRepository = ProfileReadRepository(userRepositoryIMP: MockRepository());
    });

    test("Este teste deve retornar uma string de nova foto ", () async {
      final repositoryRead = fakeProfileReadRepository;
      final repositoryUser = fakeUserRepository;

 // Mockando o retorno do getUserDetails
       when(() => repositoryUser.getUserDetails(any()))
          .thenAnswer((_) async => testeProfileCerto);

      await repositoryRead.getPhoto(testeProfileCerto);
      verify(() => repositoryUser.getUserDetails(testeProfileCerto.id!)).called(1);

      
    });

    test("Este teste deve retornar uma string de uma nova bio", () async {
      final repositoryRead = fakeProfileReadRepository;
      final repositoryUser = fakeUserRepository;

      await repositoryRead.getBio(testeProfileCerto);
      
    });

    test("Este teste deve retornar um novo int de seguidor", () async {
      final repositoryRead = fakeProfileReadRepository;
      final repositoryUser = fakeUserRepository;

       await repositoryRead.getFollowers(testeProfileCerto);
      
    });

    test("Este teste deve retornar um novo int de contribuições", () async {
      final repositoryRead = fakeProfileReadRepository;
      final repositoryUser = fakeUserRepository;

      await repositoryRead.getContributions(testeProfileCerto);
      
    });
  });
}
