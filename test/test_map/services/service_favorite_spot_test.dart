import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
void main() {
  group("Deve testar o serviço de salvar spot", (){
    late FakeFirebaseFirestore fakeFirestore;
    setUp((){
      fakeFirestore = FakeFirebaseFirestore();
    });

    test("Deve salvar um spot dos favoritos", (){
    });
    test("Deve retornar um lista de spot salvo", (){});
    test("Deve deletar um spot salvo", (){});
    test("Deve retornar limpar a lista de spots", (){});
  });
}