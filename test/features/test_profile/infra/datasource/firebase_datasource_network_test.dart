
import 'package:demopico/core/common/files_manager/enums/collections.dart';
import 'package:demopico/features/external/datasources/firebase/crud_firebase.dart';
import 'package:demopico/features/external/datasources/firebase/dto/firebase_dto.dart';
import 'package:demopico/features/profile/domain/models/relationship.dart';
import 'package:demopico/features/profile/infra/datasource/firebase_network_datasource.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:test/test.dart';

import '../../../mocks/mocks_connections.dart';


final mocksConnectionDTO = [
  FirebaseDTO(id: 'id1', data: dummyConnections[0].toJson()),
  FirebaseDTO(id: 'id2', data: dummyConnections[1].toJson()),
  FirebaseDTO(id: 'id3', data: dummyConnections[2].toJson()),
];
void main() {

  group("Deve testar os métodos e relações do user", (){
    late FirebaseNetworkDatasource networkDatasource;
    late FakeFirebaseFirestore fakeFirebaseFirestore;
    late CrudFirebase crudFirebase;
    
    setUp(() async {
      fakeFirebaseFirestore = FakeFirebaseFirestore();
      crudFirebase = CrudFirebase(collection: Collections.connections, firestore: fakeFirebaseFirestore);
      networkDatasource = FirebaseNetworkDatasource(crudFirebase: crudFirebase);

      await fakeFirebaseFirestore.collection(Collections.connections.name).add(
        mocksConnectionDTO[0].data,
      );
    });
    test("Deve criar uma conexão entre user", () async {
      final connection = await networkDatasource.createConnection(mocksConnectionDTO[1]);

      expect(connection, isNotNull);
      expect(connection.id, isNotEmpty);
      expect(connection.data, isNotEmpty);
      expect(connection.data['userID'], equals(mocksConnectionDTO[1].data['userID']));
      expect(connection.data['connectedUserID'], equals(mocksConnectionDTO[1].data['connectedUserID']));
    });
    test("Deve desconectar um user", () async {
      await networkDatasource.disconnectUser(mocksConnectionDTO[1]);

      final docRef = await fakeFirebaseFirestore.collection(Collections.connections.name)
        .doc(mocksConnectionDTO[1].id).get();

      expect(docRef.exists, isFalse);
      });

    test("Deve pegar uma lista de conexões", () async {
      final connections = await networkDatasource.getConnections('requesterUserID','userID1');

      expect(connections, isNotEmpty);
      expect(connections.length, equals(1));
      expect(connections[0].data['userID'], equals('userID1'));
    });

    test("Deve pegar uma lista de requisições de conexão", () async {

      await Future.wait(dummyConnections.map((connection) {
        return fakeFirebaseFirestore.collection(Collections.connections.name).add(
          connection.toJson()
        );
      }));

      final snapshot = await fakeFirebaseFirestore.collection(Collections.connections.name).get();

      debugPrint(snapshot.docs.map((doc) => doc.data()).toList().toString());

      final requests = await networkDatasource.fetchRequestConnections('userID1');

      expect(requests, isNotEmpty);
      expect(requests.length, equals(2));
      expect(requests[0].data['userID'], equals('userID1'));
      expect(requests[0].data['status'], equals(RequestConnectionStatus.pending.name));
    });

    tearDown((){
      fakeFirebaseFirestore.clearPersistence();
    });
  });
}