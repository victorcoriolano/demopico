import 'package:demopico/features/profile/presentation/widgets/post_widgets/container_posts_widget.dart';
import 'package:demopico/features/profile/presentation/widgets/post_widgets/container_videos_widget.dart';
import 'package:flutter/material.dart';

class ProfilePostsWidget extends StatelessWidget {
  final TabController? controller;
  const ProfilePostsWidget({super.key,required this.controller});

  @override
  Widget build(BuildContext context) {
    return 
       Column(
        children: [
          TabBar(
            controller: controller,
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
              controller: controller,
              children: <Widget>[
                ContainerPostsWidget(),
                ContainerVideosWidget(),
                Center(child: Text("It's sunny here")),
              ],
            ),
          ),
        ],
    );
  }
}
