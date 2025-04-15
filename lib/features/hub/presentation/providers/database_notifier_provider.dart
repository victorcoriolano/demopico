import 'package:demopico/features/hub/infra/services/HubService.dart';
import 'package:demopico/features/hub/domain/entities/communique.dart';
import 'package:flutter/material.dart';

class HubProvider extends ChangeNotifier {
  final HubService hubService;

  HubProvider({required this.hubService});

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
