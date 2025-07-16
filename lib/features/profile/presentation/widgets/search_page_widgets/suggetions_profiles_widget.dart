import 'package:flutter/material.dart';

class SuggestionProfilesWidget extends StatefulWidget {
  final String name;
  final String imageUrl;

  const SuggestionProfilesWidget({
    super.key,
    required this.name,
    required this.imageUrl,
  });

  @override
  State<SuggestionProfilesWidget> createState() => _SuggestionProfilestState();
}

class _SuggestionProfilestState extends State<SuggestionProfilesWidget> {
  bool isFollowing = false;

  void toggleFollow() {
    setState(() {
      isFollowing = !isFollowing;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      margin: const EdgeInsets.symmetric(vertical:4, horizontal: 4),
      width: screenWidth * 0.9,
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,              
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(widget.imageUrl),
                  radius: 20,
                ),
                   SizedBox(
                    height: 8,
                   ),
               Text(widget.name, style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
               ),),
              ],
            ),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: toggleFollow,
            style: ElevatedButton.styleFrom(
              backgroundColor: isFollowing ? Colors.grey : Colors.blue,
            ),
            child: Text(isFollowing ? 'Seguindo' : 'Seguir'),
          ),
        ],
      ),
    );
  }
}
