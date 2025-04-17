import 'package:demopico/features/hub/infra/daos/HubFirebaseDAO.dart';
import 'package:demopico/features/hub/infra/interfaces/IHubRepository.dart';
import 'package:demopico/features/hub/domain/entities/communique.dart';

class HubRepository implements IHubRepository{
  final HubFirebaseDAO dao;

  HubRepository({required this.dao});

  @override
  Future<void> createCommunique(Object obj) async {
    await dao.create(obj);
  }

  @override
  Future<void> deleteCommunique(String id) {
    // TODO: implement deleteCommunique
    throw UnimplementedError();
  }

  @override
  Future<List<Communique>?> listCommuniques() async {
    Future<List<Communique>?> lista  = await dao.getAllObj() as Future<List<Communique>?>;
    return lista;
    }
    
      @override
      Future<void> updateCommunique(Object obj) {
    // TODO: implement updateCommunique
    throw UnimplementedError();
      }
    
   
  }
  

