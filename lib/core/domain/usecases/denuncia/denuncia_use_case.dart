
import 'package:demopico/core/common/denunciar/denunciar_service_firebase.dart';
import 'package:demopico/core/domain/entities/denuncia_model.dart';

class DenunciaUseCase {
  final DenunciarServiceFirebase denunciarService;
  DenunciaUseCase(this.denunciarService);

  Future<void> execulteDenuncia(DenunciaModel denuncia)async{
    try{
      await denunciarService.salvarDenuncia(denuncia);

    }catch (e){
      print("Erro aou denunciar: $e");
    }
  }
}