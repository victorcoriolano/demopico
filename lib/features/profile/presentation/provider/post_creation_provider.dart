
import 'package:demopico/core/common/data/models/file_model.dart';
import 'package:flutter/material.dart';

class PostCreationProvider extends ChangeNotifier {
  final List<FileModel> _filesModels = [];
  String _description = '';
  String? _selectedSpotId;

  List<FileModel> get filesModels => _filesModels;
  String get description => _description;
  String? get selectedSpotId => _selectedSpotId;

  void removeMedia(int index) {
    if (index >= 0 && index < _filesModels.length) {
      _filesModels.removeAt(index);
      notifyListeners();
    }
  }

  void updateDescription(String newDescription) {
    _description = newDescription;
    notifyListeners();
  }

  void selectSpot(String? spotId) {
    _selectedSpotId = spotId;
    notifyListeners();
  }
}
  