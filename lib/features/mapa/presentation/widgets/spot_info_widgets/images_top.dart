import 'package:cached_network_image/cached_network_image.dart';
import 'package:demopico/core/app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImagesTop extends StatefulWidget {
  final List<String> images;
  final bool isMine;
  const ImagesTop({super.key, required this.images, required this.isMine});

  @override
  State<ImagesTop> createState() => _ImagesTopState();
}

class _ImagesTopState extends State<ImagesTop> {
  
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      itemCount: widget.images.length,
      onPageChanged: (int page) {
        setState(() {
          currentIndex = page;
        });
      },
      itemBuilder: (context, pagePosition) {
        return Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  icon: const Icon(Icons.close, color: kAlmostWhite),
                  padding: const EdgeInsets.all(10),
                  iconSize: 36,
                  onPressed: () {
                    Get.back(); // Retorna para a tela anterior
                  },
                ),
              ],
            ),
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              clipBehavior: Clip.hardEdge,
              child: CachedNetworkImage(
                imageUrl: widget.images[pagePosition],
                fit: BoxFit.cover,
                width: double.infinity,
                progressIndicatorBuilder: (context, url, progress) => CircularProgressIndicator(value: progress.progress),
                errorWidget: (context, url, error) => Center(
                  child: Column(
                    children: [
                      Icon(Icons.broken_image_rounded),
                      Text(url),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
