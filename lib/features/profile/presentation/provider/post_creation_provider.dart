
import 'package:flutter/material.dart';

class PostCreationProvider extends ChangeNotifier {
  final List<String> _mediaPaths = [];
  String _description = '';
  String? _selectedSpotId;

  List<String> get mediaPaths => _mediaPaths;
  String get description => _description;
  String? get selectedSpotId => _selectedSpotId;

  void removeMedia(int index) {
    if (index >= 0 && index < _mediaPaths.length) {
      _mediaPaths.removeAt(index);
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
  