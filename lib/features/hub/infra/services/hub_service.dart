import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demopico/features/external/datasources/firebase/firestore.dart';
import 'package:demopico/features/hub/domain/entities/communique.dart';
import 'package:demopico/features/hub/domain/interfaces/i_hub_service.dart';

class HubService implements IHubService {
  static HubService? _hubService;
  final FirebaseFirestore firestore;

  HubService({required this.firestore});

  static HubService get getInstance {
    _hubService ??= HubService(firestore: Firestore.getInstance);
    return _hubService!;
  }

  @override
  Future<void> createCommunique(Communique communique) async {
    try {
      firestore.collection('communique').add(communique.toJsonMap());
    } catch (e) {
      throw Exception('Error ao criar comunicado');
    }
  }

  @override
  Future<void> deleteCommunique(String id) {
    throw UnimplementedError();
  }

  @override
  Future<List<Communique>> listCommuniques() async {
    try {
      QuerySnapshot querySnapshot = await firestore
          .collection('communique')
          .orderBy('timestamp', descending: true)
          .get();

      return querySnapshot.docs
          .map((doc) => Communique.fromDocument(doc))
          .toList();
    } catch (e) {
      throw Exception('Não foi possível listar os comunicados');
    }
  }

  @override
  Future<void> updateCommunique(Communique communique) {
    throw UnimplementedError();
  }
}
