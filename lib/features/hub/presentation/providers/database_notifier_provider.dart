<<<<<<< HEAD:lib/features/hub/infra/providers/database_notifier_provider.dart
import 'package:demopico/features/hub/domain/entities/communique.dart';
import 'package:demopico/features/user/data/models/user.dart';
import 'package:demopico/features/user/data/services/database_service.dart';
import 'package:flutter/material.dart';

class HubProvider extends ChangeNotifier {
  final _db = DatabaseService();
=======
import 'package:demopico/features/hub/infra/services/HubService.dart';
import 'package:demopico/features/hub/domain/entities/communique.dart';
import 'package:flutter/material.dart';

class HubProvider extends ChangeNotifier {
  final HubService hubService;

  HubProvider({required this.hubService});
>>>>>>> 5643e9a5ed114e47b3327da9fe1255e974dc6c54:lib/features/hub/presentation/providers/database_notifier_provider.dart

  void notify() {
    notifyListeners();
  }


  List<Communique> _allCommuniques = [];

  List<Communique> get allCommuniques => _allCommuniques;

  Future<void> postHubCommunique(String text, String type) async {
    await hubService.postHubCommuniqueToFirebase(text, type);
    getAllCommuniques();
  }

  Future<void> getAllCommuniques() async {
    final allCommuniquesFromDb = await hubService.getAllCommuniques();
    _allCommuniques = allCommuniquesFromDb;
    notifyListeners();
  }
}
