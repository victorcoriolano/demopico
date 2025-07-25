
import 'package:demopico/features/denunciar/denunciar_service_firebase.dart';
import 'package:demopico/features/denunciar/denuncia_model.dart';

class DenunciaUseCase {
  final DenunciarServiceFirebase denunciarService;
  DenunciaUseCase(this.denunciarService);

  Future<void> execulteDenuncia(DenunciaModel denuncia)async{
    try{
      await denunciarService.salvarDenuncia(denuncia);

    }catch (e){
      throw Exception("Erro ao salvar denuncia: $e");
    }
  }
}