import 'package:demopico/features/profile/presentation/widgets/profile_navigator_widget.dart';
import 'package:flutter/material.dart';

class UserControllerPage extends StatefulWidget {
  const UserControllerPage({super.key});

  @override
  State<UserControllerPage> createState() => _UserControllerPageState();
}

class _UserControllerPageState extends State<UserControllerPage>{
  ProfileNavigatorWidget profileNavigatorWidget = ProfileNavigatorWidget();
  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      body: Column(
        children: [
         

       
        ],
      ),
      bottomNavigationBar: ProfileNavigatorWidget(),
    );
  }
}

