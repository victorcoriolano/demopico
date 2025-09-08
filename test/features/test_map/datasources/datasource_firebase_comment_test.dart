
import 'package:demopico/core/common/mappers/i_mapper_dto.dart';
import 'package:demopico/features/external/datasources/firebase/dto/firebase_dto_mapper.dart';
import 'package:demopico/features/mapa/data/data_sources/remote/firebase_comment_service.dart';
import 'package:demopico/features/external/datasources/firebase/dto/firebase_dto.dart';
import 'package:demopico/features/mapa/domain/models/comment_model.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:test/test.dart';

void main() {
  group("Serviço de dados dos comentários com firebase", () {

    late FakeFirebaseFirestore fakeFirestore;

    late FirebaseCommentRemoteDataSource service;
    late CommentModel comment;
    late IMapperDto mapperDto;

    setUpAll(() {
      fakeFirestore = FakeFirebaseFirestore();
      service = FirebaseCommentRemoteDataSource(firebaseFirestore: fakeFirestore);
      comment = CommentModel(id: "1",peakId: "1", userId: "userId", content: "teste", timestamp: DateTime.now());
      mapperDto = FirebaseDtoMapper<CommentModel>(
        fromJson: (data, id) => CommentModel.fromJson(data, id),
        toMap: (model) => model.toMap() , 
        getId: (model) => model.id,
      );
    });

    test("Deve salvar um comentário", () async {
      
      final result = await service.create(mapperDto.toDTO(comment));

      expect(result, isA<FirebaseDTO>());
      expect(result.id, isNotEmpty);

    });

    test("Deve Listar comentários com base no id do pico", () async{
      //criando fakes 
      Future.wait([
        fakeFirestore.collection('comments').add({
          'peakId': '1',
          'userId': 'userId',
          'content': 'teste',
          'timestamp': DateTime.now().toIso8601String(),
        }),
        fakeFirestore.collection('comments').add({
          'peakId': '1',
          'userId': 'userId',
          'content': 'teste',
          'timestamp': DateTime.now().toIso8601String(),
        }),
        fakeFirestore.collection('comments').add({
          'peakId': '1',
          'userId': 'userId',
          'content': 'teste',
          'timestamp': DateTime.now().toIso8601String(),
        }),
      ]);

      final result = await service.getBySpotId("1");
      expect(result, isA<List<FirebaseDTO>>());
      expect(result.length, 4); //  3 comentários mais o comentário criado no teste anterior
      
    });

    test("Deve deletar um comentário", () async {
      //criando fakes
      final commentOnDB = await service.create(mapperDto.toDTO(comment));
      await service.delete(commentOnDB.id);
      final result = await service.getBySpotId("2");
      expect(result.length, equals(0)); // 0 comentários do pico 2
    });

    test("Deve atualizar um comentário", () async {
      //criando fakes
      final commentBD = await service.create(mapperDto.toDTO(comment));
      var id = commentBD.id;
      final updateComment = comment.copyWith(content: "teste atualizado", id: id);
        
      await service.update(mapperDto.toDTO(updateComment));
      
      final updated = await service.getBySpotId("1");
      
      expect(updated.last.data['content'], equals("teste atualizado"));

    });
  });
}  