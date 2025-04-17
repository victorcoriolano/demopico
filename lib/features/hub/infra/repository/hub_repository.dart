import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demopico/features/external/datasources/firestore.dart';
import 'package:demopico/features/hub/domain/entities/communique.dart';
import 'package:demopico/features/hub/infra/interfaces/i_hub_repository.dart';

class HubRepository implements IHubRepository{
 
    final Firestore firestore;
    HubRepository({required this.firestore});

  @override
  Future<void> createCommunique(Communique communique) async {
      try{
        firestore.getInstance.collection('communique').add(communique.toJsonMap());
      }
     catch(e) {
      throw Exception('Error ao criar comunicado');
    }
  }
      @override
      Future<void> deleteCommunique(String id) {
    // TODO: implement deleteCommunique
    throw UnimplementedError();
      }
    
      @override
      Future<List<Communique?>> listCommuniques()async {
        try{
         QuerySnapshot querySnapshot = await firestore.getInstance
          .collection('communique')
          .orderBy('timestamp', descending: true)
          .get();

      return querySnapshot.docs.map((doc) => Communique.fromDocument(doc)).toList();
        }catch(e){
          throw Exception('Não foi possível listar os comunicados');
        }
      }
    
      @override
      Future<void> updateCommunique(Communique communique) {
    // TODO: implement updateCommunique
    throw UnimplementedError();
      }
  }
    