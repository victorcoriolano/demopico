import 'package:demopico/features/profile/domain/models/post.dart';
import 'package:demopico/features/profile/presentation/widgets/post_widgets/card_post_widget.dart';
import 'package:flutter/material.dart';

class ContainerPostsWidget extends StatefulWidget {
  const ContainerPostsWidget({super.key});

  @override
  State<ContainerPostsWidget> createState() => _ContainerPostsWidgetState();
}

class _ContainerPostsWidgetState extends State<ContainerPostsWidget> {

  Post post = Post(
    nome: 'João Silva',
    userId: 'user123',
    postId: 'post123',
    urlUserPhoto: 'https://example.com/user_photo.jpg',
    description: 'Curtindo um dia de sol no parque!',
    urlPhotos: [
      'https://firebasestorage.googleapis.com/v0/b/pico-skatepico.appspot.com/o/spots_images%2Fimages%2FDegrau%20no%20Centro%20.jpg?alt=media&token=2dda3751-c51e-4981-875d-5ab7c92cbded',
      'https://firebasestorage.googleapis.com/v0/b/pico-skatepico.appspot.com/o/spots_images%2Fimages%2FPico%20top.jpg?alt=media&token=1a489ff1-0c61-4e31-b793-117c46ced16f'
    ],
    dateTime: DateTime.now(),
    curtidas: 42,
  );

    Post post1 = Post(
    nome: 'João Silva',
    userId: 'user123',
    postId: 'post123',
    urlUserPhoto: 'https://example.com/user_photo.jpg',
    description: 'Curtindo um dia de sol no parque!',
    urlPhotos: [
      'https://firebasestorage.googleapis.com/v0/b/pico-skatepico.appspot.com/o/spots_images%2Fimages%2FPico%20top.jpg?alt=media&token=1a489ff1-0c61-4e31-b793-117c46ced16',

    ],
    dateTime: DateTime.now(),
    curtidas: 42,
  );

    List<Post> listPost = [];

    void inserir(){
      listPost.clear();
      listPost.add(post);
      listPost.add(post1);
      debugPrint(listPost.length.toString());
    }

  

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
    inserir();
    List<Map<String, String>> filteredPosts =
        posts.where((post) => post['type'] == 'photo').toList();
        debugPrint(filteredPosts.length.toString());
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1,
        ),
        itemCount: listPost.length,
        itemBuilder: (context, index) {
          return  Card(
            margin: const EdgeInsets.all(0.8),
              shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.zero,
        ),
            child: Center(
              child: CardPostWidget(post: listPost[index])
            ),
          );
        },
      ),
    );
  }
}
