import 'package:demopico/core/app/home_page.dart';
import 'package:demopico/core/common/widgets/back_widget.dart';
import 'package:demopico/features/hub/presentation/pages/hub_page.dart';
import 'package:demopico/features/mapa/presentation/pages/map_page.dart';
import 'package:demopico/features/profile/presentation/widgets/edit_field_dialog.dart';
import 'package:demopico/features/profile/presentation/widgets/profile_action_button.dart';
import 'package:demopico/features/profile/presentation/widgets/profile_configure_widget.dart';
import 'package:demopico/features/profile/presentation/widgets/profile_data_widget.dart';
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
    return Scaffold(
        body: Consumer<UserDatabaseProvider>(
            builder: (context, provider, child) => SafeArea(
                child: _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : Container(
                        color: const Color.fromARGB(80, 241, 236, 236),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const CustomBackButton(destination: HomePage(), iconSize: 35,),
                                    ProfileConfigureWidget(
                                        bioController: bioController),
                                  ],
                                ),
                              ),
                              ProfileDataWidget(
                                name: user?.name,
                                avatarUrl: user?.pictureUrl,
                                backgroundUrl: user?.backgroundPicture,
                                description: user?.description,
                                followers: user?.conexoes ?? 0,
                                contributions: user?.picosAdicionados ?? 0,
                              ),
                              const SizedBox(height: 20),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20),
                                child: Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
                                      color: const Color.fromARGB(
                                          29, 248, 248, 248),
                                      border: Border.all(
                                          color: Colors.black, width: 1),
                                    ),
                                    width: MediaQueryData.fromView(
                                                    View.of(context))
                                                .size
                                                .width >
                                            600
                                        ? 400
                                        : null,
                                    alignment: Alignment.center,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        ProfileActionButton(
                                          icon: Icons.add_card,
                                          label: 'Fazer Comunicado',
                                          onPressed: () {
                                            Get.to(() => const HubPage(),
                                                curve: Curves.easeOutSine,
                                                transition:
                                                    Transition.upToDown);
                                          },
                                        ),
                                        ProfileActionButton(
                                          icon: Icons.add_location,
                                          label: 'Adicionar um Pico',
                                          onPressed: () {
                                            Get.to(() => const MapPage(),
                                                curve: Curves.easeInOutSine,
                                                transition:
                                                    Transition.leftToRight);
                                          },
                                        ),
                                        ProfileActionButton(
                                          icon: Icons.edit,
                                          label: 'Editar Descrição',
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return EditFieldDialog(
                                                  title: 'Editar descrição',
                                                  controller: bioController,
                                                  onConfirm: () {
                                                    setState(() {
                                                      user?.description =
                                                          bioController
                                                              .text;
                                                    });
                                                    bioController.clear();
                                                  },
                                                );
                                              },
                                            );
                                          },
                                        ),
                                      ],
                                    )),
                              ),
                              const Spacer(),
                            ])))));
  }
}
