import 'package:demopico/core/app/theme/theme.dart';
import 'package:demopico/core/common/auth/domain/entities/user_identification.dart';
import 'package:demopico/features/profile/presentation/pages/profile_page_user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class CollectivesMembersWidgets extends StatefulWidget {
  final List<UserIdentification> members;

  const CollectivesMembersWidgets({super.key, required this.members});

  @override
  State<CollectivesMembersWidgets> createState() => _CollectivesMembersWidgetsState();
}

class _CollectivesMembersWidgetsState extends State<CollectivesMembersWidgets> {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
                      title: const Text('Membros do Coletivo'),
                      backgroundColor: kBlack,
                    ),
                    backgroundColor: kBlack,
      body: ListView.builder(
      
        itemCount: widget.members.length,
        itemBuilder: (context, index) {
          final member = widget.members[index];
          return ListTile(
            onTap: () {
              Get.to(() => ProfilePageUser(), arguments: member.id);
            },
            style: ListTileStyle.drawer,
            hoverColor: kDarkGrey.withValues(alpha: 0.5),
            
            leading: CircleAvatar(
              backgroundImage: NetworkImage(member.profilePictureUrl ?? ''),
            ),
            title: Text(member.name),
            titleTextStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          );
        },
      ),
    );
  }
}