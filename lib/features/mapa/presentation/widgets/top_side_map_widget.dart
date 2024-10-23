import 'package:flutter/material.dart';

class TopSideMapWidget extends StatelessWidget implements PreferredSizeWidget {
  const TopSideMapWidget({super.key});
@override
Widget build(BuildContext context) {
  return AppBar(
    automaticallyImplyLeading: false, // resolvendo bug de aparecer seta
    toolbarHeight: 100, // Ajuste a altura da AppBar se necessário
    backgroundColor: Color(0xFF8B0000),
    title: Row(
      mainAxisAlignment: MainAxisAlignment.center, // Centraliza o conteúdo do Row
      children: [
        Expanded(
          child: Container(
            height: 42, // Altura do campo de busca
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
          icon: Icon(Icons.filter_list, color: Colors.white, size: 30,),
          onPressed: () {},
        ),
        /* IconButton(
          icon: Icon(Icons.settings, color: Colors.white,size: 30),
          onPressed: () {
            Scaffold.of(context).openEndDrawer();
          },
        ), */
      ],
    ),
    actions: [
      Builder(builder: (context) => IconButton(
          icon: Icon(Icons.settings, color: Colors.white,size: 30),
          onPressed: () {
            Scaffold.of(context).openEndDrawer();
          },
        ),)
    ],
  );
}
  @override
  Size get preferredSize => const Size.fromHeight(80);
}

