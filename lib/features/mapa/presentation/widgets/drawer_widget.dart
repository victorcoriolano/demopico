import 'package:demopico/app/home_page.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        padding: EdgeInsets.all(16.0), // Espaçamento interno do menu
        color: Colors.white, // Cor de fundo do Drawer
        child: ListView(
          padding: EdgeInsets.zero, // Remove o padding padrão
          children: [
            
            // Botão Configurar Mapa
            MenuItem(
              icon: Icons.map, // Ícone para Configurar Mapa
              text: 'CONFIGURAR MAPA', // Texto do botão
              onPressed: () {
                // Ação ao clicar (adicione a funcionalidade necessária)
                Navigator.of(context).pop(); // Fecha o Drawer
              },
            ),
            // Botão Picos Salvos
            MenuItem(
              icon: Icons.bookmark, // Ícone para Picos Salvos
              text: 'PICOS SALVOS', // Texto do botão
              onPressed: () {
                // Ação ao clicar (adicione a funcionalidade necessária)
                Navigator.of(context).pop(); // Fecha o Drawer
              },
            ),
            // Botão Histórico
            MenuItem(
              icon: Icons.history, // Ícone para Histórico
              text: 'HISTÓRICO', // Texto do botão
              onPressed: () {
                // Ação ao clicar (adicione a funcionalidade necessária)
                Navigator.of(context).pop(); // Fecha o Drawer
              },
            ),
            // Botão Home
            MenuItem(
              icon: Icons.home, // Ícone para Home
              text: 'HOME', // Texto do botão
              onPressed: () {
                // Navega de volta para a tela inicial
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  final IconData icon; // Ícone do item
  final String text; // Texto do item
  final VoidCallback onPressed; // Função a ser chamada ao pressionar o item

  // Construtor do MenuItem
  MenuItem({
    required this.icon,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF8B0000)), // Ícone do item
      title: Text(text, style: const TextStyle(color: Colors.black)), // Texto do item em preto
      onTap: onPressed, // Ação a ser realizada ao pressionar o item
    );
  }
}