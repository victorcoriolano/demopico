import 'package:demopico/core/app/theme/theme.dart';
import 'package:demopico/core/common/auth/domain/entities/user_entity.dart';
import 'package:demopico/features/profile/presentation/widgets/post_widgets/container_posts_widget.dart';
import 'package:demopico/features/profile/presentation/widgets/post_widgets/container_spots.dart';
import 'package:demopico/features/profile/presentation/widgets/post_widgets/container_videos_widget.dart';
import 'package:flutter/material.dart';

class ProfilePostsWidget extends StatelessWidget {
  final UserEntity user;
  final TabController? controller;
  const ProfilePostsWidget({super.key,required this.controller, required this.user });

  @override
  Widget build(BuildContext context) {
    return 
       Column(
        children: [
          TabBar(
            physics: FixedExtentScrollPhysics(),
            controller: controller,
            padding: EdgeInsets.all(0),
            labelColor: kRed,
            dividerColor: kBlack,
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
                ContainerPostsWidget(user: user,),
                ContainerVideosWidget(),
                ContainerSpots(user: user,),
              ],
            ),
          ),
        ],
    );
  }
}
