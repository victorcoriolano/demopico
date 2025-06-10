import 'package:flutter/material.dart';

class ProfilePostWidget extends StatelessWidget {
  const ProfilePostWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      initialIndex: 1,
      length: 3,
      child: Column(
        children: [
          Divider(color: Color.fromARGB(54, 0, 0, 0)),
          TabBar(
            labelColor: Color.fromARGB(255, 139, 0, 0),
            dividerColor: Color.fromARGB(0, 255, 255, 255),
            tabs: <Widget>[
              Tab(icon: Icon(Icons.photo_library, size: 30,)),
              Tab(icon: Icon(Icons.video_camera_back, size: 30)),
              Tab(icon: Icon(Icons.map, size: 30)),
              
            ],
          ),
          Divider(color: Color.fromARGB(54, 0, 0, 0)),
          Expanded(
            child: TabBarView(
              children: <Widget>[
                Center(child: Text("It's cloudy here")),
                Center(child: Text("It's rainy here")),
                Center(child: Text("It's sunny here")),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
