import 'package:demopico/core/app/home_page.dart';
import 'package:demopico/features/hub/presentation/pages/hub_page.dart';
import 'package:demopico/features/mapa/presentation/pages/map_page.dart';
import 'package:demopico/features/user/domain/models/user.dart';
import 'package:demopico/features/user/presentation/controllers/auth_user_provider.dart';
import 'package:demopico/features/user/presentation/controllers/user_database_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class UserPage extends StatefulWidget {
  const UserPage({ super.key});

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

    if (uid == null || user == null) {
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

    await providerDatabase.retrieveUserProfileData(uid);
    if (providerDatabase.user == null) {
      setState(() {
        _isLoading = true;
      });
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
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
                        clipBehavior: Clip
                            .none, // permite que o avatar ultrapasse o container
                        children: [
                          Container(
                            width: double.infinity,
                            height: 190,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: user!.backgroundPicture != null &&
                                        user!.backgroundPicture != ''
                                    ? NetworkImage(user!.backgroundPicture!)
                                    : const AssetImage(
                                            "assets/images/backgroundPadrao.jpeg")
                                        as ImageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: -55,
                            left: MediaQuery.of(context).size.width / 2 - 55,
                            child: CircleAvatar(
                              radius: 60, // tamanho do "fundo branco"
                              backgroundColor: Colors.white,
                              child: ClipOval(
                                child: Image.network(
                                  user!.pictureUrl!,
                                  width: 110,
                                  height: 110,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Row(
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
                                  color: Colors.white,
                                  splashRadius: 0.5,
                                  tooltip: "Voltar",
                                  splashColor: null,
                                  focusColor: null,
                                  hoverColor: null,
                                  iconSize: 60,
                                ),
                                IconButton(
                                    onPressed: () {
                                      //Aplicar funcionalidade de settings
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: const Text('Configurações',
                                                  style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 0, 0, 0),
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              content: SizedBox(
                                                height: 200,
                                                width: 100,
                                                child: ListView(
                                                  shrinkWrap: true,
                                                  itemExtent: 50,
                                                  children: [
                                                    ListTile(
                                                        title: const Text(
                                                            'Sobre o Aplicativo'),
                                                        onTap: () {
                                                          Navigator.pop(
                                                              context);
                                                          Navigator.pushReplacement(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          const AboutPage()));
                                                        }),
                                                    ListTile(
                                                        title: const Text(
                                                            'Fazer Logout'),
                                                        onTap: () {
                                                          showDialog(
                                                              context: context,
                                                              builder:
                                                                  (BuildContext
                                                                      context) {
                                                                return AlertDialog(
                                                                    title: const Text(
                                                                        'Logout'),
                                                                    content:
                                                                        const Text(
                                                                            'Tem certeza que deseja sair da sua conta?'),
                                                                    actions: [
                                                                      TextButton(
                                                                          onPressed:
                                                                              () {
                                                                            Navigator.of(context).pop();
                                                                          },
                                                                          child:
                                                                              const Text(
                                                                            'Cancelar',
                                                                            style:
                                                                                TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                                                                          )),
                                                                      TextButton(
                                                                          child: const Text(
                                                                              'Sair'),
                                                                          onPressed:
                                                                              () async {
                                                                            await context.read<AuthUserProvider>().logout();
                                                                            Get.offAll(() => const HomePage(),
                                                                                transition: Transition.rightToLeftWithFade);
                                                                          })
                                                                    ]);
                                                              });
                                                        })
                                                  ],
                                                ),
                                              ),
                                              actions: [
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: const Text(
                                                      'Voltar',
                                                      style: TextStyle(
                                                          color: Color.fromARGB(
                                                              255,
                                                              255,
                                                              255,
                                                              255)),
                                                    )),
                                              ],
                                            );
                                          });
                                    },
                                    icon: const Icon(Icons.settings),
                                    tooltip: "Configurações",
                                    iconSize: 35,
                                    color: Colors.white)
                              ],
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 70),
                      Text(
                        user!.name != null
                            ? user!.name!
                            : 'Usuário não encontrado...',
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
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
                      const SizedBox(height: 30),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            color: const Color.fromARGB(176, 196, 196, 196),
                            border: Border.all(color: Colors.black, width: 1),
                          ),
                          width: MediaQueryData.fromView(View.of(context))
                                      .size
                                      .width >
                                  600
                              ? 400
                              : null,
                          alignment: Alignment.center,
                          child: Text(user!.description!,
                              style: const TextStyle(
                                fontSize: 12,
                              )),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              color: const Color.fromARGB(176, 196, 196, 196),
                              border: Border.all(color: Colors.black, width: 1),
                            ),
                            width: MediaQueryData.fromView(View.of(context))
                                        .size
                                        .width >
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
                                              transition:
                                                  Transition.leftToRight);
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
                                        icon: const Icon(
                                          Icons.edit_note,
                                          color: Colors.black,
                                        ),
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
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child: const Text(
                                                          'Cancelar',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black),
                                                        )),
                                                    TextButton(
                                                      onPressed: () {
                                                        if (bioController
                                                            .text.isNotEmpty) {
                                                          setState(() {
                                                            user?.description =
                                                                bioController
                                                                    .text;
                                                          });
                                                          //databaseProvider
                                                          //            .updateUserBio(
                                                          //              bioController.text);
                                                          bioController.clear();
                                                          Navigator.of(context)
                                                              .pop();
                                                        }
                                                      },
                                                      child: const Text(
                                                          'Salvar',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black)),
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
                      ),
                      const Spacer(),
                    ],
                  )),
      ),
    );
  }
}

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          foregroundColor: Colors.white,
          title: const Text('Sobre'),
          titleTextStyle: const TextStyle(color: Colors.black),
          iconTheme: const IconThemeData(color: Colors.black)),
      body: const Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Sobre:'),
          SizedBox(height: 30),
          Text(
              "Desenvolvido em 2024 \n Aplicativo de Geomídia para localização de pontos de interesse."),
          SizedBox(height: 30),
          Text('Elenco de desenvolvedores:'),
          Text(
              'Gabriel Pires, Arthur Selingin, Enzo Hiroshi, Victor Coriolano'),
          Text('Contato:'),
          Text('Email: picoskatepico@gmail.com'),
          Text('Todos os Direitos Reservados.')
        ],
      )),
    );
  }
}
