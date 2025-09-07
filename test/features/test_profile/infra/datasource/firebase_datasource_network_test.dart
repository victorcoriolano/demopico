
import 'package:demopico/core/common/collections/collections.dart';
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
    
    setUpAll(() async {
      fakeFirebaseFirestore = FakeFirebaseFirestore();
      crudFirebase = CrudFirebase(collection: Collections.connections, firestore: fakeFirebaseFirestore);
      networkDatasource = FirebaseNetworkDatasource(crudFirebase: crudFirebase);
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
      await networkDatasource.deleteConnection(mocksConnectionDTO[1]);

      final docRef = await fakeFirebaseFirestore.collection(Collections.connections.name)
        .doc(mocksConnectionDTO[1].id).get();

      expect(docRef.exists, isFalse);
      });

    test("Deve pegar uma lista de conexões aceitas", () async {
      await fakeFirebaseFirestore.collection(Collections.connections.name)
        .doc(mocksConnectionDTO[1].id).set(mocksConnectionDTO[1].data).then((onData) => debugPrint("Conexão criada no Firestore fake: ${mocksConnectionDTO[1].id}"));

      await fakeFirebaseFirestore.collection(Collections.connections.name).get().then((querySnapshot) {
        for (var doc in querySnapshot.docs) {
          debugPrint("Documento no Firestore fake: ${doc.id} com dados: ${doc.data()} \n");
        }
      });

      final connections = await networkDatasource.getRelactionships(fieldRequest: "requesterUserID.id", valueID: "userID1", fieldOther: "status", valorDoStatus: RequestConnectionStatus.accepted.name);

      expect(connections, isNotEmpty);
      expect(connections.length, equals(1));
      expect(connections[0].data['requesterUserID'], equals(dummyConnections[1].requesterUser.toJson()));
    });

    test("Deve atualizar uma conexão", () async {
      await fakeFirebaseFirestore.collection(Collections.connections.name)
        .doc(mocksConnectionDTO[0].id).set(mocksConnectionDTO[0].data);
      
      final connectionToUpdate = mocksConnectionDTO[0];
      connectionToUpdate.data['status'] = RequestConnectionStatus.accepted.name;

      final updatedConnection = await networkDatasource.updateConnection(connectionToUpdate);

      expect(updatedConnection, isNotNull);
      expect(updatedConnection.id, equals(connectionToUpdate.id));
      expect(updatedConnection.data['status'], equals(RequestConnectionStatus.accepted.name));
    });

    tearDown((){
      fakeFirebaseFirestore.clearPersistence();
    });
  });
}