import 'package:demopico/features/profile/presentation/widgets/post_widgets/card_post_widget.dart';
import 'package:flutter/material.dart';

class ContainerPostsWidget extends StatefulWidget {
  const ContainerPostsWidget({super.key});

  @override
  State<ContainerPostsWidget> createState() => _ContainerPostsWidgetState();
}

class _ContainerPostsWidgetState extends State<ContainerPostsWidget> {
  final List<Map<String, String>> posts = [
    {'type': 'photo', 'title': 'Foto 1'},
    {'type': 'photo', 'title': 'Foto 2'},
    {'type': 'photo', 'title': 'Foto 2'},
    {'type': 'photo', 'title': 'Foto 2'},
    {'type': 'photo', 'title': 'Foto 1'},
    {'type': 'photo', 'title': 'Foto 2'},
    {'type': 'photo', 'title': 'Foto 2'},
    {'type': 'photo', 'title': 'Foto 2'},
    {'type': 'photo', 'title': 'Foto 1'},
    {'type': 'photo', 'title': 'Foto 2'},
    {'type': 'photo', 'title': 'Foto 2'},
    {'type': 'photo', 'title': 'Foto 2'},
    {'type': 'video', 'title': 'Vídeo 1'},
    {'type': 'video', 'title': 'Vídeo 2'},
  ];
  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> filteredPosts =
        posts.where((post) => post['type'] == 'photo').toList();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1,
        ),
        itemCount: filteredPosts.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.all(0.8),
              shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.zero,
        ),
            child: Center(
              child: CardPostWidget(imagePath: "assets/images/rayssaLeal.png")
            ),
          );
        },
      ),
    );
  }
}
