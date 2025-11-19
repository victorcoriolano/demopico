import 'package:demopico/core/app/theme/theme.dart';
import 'package:demopico/core/common/auth/domain/entities/user_entity.dart';
import 'package:demopico/features/profile/domain/models/post.dart';
import 'package:demopico/features/profile/presentation/services/verify_is_my.dart';
import 'package:demopico/features/profile/presentation/view_model/post_provider.dart';
import 'package:demopico/features/profile/presentation/object_for_only_view/media_url_item.dart';
import 'package:demopico/features/profile/presentation/widgets/post_widgets/video_player_from_network.dart';
import 'package:demopico/features/user/presentation/controllers/auth_view_model_account.dart';
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
  bool isMypost = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    curtidas = widget.post.curtidas;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final currentUser = context.read<AuthViewModelAccount>().user;
      switch (currentUser) {
        case UserEntity _:
          //final userId = currentUser.id;
          //await context.read<PostProvider>().loadPosts(userId);
          if (mounted) {
            debugPrint("user que postou: ${widget.post.userId}");
            isMypost = VerifyIsMy.isMy(widget.post.userId, context);
            _provider = context.read<PostProvider>();
            urlsItems.addAll(_provider.getMediaItemsFor(widget.post));
            setState(() {});
          }
        case AnonymousUserEntity _:
          // do nothing
          debugPrint("anonimo");
          break;
      }
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

    return Consumer<PostProvider>(builder: (context, provider, child) {
      if (provider.isLoading) {
        return const Center(child: CircularProgressIndicator());
      }

      return Card(
        elevation: 1.5,
        shape: RoundedRectangleBorder(
          
          borderRadius: BorderRadius.circular(18),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal:16, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /// HEADER ─ foto, nome, data
              Row(
                children: [
                  CircleAvatar(
                    radius: 26,
                    backgroundImage: post.avatar != null
                        ? NetworkImage(post.avatar!)
                        : const AssetImage("assets/images/userPhoto")
                            as ImageProvider,
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        post.nome,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '${post.dateTime.day}/${post.dateTime.month}/${post.dateTime.year}',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  if (isMypost)
                    PopupMenuButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      itemBuilder: (_) => [
                        const PopupMenuItem(
                          value: 'edit',
                          child: Row(
                            children: [
                              Icon(Icons.edit_outlined, size: 18),
                              SizedBox(width: 10),
                              Text("Editar"),
                            ],
                          ),
                        ),
                        const PopupMenuItem(
                          value: 'delete',
                          child: Row(
                            children: [
                              Icon(Icons.delete_outline, size: 18),
                              SizedBox(width: 10),
                              Text("Excluir"),
                            ],
                          ),
                        )
                      ],
                      onSelected: (value) async {
                        if (value == 'delete') {
                          await _provider.deletePost(widget.post);
                          if (context.mounted) Navigator.pop(context);
                        }
                      },
                    )
                ],
              ),
      
              const SizedBox(height: 14),
      
              /// DESCRIÇÃO
              if (post.description.isNotEmpty)
                Text(
                  post.description,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[900],
                  ),
                ),
      
              const SizedBox(height: 14),
      
              /// MÍDIAS
              if (urlsItems.isNotEmpty)
                Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: SizedBox(
                        height: screenHeight * 0.70,
                        child: PageView.builder(
                          controller: _pageController,
                          itemCount: urlsItems.length,
                          onPageChanged: (i) =>
                              setState(() => _currentPage = i),
                          itemBuilder: (context, index) {
                            final item = urlsItems[index];
      
                            if (item.contentType == MediaType.image) {
                              return Image.network(
                                item.url,
                                fit: BoxFit.cover,
                                loadingBuilder: (_, child, loading) {
                                  if (loading == null) return child;
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                },
                                errorBuilder: (_, __, ___) =>
                                    const Icon(Icons.broken_image),
                              );
                            }
      
                            if (item.contentType == MediaType.video) {
                              return VideoPlayerFromNetwork(url: item.url);
                            }
      
                            return const Center(
                                child: Text("Mídia não suportada"));
                          },
                        ),
                      ),
                    ),
      
                    const SizedBox(height: 10),
      
                    /// INDICADORES
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(urlsItems.length, (index) {
                        final active = index == _currentPage;
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: active ? 10 : 7,
                          height: active ? 10 : 7,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: active
                                ? Colors.black87
                                : Colors.grey.withOpacity(0.4),
                          ),
                        );
                      }),
                    ),
                  ],
                ),
      
              const SizedBox(height: 16),
      
              /// LOCALIZAÇÃO
              GestureDetector(
                onTap: () {},
                child: Row(
                  children: [
                    const Icon(Icons.location_pin,
                        size: 20, color: Colors.black87),
                    const SizedBox(width: 6),
                    Text(
                      provider.selectedSpotId?.picoName ??
                          "Localização não especificada",
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 13.5,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
      
              const SizedBox(height: 14),
      
              /// AÇÕES (curtir, editar, excluir)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => setState(() {
                          if (!jaCurtiu) {
                            curtidas++;
                          } else {
                            curtidas--;
                          }
                          jaCurtiu = !jaCurtiu;
                        }),
                        child: ImageIcon(
                          const AssetImage(
                              'assets/images/cumprimento_marreta.png'),
                          color: jaCurtiu ? kRed : Colors.black,
                          size: 50,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "$curtidas curtidas",
                        style: const TextStyle(
                          fontSize: 14.5,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}
