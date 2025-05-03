import 'package:demopico/features/mapa/data/models/pico_model.dart';

//interface para o filtro de spots
abstract class IFilterSpot {
  Future<List<PicoModel>?> getSpotsByType(String tipo);
  Future<List<PicoModel>?> getSpotsByUtility(List<String> utility);
  Future<List<PicoModel>?> getSpotsByModality(String modality);
  Future<List<PicoModel>?> getSpotsByAttribute(List<String> attribute);
}