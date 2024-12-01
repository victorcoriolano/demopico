import 'package:demopico/app/home_page.dart';
import 'package:demopico/features/hub/presentation/pages/hub_page.dart';
import 'package:demopico/features/mapa/presentation/pages/map_page.dart';
import 'package:demopico/features/user/data/models/user.dart';
import 'package:demopico/features/user/data/services/auth_service.dart';
import 'package:demopico/features/user/presentation/controllers/database_notifier_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:provider/provider.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  late final databaseProvider =
      Provider.of<DatabaseProvider>(context, listen: false);

  UserM? user;
  String? currentUserId;

  bool _isLoading = true;

  final TextEditingController bioController = TextEditingController();

  @override
  void initState() {
    loadUser();
    super.initState();
  }

  Future<void> loadUser() async {
    currentUserId = AuthService().currentUser?.uid;

    if (currentUserId == null) {
      setState(() {
        _isLoading = true;
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: const Text('Error'),
                  content: const Text('User not logged in.'),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Get.to(() => const HomePage());
                        },
                        child: const Text('OK'))
                  ],
                ));
      });
      return;
    }

    user = await databaseProvider.retrieveUserProfileData(currentUserId!);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          Get.to(() => const HomePage(),
                              popGesture: true,
                              preventDuplicates: true,
                              curve: Curves.easeInBack,
                              transition: Transition.leftToRight);
                        },
                        icon: const Icon(Icons.arrow_left),
                        iconSize: 60,
                      ),
                      IconButton(
                        onPressed: () {
                          //Aplicar funcionalidade de settings
                          null;
                        },
                        icon: const Icon(Icons.settings),
                        iconSize: 35,
                      )
                    ],
                  ),
                  SizedBox(
                      child: user?.pictureUrl != null
                          ? CircleAvatar(
                              radius: 50,
                              backgroundImage: null,
                              backgroundColor: Colors.grey.shade200,
                            )
                          : const IconButton.filled(
                              onPressed: null,
                              icon: Icon(Icons.nature_people_rounded),
                              iconSize: 100,
                            )),
                  const SizedBox(height: 20),
                  Text(
                    user!.name != null
                        ? user!.name!
                        : 'Usuário não encontrado...',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('${user?.conexoes} \n Seguidores',
                          textAlign: TextAlign.center),
                      Text('${user?.picosAdicionados}\n Contribuições',
                          textAlign: TextAlign.center),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      color: const Color.fromARGB(176, 196, 196, 196),
                      border: Border.all(color: Colors.black, width: 1),
                    ),
                    width:
                        MediaQueryData.fromView(View.of(context)).size.width >
                                600
                            ? 400
                            : null,
                    alignment: Alignment.center,
                    child: Text(user!.description!,
                        style: const TextStyle(
                          fontSize: 12,
                        )),
                  ),
                  const SizedBox(height: 20),
                  Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        color: const Color.fromARGB(176, 196, 196, 196),
                        border: Border.all(color: Colors.black, width: 1),
                      ),
                      width:
                          MediaQueryData.fromView(View.of(context)).size.width >
                                  600
                              ? 400
                              : null,
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.add_card),
                                onPressed: () {
                                  Get.to(() => const HubPage(),
                                      curve: Curves.easeOutSine,
                                      transition: Transition.upToDown);
                                },
                              ),
                              const Text(
                                'Fazer Comunicado',
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              )
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              IconButton(
                                  icon: const Icon(Icons.add_location),
                                  onPressed: () {
                                    Get.to(() => const MapPage(),
                                        curve: Curves.easeInOutSine,
                                        transition: Transition.leftToRight);
                                  }),
                              const Text(
                                'Adicionar um Pico',
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              )
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              IconButton(
                                  icon: const Icon(Icons.edit_note),
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text(
                                                'Editar descrição',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 18)),
                                            content: TextField(
                                              controller: bioController,
                                            ),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: const Text(
                                                    'Cancelar',
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  )),
                                              TextButton(
                                                onPressed: () {
                                                  if (bioController
                                                      .text.isNotEmpty) {
                                                    setState(() {
                                                      user?.description =
                                                          bioController.text;
                                                    });
                                                    databaseProvider
                                                        .updateUserBio(
                                                            bioController.text);
                                                    bioController.clear();
                                                    Navigator.of(context).pop();
                                                  }
                                                },
                                                child: const Text('Salvar',
                                                    style: TextStyle(
                                                        color: Colors.black)),
                                              )
                                            ],
                                          );
                                        });
                                  }),
                              const Text(
                                'Editar Descrição',
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              )
                            ],
                          )
                        ],
                      )),
                  const Spacer(),
                ],
              ),
      )),
    );
  }
}
