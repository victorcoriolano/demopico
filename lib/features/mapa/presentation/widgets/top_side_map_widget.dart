import 'package:flutter/material.dart';

class TopSideMapWidget extends StatelessWidget implements PreferredSizeWidget {
  const TopSideMapWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 100.0,
      backgroundColor: const Color.fromARGB(255, 103, 0, 0),
      foregroundColor: Colors.white,
      actions: [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            // Ação para busca
          },
        ),
        IconButton(
          icon: const Icon(Icons.filter_list),
          onPressed: () {
            // Ação para filtro
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);
}
