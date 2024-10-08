import 'package:demopico/features/mapa/domain/entities/pico_entity.dart';
import 'package:demopico/features/mapa/presentation/widgets/add_pico_modal/primeira_tela.dart';
import 'package:demopico/features/mapa/presentation/widgets/add_pico_modal/quarta_tela.dart';
import 'package:demopico/features/mapa/presentation/widgets/add_pico_modal/segunda_tela.dart';
import 'package:demopico/features/mapa/presentation/widgets/add_pico_modal/terceira_tela.dart';
import 'package:flutter/material.dart';

class ContainerTelas extends StatefulWidget {
  const ContainerTelas({super.key});

  @override
  _ContainerTelasState createState() => _ContainerTelasState();
}

class _ContainerTelasState extends State<ContainerTelas> {
  int _currentIndex = 0;
/*   final pico = Pico(
    nota: nota, 
    numeroAvaliacoes: numeroAvaliacoes, 
    long: long, 
    lat: lat, 
    description: description, 
    atributos: atributos, 
    fotoPico: fotoPico, 
    obstaculos: obstaculos, 
    utilidades: utilidades, 
    userCreator: userCreator, 
    urlIdPico: urlIdPico, 
    picoName: picoName); */

  final List<Widget> _screens = [
    EspecificidadeScreen(), // Página 1
    SegundaTela(), // Página 2
    TerceiraTela(), // Página 3
    QuartaTela(), // Página 4
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
  Widget build(BuildContext context) {
    return Positioned.fill(
        child: Container(
            color: Colors.black54, // Fundo semitransparente
            child: Center(
                child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              width: MediaQuery.of(context).size.width * 0.95,
              height: MediaQuery.of(context).size.height * 0.95,
              child: Container(
                
                width: double.infinity,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color:Colors.grey[200],
                  borderRadius:
                      BorderRadius.circular(12), // Arredondamento das bordas
                  border: Border.all(
                      color: Color(0xFF8B0000), width: 3), // Borda vermelha
                ),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Expanded(
                        child: _screens[_currentIndex], // Exibe o widget atual
                      ),
                      SizedBox(height: 10),
                      
                      if (!(_currentIndex == 0))
  ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: Color(0xFF8B0000), // Cor do botão
      foregroundColor: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    onPressed: () {
      _backScreen(); // Chama a função para mudar a tela
    },
    child: Text('VOLTAR', style: TextStyle(fontSize: 15)),
  ),
                      SizedBox(height: 10),
                      if (_currentIndex == 3)
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF8B0000), // Cor do botão
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(
                              horizontal: 50, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          _nextScreen(); // Chama a função para mudar a tela
                        },
                        child:
                            Text('POSTAR PICO', style: TextStyle(fontSize: 15)),
                      )else
                       ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF8B0000), // Cor do botão
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(
                              horizontal: 50, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          _nextScreen(); // Chama a função para mudar a tela
                        },
                        child:
                            Text('PROSSEGUIR', style: TextStyle(fontSize: 15)),
                      ),
                    ],
                  ),
                ),
              ),
            ))));
  }
}
