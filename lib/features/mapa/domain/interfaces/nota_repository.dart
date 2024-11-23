import 'package:demopico/features/mapa/domain/entities/pico_entity.dart';

abstract class NotaRepository {
  Future<void> salvarNota(int avaliacoes, double nota);
}
