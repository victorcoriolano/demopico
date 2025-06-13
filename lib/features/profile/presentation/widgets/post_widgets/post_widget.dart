import 'package:demopico/features/profile/domain/models/post.dart';
import 'package:flutter/material.dart';

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

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
      curtidas = widget.post.curtidas;
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
            if (post.urlPhotos.isNotEmpty)
              Column(
                children: [
                  SizedBox(
                    height: screenHeight * 0.6,
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: post.urlPhotos.length,
                      onPageChanged: (index) {
                        setState(() => _currentPage = index);
                      },
                      itemBuilder: (context, index) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            post.urlPhotos[index],
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.broken_image),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Indicador de página
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(post.urlPhotos.length, (index) {
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
      child: Image.asset(
        'assets/images/cumprimento_marreta.png',
        width: 60,
        height: 60,
      ),
    ),
    const SizedBox(width: 8),
    Text('$curtidas curtidas'),
  ],
),

          ],
        ),
      ),
    );
  }
}
