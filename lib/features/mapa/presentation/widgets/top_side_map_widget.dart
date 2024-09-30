import 'package:flutter/material.dart';

class TopSideMapWidget extends StatelessWidget implements PreferredSizeWidget {
  const TopSideMapWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: Color(0xFF8B0000),
        title: Row(
          children: [
            Expanded(
              child: Container(
                height: 40, // Ajuste da altura da barra de pesquisa
                child: TextField(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 10), // Centraliza o conteúdo verticalmente
                    hintText: 'Buscar Picos',
                    prefixIcon: Icon(Icons.search, color: Colors.grey), // Ícone ajustado para centralizar melhor
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(width: 10), // Espaçamento entre a barra de busca e os ícones
            IconButton(
              icon: Icon(Icons.filter_list, color: Colors.white),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.settings, color: Colors.white),
              onPressed: () {},
            ),
          ],
        ),
      );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);
}

