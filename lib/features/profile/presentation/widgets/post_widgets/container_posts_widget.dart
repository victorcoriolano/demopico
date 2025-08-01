import 'package:demopico/features/profile/presentation/provider/post_provider.dart';
import 'package:demopico/features/profile/presentation/widgets/post_widgets/card_post_widget.dart';
import 'package:demopico/features/user/presentation/controllers/user_database_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContainerPostsWidget extends StatefulWidget {
  const ContainerPostsWidget({super.key});

  @override
  State<ContainerPostsWidget> createState() => _ContainerPostsWidgetState();
}

class _ContainerPostsWidgetState extends State<ContainerPostsWidget> {
  late PostProvider _postProvider;

  @override
  void initState() {
    super.initState();
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _postProvider = context.read<PostProvider>();
      _getPost();
    });
  }

  Future<void> _getPost() async {
    final userId = context.read<UserDatabaseProvider>().user?.id;
    await _postProvider.loadPosts(userId!);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PostProvider>(builder: (context, provider, child) {
      if (provider.isLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      else if (provider.post.isEmpty) {
        return const Center(
          child: Text('Nenhum post encontrado'),
        );
      }

      final listPost = provider.post;
      
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 1,
          ),
          itemCount: listPost.length,
          itemBuilder: (context, index) {
            return Card(
              margin: const EdgeInsets.all(0.8),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
              child: Center(child: CardPostWidget(post: listPost[index])),
            );
          },
        ),
      );
    });
  }
}
