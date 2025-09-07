
import 'package:demopico/core/common/collections/collections.dart';
import 'package:demopico/features/external/datasources/firebase/crud_firebase.dart';
import 'package:demopico/features/profile/infra/datasource/firebase_post_datasource.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:test/test.dart';

import '../../../mocks/mocks_post.dart';

void main(){
  group("Deve testar o datasource de postagens ", (){
    late FirebasePostDatasource firebasePostDatasource;
    late FakeFirebaseFirestore firestore;

    setUpAll((){
      firestore = FakeFirebaseFirestore();
      firebasePostDatasource = FirebasePostDatasource(
        crudFirebase: CrudFirebase(
          collection: Collections.posts, firestore: firestore
        )
      );
      firestore.clearPersistence();
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
      await Future.wait([
        firestore.collection("posts").doc("123").set(listDto[0].data),
        firestore.collection("posts").doc("456").set(listDto[1].data),
      ]).then((value) => debugPrint("Criou os documentos"));

      final list = await firebasePostDatasource.getPosts(mockPost1.userId);
      expect(list.length, equals(2));
      expect(list[0].data["nome"], "João Silva");
    });

     test("deve atualizar uma postagem ", ()  async{
      
      await firestore.collection("posts").doc("123").set(listDto[0].data).then( (onData) => debugPrint("Post criado no Firestore fake: ${listDto[0].id}"));
      
      await firestore.collection("posts").get().then((querySnapshot) {
        for (var doc in querySnapshot.docs) {
          debugPrint("Documento no Firestore fake: ${doc.id} com dados: ${doc.data()} \n");
        }
      });

      final dto = await firebasePostDatasource.updatePost(
        mapper.toDTO(update)
      );

      expect(dto.data["description"], "Atualizando descrição do post ${mockPost1.id}");
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