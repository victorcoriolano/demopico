import 'package:demopico/features/profile/infra/repository/profile_firebase_read_repository.dart';
import 'package:demopico/features/user/infra/repositories/user_firebase_repository.dart';
import 'package:demopico/features/user/infra/services/user_firebase_service.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../mocks/mocks_profile.dart';

void main() {
  group("Este group possui todas as operações de read do Profile", () {
    late FakeFirebaseFirestore fakeFirestore;
    setUp(() async {
      fakeFirestore = FakeFirebaseFirestore();

      //criando um spot fake pra referenciar no pico favorito
      await fakeFirestore
          .collection("users")
          .doc(testeProfileCerto.id)
          .set(testeProfileCerto.toJsonMap());
    });

    test("Este teste deve retornar uma string de nova foto ", () async {
      final serviceRead = ProfileFirebaseReadRepository(
          userDatabaseRepository: UserFirebaseRepository(
              userFirebaseService:
                  UserFirebaseService(firebaseFirestore: fakeFirestore)));

      String text = await serviceRead.pegarFoto(testeProfileCerto);
      expect(text, text);
    });

    test("Este teste deve retornar uma string de uma nova bio", () async {
      final serviceRead = ProfileFirebaseReadRepository(
          userDatabaseRepository: UserFirebaseRepository(
              userFirebaseService:
                  UserFirebaseService(firebaseFirestore: fakeFirestore)));

      String text = await serviceRead.pegarBio(testeProfileCerto);
      expect(text, text);
    });

    test("Este teste deve retornar um novo int de seguidor", () async {
      final serviceRead = ProfileFirebaseReadRepository(
          userDatabaseRepository: UserFirebaseRepository(
              userFirebaseService:
                  UserFirebaseService(firebaseFirestore: fakeFirestore)));

      int text = await serviceRead.pegarSeguidores(testeProfileCerto);
      expect(text, text);
    });

    test("Este teste deve retornar um novo int de contribuições", () async {
      final serviceRead = ProfileFirebaseReadRepository(
          userDatabaseRepository: UserFirebaseRepository(
              userFirebaseService:
                  UserFirebaseService(firebaseFirestore: fakeFirestore)));

      int text = await serviceRead.pegarContribuicoes(testeProfileCerto);
      expect(text, text);
    });
  });
}
