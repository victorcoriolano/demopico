
import 'package:demopico/features/mapa/presentation/controllers/add_pico_controller.dart';
import 'package:demopico/features/mapa/presentation/widgets/add_pico_modal/primeira_tela.dart';
import 'package:demopico/features/mapa/presentation/widgets/add_pico_modal/quarta_tela.dart';
import 'package:demopico/features/mapa/presentation/widgets/add_pico_modal/segunda_tela.dart';
import 'package:demopico/features/mapa/presentation/widgets/add_pico_modal/terceira_tela.dart';
import 'package:demopico/features/user/domain/models/user.dart';
import 'package:demopico/features/user/presentation/controllers/user_database_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class ContainerTelas extends StatefulWidget {
  final LatLng latlang;
  final bool expanded;
  const ContainerTelas(
      {super.key,
      required this.latlang,
      required this.expanded});

  @override
  State<ContainerTelas> createState() => _ContainerTelasState();
}

class _ContainerTelasState extends State<ContainerTelas> {
  int _currentIndex = 0;
  late UserM? user;

  final List<Widget> _screens = [
    const EspecificidadeScreen(), // Página 1
    const SegundaTela(), // Página 2
    const TerceiraTela(), // Página 3
    const QuartaTela(), // Página 4
  ];

  void _nextScreen() {
    setState(() {
      _currentIndex =
          (_currentIndex + 1) % _screens.length; // Muda para o próximo índice
    });
  }

  void _backScreen() {
    setState(() {
      _currentIndex =
          (_currentIndex - 1) % _screens.length; // Muda para o próximo índice
    });
  }

  @override
  void initState() {
    super.initState();
    user = context.read<UserDatabaseProvider>().user;
    context.read<AddPicoProvider>().setLocation(widget.latlang);
  }

  

  @override
  Widget build(BuildContext context) {
    return Consumer<AddPicoProvider>(
      builder: (context, provider, child) => Scaffold(
        body: Stack(// colocando stack para funcionar direito o positionaded
            children: [
          Positioned.fill(
            child: Container(
              color: Colors.black54, // Fundo semitransparente
              child: Center(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  width: MediaQuery.of(context).size.width * 0.95,
                  height: MediaQuery.of(context).size.height * 0.95,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(
                          12), // Arredondamento das bordas
                      border: Border.all(
                          color: const Color(0xFF8B0000),
                          width: 3), // Borda vermelha
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Expanded(
                            child:
                                _screens[_currentIndex], // Exibe o widget atual
                          ),
                          const SizedBox(height: 10),
                          if (_currentIndex != 0)
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color(0xFF8B0000), // Cor do botão
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 50, vertical: 15),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () {
                                _backScreen(); // Chama a função para mudar a tela
                              },
                              child: const Text('VOLTAR',
                                  style: TextStyle(fontSize: 15)),
                            ),
                          const SizedBox(height: 10),
                          if (_currentIndex == 3)
                            ElevatedButton(
                              
                              style: ElevatedButton.styleFrom(
                                backgroundColor: 
                                    const Color(0xFF8B0000) , // Cor do botão
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 50, vertical: 15),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: provider.validarFormulario() ? () async {
                                
                                await provider.createSpot(user?.name);
                                if( provider.errorCriarPico != null ){
                                  Get.snackbar("Erro ao criar pico", provider.errorCriarPico.toString(),);
                                }
                                if(context.mounted) Navigator.pop(context);
                                
                              } : null,
                              child: const Text('POSTAR PICO',
                                  style: TextStyle(fontSize: 15)),
                            )
                          else
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color(0xFF8B0000), // Cor do botão
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 50,
                                  vertical: 15,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () {
                                // chama a proxima página somente se tiver validada
                                if (provider
                                    .validarPaginaAtual(_currentIndex)) {
                                  _nextScreen(); // Chama a função para mudar a tela
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content:
                                          Text("Preenche todos as informações"),
                                    ),
                                  );
                                }
                              },
                              child: const Text('PROSSEGUIR',
                                  style: TextStyle(fontSize: 15)),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}