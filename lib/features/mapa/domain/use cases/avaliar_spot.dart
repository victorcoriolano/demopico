import 'package:demopico/features/mapa/domain/interfaces/spot_repository.dart';

class AvaliarSpot {
    final SpotRepository notaRepository;

  AvaliarSpot(firebaseNotaRepository, {required this.notaRepository});

  Future<void> executar(List<double> notas) async {
    // Lógica de negócio: calcular média
    if (notas.isEmpty) {
      throw Exception("A lista de notas está vazia.");
    }
    final media = notas.reduce((a, b) => a + b) / notas.length;
    final avaliacoes = notas.length;
  

    // Salvar no repositório (camada de dados)
    await notaRepository.salvarNota(avaliacoes, media);
  }
}