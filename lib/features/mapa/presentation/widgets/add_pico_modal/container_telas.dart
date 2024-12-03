import 'package:demopico/core/common/inject_dependencies.dart';
import 'package:demopico/features/mapa/domain/entities/pico_entity.dart';
import 'package:demopico/features/mapa/presentation/controllers/add_pico_controller.dart';
import 'package:demopico/features/mapa/presentation/controllers/spot_controller.dart';
import 'package:demopico/features/mapa/presentation/widgets/add_pico_modal/primeira_tela.dart';
import 'package:demopico/features/mapa/presentation/widgets/add_pico_modal/quarta_tela.dart';
import 'package:demopico/features/mapa/presentation/widgets/add_pico_modal/segunda_tela.dart';
import 'package:demopico/features/mapa/presentation/widgets/add_pico_modal/terceira_tela.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContainerTelas extends StatefulWidget {
  final double lat;
  final double long;
  final bool expanded;
  const ContainerTelas(
      {super.key,
      required this.lat,
      required this.long,
      required this.expanded});

  @override
  _ContainerTelasState createState() => _ContainerTelasState();
}

class _ContainerTelasState extends State<ContainerTelas> {
  int _currentIndex = 0;
  

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

  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Consumer<AddPicoControllerProvider>(
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
                          color: const Color(0xFF8B0000), width: 3), // Borda vermelha
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
                          if (!(_currentIndex == 0))
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
                                    const Color(0xFF8B0000), // Cor do botão
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 50, vertical: 15),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () async {
                                if(user != null){
                                  if (provider.validarFormulario())  {
                                  final pico = Pico(
                                      imgUrl: provider.urlImage,
                                      modalidade: provider.selectedModalidade,
                                      tipoPico: provider.tipo,
                                      nota: 0.0,
                                      numeroAvaliacoes: 0,
                                      long: widget.long,
                                      lat: widget.lat,
                                      description: provider.descricao,
                                      atributos: provider.atributos,
                                      fotoPico: null,
                                      obstaculos: provider.obstaculos,
                                      utilidades: provider.utilidades,
                                      userCreator: user!.displayName ?? user!.email,
                                      urlIdPico: 'anonimo',
                                      picoName: provider.nomePico);
                                  try  {
                                    await serviceLocator<SpotControllerProvider>()
                                        .createSpot(pico, context);
                                    if(context.mounted){
                                      serviceLocator<SpotControllerProvider>().showAllPico(context);
                                      provider.dispose();
                                      Navigator.pop(context);
                                    }
                                    
                                  } on Exception catch (e) {
                                    print('Erro na boca do balção: $e');
                                    if(context.mounted){
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                "Preencha todos os campos ou insira alguma imagem")));
                                    }
                                    
                                  } catch (e) {
                                    print("Erro desconhecido: $e");
                                  }
                                }
                                }
                                // função para criar o pico
                                if (provider.validarFormulario())  {
                                  final pico = Pico(
                                      imgUrl: provider.urlImage,
                                      modalidade: provider.selectedModalidade,
                                      tipoPico: provider.tipo,
                                      nota: 0.0,
                                      numeroAvaliacoes: 0,
                                      long: widget.long,
                                      lat: widget.lat,
                                      description: provider.descricao,
                                      atributos: provider.atributos,
                                      fotoPico: null,
                                      obstaculos: provider.obstaculos,
                                      utilidades: provider.utilidades,
                                      userCreator: null,
                                      urlIdPico: 'anonimo',
                                      picoName: provider.nomePico);
                                  try  {
                                    await serviceLocator<SpotControllerProvider>()
                                        .createSpot(pico, context);
                                    if(context.mounted){
                                      serviceLocator<SpotControllerProvider>().showAllPico(context);
                                      provider.limpar();
                                      Navigator.pop(context);
                                    }
                                    
                                  } on Exception catch (e) {
                                    print('Erro na boca do balção: $e');
                                    if(context.mounted){
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                "Preencha todos os campos ou insira alguma imagem")));
                                    }
                                    
                                  } catch (e) {
                                    print("Erro desconhecido: $e");
                                  }
                                }
                              },
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
                                print(provider.utilidadesSelecionadas);
                                // chama a proxima página somente se tiver validada
                                if (provider
                                    .validarPaginaAtual(_currentIndex)) {
                                  _nextScreen(); // Chama a função para mudar a tela
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              "Preenche todos as informações"),),);
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
