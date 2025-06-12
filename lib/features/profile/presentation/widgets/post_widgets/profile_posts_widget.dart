import 'package:demopico/features/profile/presentation/widgets/post_widgets/container_posts_widget.dart';
import 'package:flutter/material.dart';

class ProfilePostsWidget extends StatelessWidget {
  const ProfilePostsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Column(
        children: [
          TabBar(
            padding: EdgeInsets.all(0),
            labelColor: Color.fromARGB(255, 139, 0, 0),
            dividerColor: Color.fromARGB(64, 0, 0, 0),
            labelPadding: EdgeInsets.all(0),
            indicatorPadding: EdgeInsets.all(0),
            tabs: <Widget>[
              Tab(icon: Icon(Icons.photo_library, size: 30)),
              Tab(icon: Icon(Icons.video_camera_back, size: 30)),
              Tab(icon: Icon(Icons.map, size: 30)),
              
            ],
          ),
          Expanded(
            child: TabBarView(
              children: <Widget>[
                ContainerPostsWidget(),
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
