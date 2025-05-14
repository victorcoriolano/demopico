
import 'package:demopico/features/mapa/data/services/firebase_comment_service.dart';
import 'package:demopico/features/mapa/domain/entities/comment.dart';
import 'package:demopico/features/mapa/domain/models/comment_model.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:test/test.dart';

void main() {
  group("Serviço de dados dos comentários com firebase", () {

    late FakeFirebaseFirestore fakeFirestore;
    late FirebaseCommentService service;

    setUpAll(() {
      fakeFirestore = FakeFirebaseFirestore();
      service = FirebaseCommentService(fakeFirestore);
    });

    test("Deve salvar um comentário", () async {
      
      final result = await service.addComment(Comment(peakId: "1", userId: "userId", content: "teste", timestamp: DateTime.now()));

      expect(result, isA<CommentModel>());
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

      final result = await service.getCommentsByPeak("1");
      expect(result, isA<List<CommentModel>>());
      expect(result.length, 4); //  3 comentários mais o comentário criado no teste anterior
      
    });

    test("Deve deletar um comentário", () async {
      //criando fakes
      final comment = await service.addComment(Comment(peakId: "2", userId: "userId", content: "teste", timestamp: DateTime.now()));
      await service.deleteComment(comment.id);
      final result = await service.getCommentsByPeak("2");
      expect(result.length, equals(0)); // 0 comentários do pico 2
    });

    test("Deve atualizar um comentário", () async {
      //criando fakes
      final comment = await service.addComment(Comment(peakId: "1", userId: "userId", content: "teste", timestamp: DateTime.now()));
      final updatedComment = comment.copyWith(content: "teste atualizado");
        
      final result = await service.updateComment(updatedComment);
      expect(result.content, "teste atualizado");
    });
  });
}  