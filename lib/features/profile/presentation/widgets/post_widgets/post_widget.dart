import 'package:demopico/features/profile/domain/models/post.dart';
import 'package:demopico/features/profile/presentation/provider/post_provider.dart';
import 'package:demopico/features/profile/presentation/view_objects/media_url_item.dart';
import 'package:demopico/features/profile/presentation/widgets/post_widgets/video_player_from_network.dart';
import 'package:demopico/features/user/presentation/controllers/user_database_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostWidget extends StatefulWidget {
  final Post post;

  const PostWidget({super.key, required this.post});

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  int _currentPage = 0;
  late final PageController _pageController;
  bool jaCurtiu = false;
  int curtidas = 0;
  late final PostProvider _provider;
  final urlsItems = [];
  bool isMypost = true;
  

  @override
  void initState() {
    super.initState();    
    _pageController = PageController();
    curtidas = widget.post.curtidas;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      isMypost = context.read<UserDatabaseProvider>().user!.isMy(widget.post.userId);
      _provider = Provider.of(context, listen: false);
      urlsItems.addAll(_provider.getMediaItemsFor(widget.post));
      setState(() {});
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final post = widget.post;
    final screenHeight = MediaQuery.of(context).size.height;
    


    return Card(
      margin: const EdgeInsets.all(12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header com foto e nome
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(post.urlUserPhoto),
                  radius: 24,
                ),
                const SizedBox(width: 12),
                Text(post.nome,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16)),
                const Spacer(),
                Text(
                  '${post.dateTime.day}/${post.dateTime.month}/${post.dateTime.year}',
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Descrição
            Text(post.description),
            const SizedBox(height: 12),

            // Fotos com PageView
            
              Column(
              children: [
                SizedBox(
                  height: screenHeight * 0.6,
                  child: PageView.builder(
                    itemCount: urlsItems.length,
                    itemBuilder: (context, index) {
                      debugPrint("post");
                      var itemUrl = urlsItems[index];
                      if (itemUrl.contentType == MediaType.image){
                        return ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          itemUrl.url,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          loadingBuilder: (contex, child, loadBuilder) {
                            if (loadBuilder == null) return child;
                            return Center(child: CircularProgressIndicator(),);
                          },
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.broken_image),
                        ),
                      );
                      }
                      else if (itemUrl.contentType == MediaType.video) {
                        return VideoPlayerFromNetwork(
                          url: itemUrl.url 
                        );
                      }
                      else {
                        return Center(child: Text("Não suportado"),);
                      }
                    },
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() => _currentPage = index);
                    },
                  ),
                ),
                const SizedBox(height: 12),
                // Indicador de página
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(urlsItems.length, (index) {
                    final isActive = _currentPage == index;
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: isActive ? 12 : 8,
                      height: isActive ? 12 : 8,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isActive
                            ? Colors.black87
                            : Colors.grey.withOpacity(0.5),
                      ),
                    );
                  }),
                ),
              ],
                              ),

            const SizedBox(height: 16),

            // Curtidas
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      if (!jaCurtiu) {
                        curtidas++;
                        jaCurtiu = true;
                      } else {
                        curtidas--;
                        jaCurtiu = false;
                      }
                    });
                  },
                  child: ImageIcon(
                    AssetImage('assets/images/cumprimento_marreta.png'),
                    color: jaCurtiu ? Colors.red : Colors.grey,
                    size: 80,
                  ),
                ),
                const SizedBox(width: 8),
                Text('$curtidas curtidas'),
                Visibility(
                  visible: isMypost,
                  child: Positioned(
                    child: IconButton(
                      onPressed: () {
                        _provider.deletePost(widget.post);
                      }, 
                      icon: Icon(Icons.delete_outline),),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
