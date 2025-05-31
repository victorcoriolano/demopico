import 'package:demopico/features/profile/domain/interfaces/i_profile_read_repository.dart';
import 'package:demopico/features/profile/domain/interfaces/i_profile_update_datasource.dart';
import 'package:demopico/features/profile/infra/repository/profile_read_repository.dart';
import 'package:demopico/features/user/domain/interfaces/i_user_auth_service.dart';
import 'package:demopico/features/user/domain/interfaces/i_user_database_repository.dart';
import 'package:demopico/features/user/domain/interfaces/i_user_database_service.dart';
import 'package:demopico/features/user/infra/repositories/user_firebase_repository.dart';
import 'package:demopico/features/user/infra/services/user_firebase_service.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks/mocks_profile.dart';

class MockRepository extends Mock
    implements IUserDatabaseRepository {}
void main() {
  group("Este group possui todas as operações de read do Profile", () {
    late MockRepository fakeUserRepository;
    late ProfileReadRepository fakeProfileReadRepository;
    
    setUp(() async {
      fakeUserRepository = MockRepository();
      fakeProfileReadRepository = ProfileReadRepository(userRepositoryIMP: MockRepository());
    });

    test("Este teste deve retornar uma string de nova foto ", () async {
      final repositoryRead = fakeProfileReadRepository;
      String text = await repositoryRead.getPhoto(testeProfileCerto);
      
      
    });

    test("Este teste deve retornar uma string de uma nova bio", () async {
      final repositoryRead = fakeProfileReadRepository;

      String text = await repositoryRead.getBio(testeProfileCerto);
      
    });

    test("Este teste deve retornar um novo int de seguidor", () async {
      final repositoryRead = fakeProfileReadRepository;

       await repositoryRead.getFollowers(testeProfileCerto);
      
    });

    test("Este teste deve retornar um novo int de contribuições", () async {
      final repositoryRead = fakeProfileReadRepository;

      await repositoryRead.getContributions(testeProfileCerto);
      
    });
  });
}
