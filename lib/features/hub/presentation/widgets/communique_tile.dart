import 'package:demopico/features/hub/domain/entities/communique.dart';
import 'package:flutter/material.dart';

class CommuniqueTile extends StatefulWidget {
  final Communique post;
  const CommuniqueTile({super.key, required this.post});

  @override
  State<CommuniqueTile> createState() => _CommuniqueTileState();
}

class _CommuniqueTileState extends State<CommuniqueTile> {
  Communique get post => widget.post;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ClipOval(
                clipBehavior: Clip.antiAlias,
                child: Image.network(post.pictureUrl!,
                    width: 40,
                    height: 40,
                    alignment: Alignment.centerLeft,
                    fit: BoxFit.contain, errorBuilder: (BuildContext context,
                        Object exception, StackTrace? stackTrace) {
                  return const Align(
                      alignment: Alignment.centerLeft,
                      child: Icon(Icons.supervised_user_circle, size: 55));
                }),
              ),
              const SizedBox(height: 15),
              SizedBox(
                width: 50,
                child: Text(
                  post.vulgo,
                  softWrap: true,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          const SizedBox(width: 10),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      textDirection: TextDirection.ltr,
                      post.text,
                      maxLines: 10,
                      softWrap: true,
                      textAlign: TextAlign.start,
                      textWidthBasis: TextWidthBasis.longestLine,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(Icons.flag_rounded, size: 30),
              const SizedBox(height: 55),
              post.type != "normal"
                  ? const Icon(Icons.recycling_rounded,
                      color: Color.fromARGB(255, 128, 25, 18))
                  : const SizedBox(
                      height: 0,
                      width: 0,
                    )
            ],
          )
        ],
      ),
    );
  }
}
