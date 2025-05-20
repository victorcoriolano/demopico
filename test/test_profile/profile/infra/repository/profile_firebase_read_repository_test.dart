
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../mocks/mocks_profile.dart';

void main() {
  group("Este group possui todas as operações de read do Profile", () async {
late FakeFirebaseFirestore fakeFirestore;
    setUp(() async {
      fakeFirestore = FakeFirebaseFirestore();

      //criando um spot fake pra referenciar no pico favorito
      await fakeFirestore
          .collection("users")
          .doc(testeProfileCerto.id)
          .set(testeProfileCerto.toJsonMap());
  });

  test("Este teste deve retornar uma string de nova foto ", () async{

  });
  
  test("Este teste deve retornar", () async{

  });
  
  test("Este teste deve retornar", () async{

  });
  
  test("Este teste deve retornar", () async{

  });

});}