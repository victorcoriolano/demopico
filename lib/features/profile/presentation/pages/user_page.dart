import 'package:demopico/core/app/home_page.dart';
import 'package:demopico/core/common/widgets/back_widget.dart';
import 'package:demopico/features/profile/presentation/widgets/post_widgets/profile_posts_widget.dart';
import 'package:demopico/features/profile/presentation/widgets/profile_bottom_side_data_widget.dart';
import 'package:demopico/features/profile/presentation/widgets/profile_configure_widget.dart';
import 'package:demopico/features/profile/presentation/widgets/profile_top_side_data_widget.dart';
import 'package:demopico/features/user/domain/models/user.dart';
import 'package:demopico/features/user/presentation/controllers/auth_user_provider.dart';
import 'package:demopico/features/user/presentation/controllers/user_database_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  late UserM? user;
  String? currentUserId;

  bool _isLoading = true;

  final TextEditingController bioController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadUser();
    });
  }

  Future<void> _loadUser() async {
    final providerAuth = Provider.of<AuthUserProvider>(context, listen: false);
    final providerDatabase =
        Provider.of<UserDatabaseProvider>(context, listen: false);

    String? uid = providerAuth.pegarId();

    if (uid == null) {
      setState(() {
        _isLoading = true;
      });

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: const Text('User not found.'),
          actions: [
            TextButton(
              onPressed: () {
                Get.to(() => const HomePage());
              },
              child: const Text('OK'),
            )
          ],
        ),
      );
      return;
    }
    currentUserId = uid;
    await providerDatabase.retrieveUserProfileData(uid);

    if (providerDatabase.user == null) {
      setState(() {
        _isLoading = true;
      });
      if (mounted) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Error'),
            content: const Text('User not found.'),
            actions: [
              TextButton(
                onPressed: () {
                  Get.to(() => const HomePage());
                },
                child: const Text('OK'),
              )
            ],
          ),
        );
      }
      return;
    } else {
      setState(() {
        user = providerDatabase.user!;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Consumer<UserDatabaseProvider>(
            builder: (context, provider, child) => SafeArea(
                child: _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : Container(
                        padding: const EdgeInsets.all(0),
                        margin: const EdgeInsets.all(0),
                        height: double.infinity,
                        color: const Color.fromARGB(80, 243, 240, 240),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: screenHeight * 0.40,
                                padding: const EdgeInsets.all(0),
                                margin: const EdgeInsets.all(0),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 4.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          const CustomBackButton(
                                            iconSize: 30,
                                            destination: HomePage(),
                                          ),
                                          Text(
                                            user!.name ??
                                                'Nome de usuário não encontrado...',
                                            style: const TextStyle(
                                                fontSize: 22,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          ProfileConfigureWidget(
                                              bioController: bioController),
                                        ],
                                      ),
                                    ),
                                    ProfileTopSideDataWidget(
                                      avatarUrl: user?.pictureUrl,
                                      backgroundUrl: user?.backgroundPicture,
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(0),
                                margin: const EdgeInsets.all(0),
                                height: screenHeight * 0.56,
                                child: SingleChildScrollView(
                                    child: Column(
                                  children: [
                                    ProfileBottomSideDataWidget(
                                      description: user?.description,
                                      followers: user?.conexoes ?? 0,
                                      contributions:
                                          user?.picosAdicionados ?? 0,
                                    ),
                                    Container(
                                      padding: const EdgeInsets.all(0),
                                      height: screenHeight * 0.57
                                      ,
                                      child: const ProfilePostsWidget(),
                                      
                                    ),
                                  
                                  ],
                                )),
                              ),
                            ])))));
  }
}
