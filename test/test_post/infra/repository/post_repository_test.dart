import 'package:demopico/core/common/data/enums/collections.dart';
import 'package:demopico/features/external/datasources/firebase/remote/crud_firebase.dart';
import 'package:demopico/features/profile/infra/datasource/firebase_post_datasource.dart';
import 'package:demopico/features/profile/infra/repository/post_repository.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:test/test.dart';

import '../../../mocks/mocks_post.dart';

void main(){
  group("Deve testar o datasource de postagens ", (){
    late FirebasePostDatasource firebasePostDatasource;
    late PostRepository postRepository;
    late FakeFirebaseFirestore firestore;

    setUpAll(() async {
      firestore = FakeFirebaseFirestore();
      firebasePostDatasource = FirebasePostDatasource(
        crudFirebase: CrudFirebase.test(
          collection: Collections.posts, firestoreTest: firestore
        )
      );

      postRepository = PostRepository(postDatasource: firebasePostDatasource);

      await Future.wait([
          firestore.collection("posts").doc("123").set(listDto[0].data),
          firestore.collection("posts").doc("456").set(listDto[1].data),
        ]);
    });

    tearDown(() {
      firestore.clearPersistence();
    });

    test("deve criar um post corretamente", () async {
      final model = await postRepository.createPost(mockPost1);
      expect(model, isNotNull);
      expect(model.nome, "João Silva");
    });

    test("deve retornar uma lista de postagens", ()  async{
      // TODO: implement test
      
    });

     test("deve atualizar uma postagem ", ()  async{
      
      await firestore.collection("posts").doc("123").set(listDto[0].data);
      final dto = await firebasePostDatasource.updatePost(listDto[1]);
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
      
      expect(firestore.collection("posts").doc("123").get(), throwsException);
    });
    

  });
}