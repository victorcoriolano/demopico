import 'package:demopico/features/mapa/data/models/pico_model.dart';
import 'package:demopico/features/mapa/domain/interfaces/i_filter_spot_.dart';

class FirebaseRepositoryFilter implements IFilterSpot{
  @override
  Future<List<PicoModel>?> getSpotsByAttribute(List<String> attribute) {
    // TODO: implement getSpotsByAttribute
    throw UnimplementedError();
  }

  @override
  Future<List<PicoModel>?> getSpotsByModality(String modality) {
    // TODO: implement getSpotsByModality
    throw UnimplementedError();
  }

  @override
  Future<List<PicoModel>?> getSpotsByType(String tipo) {
    // TODO: implement getSpotsByType
    throw UnimplementedError();
  }

  @override
  Future<List<PicoModel>?> getSpotsByUtility(List<String> utility) {
    // TODO: implement getSpotsByUtility
    throw UnimplementedError();
  }
}