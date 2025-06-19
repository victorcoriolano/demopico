
import 'package:demopico/core/common/data/enums/collections.dart';
import 'package:demopico/features/external/datasources/firebase/remote/crud_firebase.dart';
import 'package:demopico/features/profile/infra/datasource/firebase_post_datasource.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:test/test.dart';

import '../../../mocks/mocks_post.dart';

void main(){
  group("Deve testar o datasource de postagens ", (){
    late FirebasePostDatasource firebasePostDatasource;
    late FakeFirebaseFirestore firestore;

    setUpAll((){
      firestore = FakeFirebaseFirestore();
      firebasePostDatasource = FirebasePostDatasource(
        crudFirebase: CrudFirebase.test(
          table: Collections.posts, firestoreTest: firestore));
    });

    tearDown(() {
      firestore.clearPersistence();
    });

    test("deve criar um post corretamente", () async {
      final dto = await firebasePostDatasource.createPost(listDto[0]);
      expect(dto, isNotNull);
      expect(dto.data["nome"], "João Silva");
    });

    test("deve retornar uma lista de postagens", ()  async{
      // TODO: implement test
      
    });

     test("deve atualizar uma postagem ", ()  async{
      
      await firestore.collection("posts").doc("123").set(listDto[0].data);
      final dto = await firebasePostDatasource.updatePost(listDto[0].copyWith(data: {"nome": "Tete da Silva"}));;
      expect(dto.data["nome"], "Tete da Silva");
    });

    test("deve retornar uma postagem por id ", ()  async{
      await firestore.collection("posts").doc("123").set(listDto[0].data);
      final dto = await firebasePostDatasource.getPostbyID("123");
      expect(dto.data["nome"], "João Silva");
    });
    
    test("deve deletar uma postagem ", ()  async{
      await firestore.collection("posts").doc("123").set(listDto[0].data);
      

      await firebasePostDatasource.deletePost("123");
      final dataAfterDelete = await firestore.collection("posts").doc("123").get();
      expect(dataAfterDelete.exists, false);
      
    });
    

  });
}