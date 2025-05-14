import 'package:demopico/features/profile/domain/usecases/atualizar_bio_uc.dart';
import 'package:demopico/features/profile/domain/usecases/atualizar_contribuicoes_uc.dart';
import 'package:demopico/features/profile/domain/usecases/atualizar_foto_uc.dart';
import 'package:demopico/features/profile/domain/usecases/atualizar_seguidores_uc.dart';

class ProfileProvider {
  static ProfileProvider? _profileProvider;

  static ProfileProvider get getInstance {
    _profileProvider ??= ProfileProvider(
        atualizarBioUc: AtualizarBioUc.getInstance,
        atualizarContribuicoesUc: AtualizarContribuicoesUc.getInstance,
        atualizarFotoUc: AtualizarFotoUc.getInstance,
        atualizarSeguidoresUc: AtualizarSeguidoresUc.getInstance);
    return _profileProvider!;
  }

  ProfileProvider(
      {required this.atualizarBioUc,
      required this.atualizarContribuicoesUc,
      required this.atualizarFotoUc,
      required this.atualizarSeguidoresUc});

  final AtualizarBioUc atualizarBioUc;
  final AtualizarContribuicoesUc atualizarContribuicoesUc;
  final AtualizarFotoUc atualizarFotoUc;
  final AtualizarSeguidoresUc atualizarSeguidoresUc;
}
