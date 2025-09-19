import 'package:demopico/core/common/auth/domain/entities/user_identification.dart';
import 'package:demopico/core/common/auth/domain/value_objects/location_vo.dart';
import 'package:demopico/features/mapa/presentation/controllers/add_pico_view_model.dart';
import 'package:demopico/features/mapa/presentation/widgets/add_pico_modal/primeira_tela.dart';
import 'package:demopico/features/mapa/presentation/widgets/add_pico_modal/quarta_tela.dart';
import 'package:demopico/features/mapa/presentation/widgets/add_pico_modal/segunda_tela.dart';
import 'package:demopico/features/mapa/presentation/widgets/add_pico_modal/terceira_tela.dart';
import 'package:demopico/features/mapa/presentation/widgets/spot_info_widgets/custom_buttons.dart';
import 'package:demopico/features/user/domain/enums/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class ContainerTelas extends StatefulWidget {
  final LatLng latlang;
  final bool expanded;
  const ContainerTelas(
      {super.key, required this.latlang, required this.expanded});

  @override
  State<ContainerTelas> createState() => _ContainerTelasState();
}

class _ContainerTelasState extends State<ContainerTelas> {
  late AuthState? authstate;
  StepsAddPico etapa = StepsAddPico.especificidade;

  void _nextScreen() {
    setState(() {
      etapa = etapa.next();
    });
  }

  void _backScreen() {
    setState(() {
      etapa = etapa.back();
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      authstate = context.read<AuthState>();
      final location = LocationVo(
          latitude: widget.latlang.latitude,
          longitude: widget.latlang.longitude);
      context.read<AddPicoViewModel>().initialize(location);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AddPicoViewModel>(
      builder: (context, provider, child) => Scaffold(
        body: Container(
          color: Colors.black54,
          child: Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              width: MediaQuery.of(context).size.width * 0.95,
              height: MediaQuery.of(context).size.height * 0.95,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius:
                      BorderRadius.circular(12), // Arredondamento das bordas
                  border: Border.all(
                      color: const Color(0xFF8B0000),
                      width: 3), // Borda vermelha
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Expanded(
                        child: switch (etapa){  
                          StepsAddPico.especificidade => EspecificidadeScreen(),
                          StepsAddPico.atributos => SegundaTela(),
                          StepsAddPico.obstaculos => TerceiraTela(),
                          StepsAddPico.detalhesAdicionais => QuartaTela(),
                        }, // Exibe o widget atual
                      ),
                      const SizedBox(height: 10),
                      Visibility(
                        visible: etapa != StepsAddPico.especificidade,
                        child: CustomElevatedButton(
                          onPressed: _backScreen, 
                          textButton: 'Voltar'
                        ),
                      ),
                      const SizedBox(height: 10),
                      CustomElevatedButton(
                        onPressed: provider.isFormValid(etapa) 
                          ? () {
                            etapa == StepsAddPico.detalhesAdicionais
                              ? provider.createSpot(createIdentification(authstate))
                              : _nextScreen();
                          }
                          : provider.showError, 
                        textButton: etapa == StepsAddPico.detalhesAdicionais ? "CRIAR PICO" : "PROSSEGUIR"),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  UserIdentification? createIdentification(AuthState? authstate) {
    switch (authstate){

      case null:
        return null;
      case AuthAuthenticated():
         return UserIdentification(
        id: authstate.user.id, name: authstate.user.displayName.value, photoUrl: authstate.user.profileUser.avatar);
      case AuthUnauthenticated():
        return null;
    }

   
  }
}
