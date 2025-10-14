import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demopico/features/external/datasources/firebase/dto/firebase_dto.dart';
import 'package:demopico/features/profile/infra/datasource/firebase_message_datasourece.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late FakeFirebaseFirestore fakeFirestore;
  late MessageFirestoreDatasource datasource;

  setUp(() {
    fakeFirestore = FakeFirebaseFirestore();
    datasource = MessageFirestoreDatasource(firestore: fakeFirestore);
  });

  group('MessageFirestoreDatasource', () {
    final testUserId = 'user123';
    final testChatId = 'chat456';
    final message1 = {
      'content': 'Hello',
      'dateTime': Timestamp.fromDate(DateTime(2025, 10, 14, 10, 0)),
      'isRead': false,
    };
    final message2 = {
      'content': 'How are you?',
      'dateTime': Timestamp.fromDate(DateTime(2025, 10, 14, 10, 5)),
      'isRead': false,
    };

    group('getMessagesForChat', () {
      test('should return a stream of messages for a given chat ID', () async {
        // Arrange
        await fakeFirestore
            .collection('chats')
            .doc(testChatId)
            .collection('messages')
            .add(message1);
        await fakeFirestore
            .collection('chats')
            .doc(testChatId)
            .collection('messages')
            .add(message2);

        // Act
        final stream = datasource.getMessagesForChat(testChatId);

        // Assert
        // Expects messages to be ordered by dateTime descending
        expect(
          stream,
          emits(
            predicate<List<FirebaseDTO>>((list) {
              return list.length == 2 &&
                  list[0].data['content'] == 'How are you?' &&
                  list[1].data['content'] == 'Hello';
            }),
          ),
        );
      });

      test('should return an empty stream if chat has no messages', () async {
        // Arrange: chat exists but has no messages subcollection
        await fakeFirestore.collection('chats').doc(testChatId).set({});

        // Act
        final stream = datasource.getMessagesForChat(testChatId);

        // Assert
        expect(stream, emits(<FirebaseDTO>[]));
      });
    });

    group('getChatForUser', () {
      test('should return a list of chats the user is a participant in',
          () async {
        // Arrange
        await fakeFirestore.collection('chats').add({
          'participants': [testUserId, 'user_other']
        });
        await fakeFirestore.collection('chats').add({
          'participants': ['user_other_1', 'user_other_2']
        }); // A chat the user is NOT in

        // Act
        final result = await datasource.getChatForUser(testUserId);

        // Assert
        expect(result, isA<List<FirebaseDTO>>());
        expect(result.length, 1);
        expect(result.first.data['participants'], contains(testUserId));
      });

      test('should return an empty list if user is in no chats', () async {
        // Arrange
        await fakeFirestore.collection('chats').add({
          'participants': ['user_other_1', 'user_other_2']
        });

        // Act
        final result = await datasource.getChatForUser(testUserId);

        // Assert
        expect(result, isA<List<FirebaseDTO>>());
        expect(result.isEmpty, isTrue);
      });
    });

    group('sendMessage', () {
      test(
          'should add a message to the messages subcollection and update lastReadMessage',
          () async {
        // Arrange
        await fakeFirestore.collection('chats').doc(testChatId).set({
          'participants': [testUserId]
        });
        final messageDto = FirebaseDTO(id: 'msg1', data: message1);

        // Act
        await datasource.sendMessage(testChatId, messageDto);

        // Assert
        final messagesSnapshot = await fakeFirestore
            .collection('chats')
            .doc(testChatId)
            .collection('messages')
            .get();
        final chatSnapshot =
            await fakeFirestore.collection('chats').doc(testChatId).get();

        expect(messagesSnapshot.docs.length, 1);
        expect(messagesSnapshot.docs.first.data()['content'], 'Hello');
        expect(chatSnapshot.data()?['lastReadMessage']['content'], 'Hello');
      });
    });

    group('readMessage', () {
      test('should update the isRead field of a message to true', () async {
        // Arrange
        final messageDoc = await fakeFirestore
            .collection('chats')
            .doc(testChatId)
            .collection('messages')
            .add({'content': 'Unread message', 'isRead': false});

        final messageDto = FirebaseDTO(id: messageDoc.id, data: {});

        // Act
        await datasource.readMessage(testChatId, messageDto);

        // Assert
        final updatedMessage = await messageDoc.get();
        expect(updatedMessage.data()?['isRead'], isTrue);
      });
    });
    
  });
}