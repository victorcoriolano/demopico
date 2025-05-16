import 'package:demopico/features/profile/infra/repository/profile_firebase_read_repository.dart';
import 'package:demopico/features/profile/infra/service/profile_firebase_update_service.dart';
import 'package:demopico/features/user/infra/repositories/user_firebase_repository.dart';
import 'package:demopico/features/user/infra/services/user_firebase_service.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';

import 'package:flutter_test/flutter_test.dart';

import '../../../../mocks/mocks_profile.dart';

void main() {
  group('Teste update profile data', () {
    late FakeFirebaseFirestore fakeFirestore;
    setUp(() async {
      fakeFirestore = FakeFirebaseFirestore();

      //criando um spot fake pra referenciar no pico favorito
      await fakeFirestore
          .collection("users")
          .doc(testeProfileCerto.id)
          .set(testeProfileCerto.toJsonMap());
    });

    test('Este teste deve subir uma nova bio e retorna-la', () async {
      final serviceUpdate =
          ProfileFirebaseUpdateService(firestore: fakeFirestore);

      final serviceRead = ProfileFirebaseReadRepository(
          userDatabaseRepository: UserFirebaseRepository(
              userFirebaseService:
                  UserFirebaseService(firebaseFirestore: fakeFirestore)));
      String novaBio = 'newText';

      serviceUpdate.atualizarBio(novaBio, testeProfileCerto.id!);

      final result = await serviceRead.pegarBio(testeProfileCerto.id!);
      expect(result, novaBio);
    });
  });
}
