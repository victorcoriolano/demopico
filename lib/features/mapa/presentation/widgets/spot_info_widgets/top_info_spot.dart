import 'package:cached_network_image/cached_network_image.dart';
import 'package:demopico/core/app/theme/theme.dart';
import 'package:demopico/core/common/widgets/glass_widget.dart';
import 'package:demopico/features/mapa/presentation/pages/map_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TopInfoSpot extends StatefulWidget {
  final List<String> images;
  final bool isMine;
  final VoidCallback onPressedDelete;
  const TopInfoSpot({super.key, required this.images, required this.isMine, required this.onPressedDelete});

  @override
  State<TopInfoSpot> createState() => _TopInfoSpotState();
}

class _TopInfoSpotState extends State<TopInfoSpot> {
  late final PageController _pageController;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Stack(
        children: [
          widget.images.isEmpty
              ? Center(
                  child: Text("Sem Imagens disponíveis"),
                )
              : PageView.builder(
                  controller: _pageController,
                  itemCount: widget.images.length,
                  onPageChanged: (int page) {
                    setState(() {
                      currentIndex = page;
                    });
                  },
                  itemBuilder: (context, pagePosition) {
                    return Container(
                      decoration: const BoxDecoration(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(30)),
                      ),
                      clipBehavior: Clip.hardEdge,
                      child: CachedNetworkImage(
                        imageUrl: widget.images[pagePosition],
                        fit: BoxFit.cover,
                        width: double.infinity,
                        progressIndicatorBuilder: (context, url, progress) =>
                            CircularProgressIndicator(value: progress.progress),
                        errorWidget: (context, url, error) => Center(
                          child: Column(
                            children: [
                              Icon(Icons.broken_image_rounded),
                              Text(url),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
          Align(
            alignment: Alignment.topRight,
            child: Container(
              margin: EdgeInsets.all(12),
              height: 200,
              child: GlassWidget(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.close, color: kRed),
                      padding: const EdgeInsets.all(10),
                      iconSize: 36,
                      onPressed: () {
                        Get.back(); // Retorna para a tela anterior
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.map, color: kRed),
                      padding: const EdgeInsets.all(10),
                      iconSize: 36,
                      onPressed: () {
                        Get.to(() => MapPage()); // Retorna para a tela anterior
                      },
                    ),
                    Visibility(
                      visible: widget.isMine,
                      child: IconButton(
                      icon: const Icon(Icons.delete, color: kRed),
                      padding: const EdgeInsets.all(10),
                      iconSize: 36,
                      onPressed: widget.onPressedDelete,
                    ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(widget.images.length, (index) {
                final isActive = currentIndex == index;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.only(bottom: 12, right: 6),
                  width: isActive ? 12 : 8,
                  height: isActive ? 12 : 8,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isActive ? kBlack : kMediumGrey),
                );
              }),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: const EdgeInsets.only(top: 10),
              height: 5,
              width: 80,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 240, 238, 238),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
